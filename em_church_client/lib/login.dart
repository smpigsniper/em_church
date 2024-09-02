import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:em_church_client/api_request.dart';
import 'package:em_church_client/blocs/login/login_blocs.dart';
import 'package:em_church_client/blocs/login/login_events.dart';
import 'package:em_church_client/blocs/login/login_states.dart';
import 'package:em_church_client/global_variable.dart';
import 'package:em_church_client/model/request/request_login_model.dart';
import 'package:em_church_client/model/response/response_login_model.dart';
import 'package:em_church_client/widget/cust_elevated_button.dart';
import 'package:em_church_client/widget/cust_text_field.dart';

class Loging extends StatefulWidget {
  const Loging({super.key});

  @override
  State<Loging> createState() => _LogingState();
}

class _LogingState extends State<Loging> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  late String _email = "";
  late String _accessToken = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final email = await _secureStorage.read(key: 'email');
      final accessToken = await _secureStorage.read(key: 'accessToken');

      setState(() {
        _email = email ?? "";
        _accessToken = accessToken ?? "";
      });

      if (_email.isNotEmpty && _accessToken.isNotEmpty) {
        _refreshToken(_email);
      }
    } catch (e) {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connection Problem'),
          content: const Text('There was an error loading the data. Please try again later.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _refreshToken(String email) async {
    try {
      final requestLoginModel = RequestLoginModel(email: email, password: "");
      final response = await ApiRequest.postRequest(
        "${GlobalVariable.apiIP}api/users/login",
        "",
        requestLoginModel.toJson(),
      );

      final responseLoginModel = ResponseLoginModel.fromJson(jsonDecode(response));
      await _secureStorage.write(key: "accessToken", value: responseLoginModel.data.accessToken);
      // ignore: invalid_use_of_visible_for_testing_member, use_build_context_synchronously
      BlocProvider.of<LoginBlocs>(context).emit(LoginLoaded(responseLoginModel));
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member, use_build_context_synchronously
      BlocProvider.of<LoginBlocs>(context).emit(LoginError());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBlocs, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoaded) {
            if (state.data.status == 1) {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route route) => false);
            }
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login failed"),
              ),
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is LoginLoading;
          String reason = state is LoginLoaded && state.data.status != 1 ? state.data.reason : "";

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: _loginInfo(isLoading, reason: reason),
          );
        },
      ),
    );
  }

  Widget _loginInfo(bool loading, {String reason = ""}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _loginTextField(),
        const SizedBox(height: 20),
        _passwordTextField(),
        const SizedBox(height: 10),
        if (reason.isNotEmpty) _responseReason(reason),
        if (loading) const Center(child: CircularProgressIndicator()),
        if (!loading)
          CustElevatedButton(
            text: "Login",
            onPressed: () {
              final loginModel = RequestLoginModel(
                email: _emailTextEditingController.text,
                password: _passwordTextEditingController.text,
              );
              _loginButtonPress(loginModel);
            },
          ),
      ],
    );
  }

  Widget _responseReason(String reason) {
    return Text(
      reason,
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _loginTextField() {
    return CustTextField(
      text: 'Email',
      controller: _emailTextEditingController,
    );
  }

  Widget _passwordTextField() {
    return CustTextField(
      text: 'Password',
      controller: _passwordTextEditingController,
      hideText: true,
    );
  }

  void _loginButtonPress(RequestLoginModel loginModel) async {
    BlocProvider.of<LoginBlocs>(context).add(Login(loginModel));
  }
}
