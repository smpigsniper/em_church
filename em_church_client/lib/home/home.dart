import 'package:em_church_client/home/content/home_page.dart';
import 'package:em_church_client/home/content/profile_page.dart';
import 'package:em_church_client/style/color.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CustColors custColors = CustColors();
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: bottomNavigationDestintaion,
      ),
      body: const [
        HomePage(),
        ProfilePage(),
      ][currentPageIndex],
    );
  }

  final List<Widget> bottomNavigationDestintaion = [
    const NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const NavigationDestination(
      selectedIcon: Icon(Icons.person),
      icon: Icon(Icons.person),
      label: 'Profile',
    )
  ];
}
