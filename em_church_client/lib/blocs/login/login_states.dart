import 'package:em_church_client/model/response/response_login_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginStates {}

class LoginInit extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginLoaded extends LoginStates {
  final ResponseLoginModel data;
  LoginLoaded(this.data);
}

class LoginError extends LoginStates {}
