import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/settings_page.dart';
import 'package:papyrus/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = "Home Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',
            backgroundColor: kBottomNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications ),
            label: 'Settings',
            backgroundColor: kBottomNavBarColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kBottomNavBarTextColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        children: <Widget>[
          HomePage(),
          SettingsPage(),
        ],
        index: _selectedIndex,
      ),
    );
  }
}

