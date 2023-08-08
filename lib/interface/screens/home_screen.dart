import 'package:flutter/material.dart';
import 'package:presisawit_app/core/providers/company_provider.dart';

import 'package:presisawit_app/interface/pages/fields_page.dart';
import 'package:presisawit_app/interface/pages/home_page.dart';
import 'package:presisawit_app/interface/pages/settings_pages.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavbar = 0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      getUserCredentials();
    });
    super.initState();
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
              label: 'Beranda',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Kebun',
              icon: Icon(Icons.window_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Pengaturan',
              icon: Icon(Icons.settings_rounded),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_selectedNavbar == 0) const HomePage(),
            if (_selectedNavbar == 1) const FieldsScreen(),
            if (_selectedNavbar == 2) const SettingsPage()
          ],
        ),
      ),
    );
  }

  _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Future<void> getUserCredentials() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final companyProvider =
        Provider.of<CompanyProvider>(context, listen: false);
    authProvider.getUserCredentials();
    companyProvider.setCurrentCompanyDetails();
  }
}
