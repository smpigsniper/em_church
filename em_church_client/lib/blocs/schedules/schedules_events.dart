import 'package:em_church_client/model/request/request_schedules_model.dart';

abstract class SchedulesEvent {}

class GetSchedules extends SchedulesEvent {
  final RequestSchedulesModel data;
  final String token;
  GetSchedules(this.data, this.token);
}
