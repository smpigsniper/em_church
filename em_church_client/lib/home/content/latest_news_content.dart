// ignore_for_file: file_names

import 'package:em_church_client/style/color.dart';
import 'package:em_church_client/style/font.dart';
import 'package:flutter/material.dart';

class LatestNewsContent extends StatefulWidget {
  const LatestNewsContent({super.key});

  @override
  State<LatestNewsContent> createState() => _LatestNewsContentState();
}

class _LatestNewsContentState extends State<LatestNewsContent> {
  CustColors custColors = CustColors();
  CustFont custFont = CustFont();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latest News Content"),
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Title",
            style: custFont.title[0],
          ),
          Text(
            "Date",
            style: custFont.subTitle[1],
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Text("many text in content"),
            ),
          ),
        ],
      ),
    );
  }
}
