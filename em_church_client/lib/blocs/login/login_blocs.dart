import 'package:bloc/bloc.dart';
import 'package:em_church_client/blocs/login/login_events.dart';
import 'package:em_church_client/blocs/login/login_states.dart';
import 'package:em_church_client/model/response/response_login_model.dart';
import 'package:em_church_client/repositories/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginBlocs extends Bloc<LoginEvent, LoginStates> {
  late ResponseLoginModel responseData;
  late LoginResponse data;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  LoginBlocs(this.data) : super(LoginInit()) {
    on<LoginEvent>((event, emit) async {
      if (event is Login) {
        emit(LoginLoading());
        responseData = await data.loginData(event.data);
        if (responseData.status == 1) {
          _secureStorage.write(key: "email", value: responseData.data['email']);
          _secureStorage.write(key: "accessToken", value: responseData.data['accessToken']);
          _secureStorage.write(key: "id", value: responseData.data['id']);
          _secureStorage.write(key: "is_admin", value: responseData.data['is_admin']);
        }
        emit(LoginLoaded(responseData));
      }
    });
  }
}
