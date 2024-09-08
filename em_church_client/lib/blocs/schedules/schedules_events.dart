import 'package:em_church_client/model/request/request_schedules_model.dart';

abstract class SchedulesEvents {}

class GetSchedules extends SchedulesEvents {
  final RequestSchedulesModel data;
  final String token;
  GetSchedules(this.data, this.token);
}
