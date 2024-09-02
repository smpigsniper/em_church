import 'dart:convert';

import 'package:em_church_client/api_request.dart';
import 'package:em_church_client/global_variable.dart';
import 'package:em_church_client/model/request/request_login_model.dart';
import 'package:em_church_client/model/response/response_login_model.dart';

abstract class LoginRepository {
  Future<ResponseLoginModel> loginData(RequestLoginModel requestData);
}

class LoginResponse extends LoginRepository {
  @override
  Future<ResponseLoginModel> loginData(RequestLoginModel requestData) async {
    try {
      String responseData = await ApiRequest.postRequest(
        "${GlobalVariable.apiIP}api/users/login",
        "",
        requestData.toJson(),
      );
      return ResponseLoginModel.fromJson(
        jsonDecode(responseData),
      );
    } catch (e) {
      // Handle exceptions or logging
      throw Exception('Failed to login: $e');
    }
  }
}
