import 'dart:convert';

import 'package:em_church_client/api_request.dart';
import 'package:em_church_client/global_variable.dart';
import 'package:em_church_client/model/request/request_schedules_model.dart';
import 'package:em_church_client/model/response/response_schedules_model.dart';
import 'package:em_church_client/style/color.dart';
import 'package:em_church_client/style/font.dart';
import 'package:em_church_client/widget/error_dialog.dart';
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
      String response = await ApiRequest.postRequest(
        "${GlobalVariable.apiIP}api/schedule/getSchedule",
        accessToken,
        requestSchedulesModel.toJson(),
      );
      responseSchedules = ResponseSchedulesModel.fromJson(
        jsonDecode(response),
      );
      setState(() {
        dataList = [];
        dataList = responseSchedules.data;
      });
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _calendar(),
              _eventList(),
            ],
          ),
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

  Widget _eventList() {
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
