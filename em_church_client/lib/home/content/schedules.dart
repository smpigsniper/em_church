import 'package:em_church_client/blocs/schedules/schedules_blocs.dart';
import 'package:em_church_client/blocs/schedules/schedules_events.dart';
import 'package:em_church_client/blocs/schedules/schedules_states.dart';
import 'package:em_church_client/model/request/request_schedules_model.dart';
import 'package:em_church_client/model/response/response_schedules_model.dart';
import 'package:em_church_client/repositories/getSchedules_response.dart';
import 'package:em_church_client/style/color.dart';
import 'package:em_church_client/style/font.dart';
import 'package:em_church_client/widget/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class Schedules extends StatefulWidget {
  const Schedules({super.key});

  @override
  State<Schedules> createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  String accessToken = "";
  final GetschedulesResponse getResponseSchedules = GetschedulesResponse();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  CustColors custColors = CustColors();
  CustFont custFont = CustFont();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  ErrorDialog errorDialog = const ErrorDialog();
  ResponseSchedulesModel responseSchedules = ResponseSchedulesModel();
  List<ResponseSchedulesModelData> dataList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      accessToken = (await _secureStorage.read(key: 'accessToken'))!;
      final requestSchedulesModel = RequestSchedulesModel(
        date: DateFormat('yyyy-MM-dd').format(_selectedDay).toString(),
      );
      // ignore: use_build_context_synchronously
      BlocProvider.of<GetScheduleBlocs>(context).add(GetSchedules(requestSchedulesModel, accessToken));
    } catch (e) {
      errorDialog;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedules"),
      ),
      body: BlocConsumer<GetScheduleBlocs, SchedulesStates>(
        listener: (context, state) {
          if (state is SchedulesError) {
            errorDialog;
          }
        },
        builder: (context, state) {
          return _bodyWidget(state);
        },
      ),
    );
  }

  Widget _bodyWidget(SchedulesStates state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _calendar(),
            _eventList(state),
          ],
        ),
      ),
    );
  }

  Widget _calendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            // Here to do load event
            _loadData();
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  Widget _eventList(SchedulesStates state) {
    if (state is SchedulesLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SchedulesError) {
      return const Center(
        child: Text("Fail Load Data!"),
      );
    } else if (state is SchedulesLoaded) {
      dataList = state.data.data;
      return _eventListView();
    } else {
      return Container();
    }
  }

  Widget _eventListView() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 120,
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dataList[index].title,
                      style: custFont.title[0],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dataList[index].description,
                      style: custFont.subTitle[0],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  _inCharge(dataList[index].prefer_name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _inCharge(String name) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "In Charge: ",
              style: custFont.subTitle[1],
            ),
            Text(
              name,
              style: custFont.subTitle[1],
            )
          ],
        ),
      ),
    );
  }
}
