import 'package:em_church_client/model/request/request_login_model.dart';

abstract class LoginEvent {}

class Login extends LoginEvent {
  final RequestLoginModel data;
  Login(this.data);
}
