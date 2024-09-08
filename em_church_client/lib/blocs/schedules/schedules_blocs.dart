import 'package:em_church_client/blocs/schedules/schedules_events.dart';
import 'package:em_church_client/blocs/schedules/schedules_states.dart';
import 'package:em_church_client/model/response/response_schedules_model.dart';
import 'package:em_church_client/repositories/getSchedules_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetScheduleBlocs extends Bloc<SchedulesEvents, SchedulesStates> {
  late ResponseSchedulesModel responseData;
  late GetschedulesResponse data;
  GetScheduleBlocs(this.data) : super(SchedulesInit()) {
    on<SchedulesEvents>(
      (event, emit) async {
        emit(SchedulesLoading());
        if (event is GetSchedules) {
          emit(SchedulesLoading());
          responseData = await data.schedulesData(event.data, event.token);
          emit(SchedulesLoaded(responseData));
        }
      },
    );
  }
}
