import 'package:flutter/material.dart';
import "package:curved_navigation_bar/curved_navigation_bar.dart";

import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/settings.dart';
import 'pages/HealthRecord.dart';
import 'pages/MedicineReminder.dart';
import 'pages/search.dart'; // ???? ?? ?? ?????? ????
import 'pages/home.dart'; // ???? ?? ?? ?????? ????3

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    home: BottomNavBar(),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ' '), // ????? ???????
    ],
    locale: const Locale('ar', 'AE'), // ??? ????? ??????????
  ));
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  // Create all the pages
  final MedicineReminder _MedicineReminder = MedicineReminder();
  final Healthrecord Health_record = Healthrecord();
  final Search _search = Search(); // ???? ?? ?? ????? ??????
  final Settings _Settings = Settings(); // ???? ?? ?? ????? ??????
  final HomePage _homePage = HomePage();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return Health_record;
      case 1:
        return _homePage;
      case 2:
        return _MedicineReminder;
      case 3:
        return _search;
      case 4:
        return _Settings;
      default:
        return Container(
          child: Center(
            child: Text(
              'null.',
              style: TextStyle(fontSize: 30),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        items: <Widget>[
          Icon(Icons.favorite_border_sharp, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.calendar_month_sharp, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: const Color.fromARGB(255, 179, 234, 248),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            pageIndex = tappedIndex; // ?? ?????? pageIndex
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: Colors.white,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: _pageChooser(pageIndex), // ?????? _pageChooser(pageIndex)
        ),
      ),
    );
  }
}
