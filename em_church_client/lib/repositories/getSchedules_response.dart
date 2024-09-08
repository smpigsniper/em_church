import 'dart:convert';

import 'package:em_church_client/api_request.dart';
import 'package:em_church_client/global_variable.dart';
import 'package:em_church_client/model/request/request_schedules_model.dart';
import 'package:em_church_client/model/response/response_schedules_model.dart';

abstract class GetSchedulesRepository {
  Future<ResponseSchedulesModel> schedulesData(RequestSchedulesModel requestData, String token);
}

class GetschedulesResponse extends GetSchedulesRepository {
  @override
  Future<ResponseSchedulesModel> schedulesData(RequestSchedulesModel requestData, String token) async {
    try {
      String responseData = await ApiRequest.postRequest(
        "${GlobalVariable.apiIP}api/schedule/getSchedule",
        token,
        requestData.toJson(),
      );
      return ResponseSchedulesModel.fromJson(
        jsonDecode(responseData),
      );
    } catch (e) {
      throw Exception('Failed to Get Schedules Data');
    }
  }
}
