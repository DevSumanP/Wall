import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:wall/screen/freindscreen.dart';
import 'package:wall/screen/homescreen.dart';
import 'package:wall/screen/newthread.dart';
import 'package:wall/screen/profilescreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List _screen = [
    const HomeScreen(),
    const Search(),
    const NewThread(),
    const NewThread(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screen[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    EneftyIcons.home_2_outline,
                    color: Color(0xff1a1a1a),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(EneftyIcons.search_normal_2_outline,
                      color: Color(0xff999999)),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(EneftyIcons.add_square_outline,
                      color: Color(0xff999999)),
                  label: ''),
              BottomNavigationBarItem(
                  icon:
                      Icon(EneftyIcons.heart_outline, color: Color(0xff999999)),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(EneftyIcons.profile_outline,
                      color: Color(0xff999999)),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
