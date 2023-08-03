import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presisawit_app/interface/pages/home_page.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavbar = 0;

  _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.secondaryColor,
          onTap: _changeSelectedNavBar,
          showUnselectedLabels: true,
          currentIndex: _selectedNavbar,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Blocks',
              icon: Icon(Icons.window_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings_rounded),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_selectedNavbar == 0) HomePage(),
            if (_selectedNavbar == 1) Text('Blocks'),
            if (_selectedNavbar == 2) Text('Settings')
          ],
        ),
      ),
    );
  }
}
