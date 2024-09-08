import 'package:em_church_client/blocs/schedules/schedules_blocs.dart';
import 'package:em_church_client/home/content/schedules.dart';
import 'package:em_church_client/home/content/latest_news.dart';
import 'package:em_church_client/repositories/getSchedules_response.dart';
import 'package:em_church_client/style/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustFont custFont = CustFont();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: _latestNews(),
            ),
            Expanded(
              flex: 4,
              child: _gridView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _latestNews() {
    return InkWell(
      child: Card(
        elevation: 5, // Adjust elevation as needed
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.announcement), // Example icon, replace with your content
              const SizedBox(height: 8),
              Text(
                'Latest News',
                style: custFont.title[0],
              ),
              Text(
                'Last Update: 23/06/2024',
                style: custFont.subTitle[0],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        _gotoLatestNewPage();
      },
    );
  }

  Widget _gridView() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _gridViewCard(),
    );
  }

  List<Widget> _gridViewCard() {
    return [
      InkWell(
        child: Card(
          elevation: 5, // Adjust elevation as needed
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.schedule), // Example icon, replace with your content
                const SizedBox(height: 8),
                Text(
                  'Schedule',
                  style: custFont.title[0],
                ),
                Text(
                  'Last Update: 21/06/2024',
                  style: custFont.subTitle[0],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          _gotoSchedules();
        },
      ),
      Card(
        elevation: 5, // Adjust elevation as needed
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.book), // Example icon, replace with your content
              const SizedBox(height: 8),
              Text(
                'Card Title',
                style: custFont.title[0],
              ),
              Text(
                'Card Subtitle',
                style: custFont.subTitle[0],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  void _gotoLatestNewPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LatestNews(),
      ),
    );
  }

  void _gotoSchedules() {
    GetScheduleBlocs getScheduleBlocs = GetScheduleBlocs(GetschedulesResponse());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider<GetScheduleBlocs>.value(
          value: getScheduleBlocs,
          child: const Schedules(),
        ),
      ),
    );
  }
}
