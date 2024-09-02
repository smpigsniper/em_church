// ignore_for_file: file_names

import 'package:em_church_client/style/color.dart';
import 'package:em_church_client/style/font.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CustFont custFont = CustFont();
  CustColors custColors = CustColors();

  @override
  Widget build(BuildContext context) {
    String surename = 'Siu Pang';
    String lastname = 'Tang';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            nameText(surename, lastname),
          ],
        ),
      ),
    );
  }

  Widget nameText(String surename, String lastname) {
    return Center(
      child: Text(
        '$surename, $lastname',
        style: custFont.title[0],
      ),
    );
  }
}
