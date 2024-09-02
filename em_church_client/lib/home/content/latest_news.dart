// ignore_for_file: file_names

import 'package:em_church_client/home/content/latest_news_content.dart';
import 'package:em_church_client/style/color.dart';
import 'package:em_church_client/style/font.dart';
import 'package:flutter/material.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  CustColors custColors = CustColors();
  CustFont custFont = CustFont();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latest Page"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _listContent(),
        ),
      ),
    );
  }

  Widget _listContent() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 120,
          child: InkWell(
            onTap: () {
              _gotoContentPage();
            },
            child: Card(
              elevation: 5, // Adjust elevation as needed
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Card Title',
                      style: custFont.title[0],
                    ),
                    Text(
                      'Card date',
                      style: custFont.subTitle[0],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _gotoContentPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LatestNewsContent(),
      ),
    );
  }
}
