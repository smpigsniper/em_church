import 'package:em_church_client/model/response/response_schedules_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SchedulesStates {}

class SchedulesInit extends SchedulesStates {}

class SchedulesLoading extends SchedulesStates {}

class SchedulesLoaded extends SchedulesStates {
  final ResponseSchedulesModel data;
  SchedulesLoaded(this.data);
}

class SchedulesError extends SchedulesStates {}
