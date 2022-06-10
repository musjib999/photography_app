import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';

class HomeBottomNavigation extends StatefulWidget {
  final List<Widget> pages;
  const HomeBottomNavigation({Key? key, required this.pages}) : super(key: key);

  @override
  _HomeBottomNavigationState createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages.elementAt(_selectedIndex),
      backgroundColor: const Color(0xFFF0EFEF),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0
                ? FluentSystemIcons.ic_fluent_home_filled
                : FluentSystemIcons.ic_fluent_home_regular),
            label: 'Home',
          ),
          currentUser.role == 'admin'
              ? BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 1
                      ? Ionicons.analytics
                      : Ionicons.analytics_outline),
                  label: 'Analytics',
                )
              : BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 1
                      ? Ionicons.folder
                      : Ionicons.folder_outline),
                  label: 'Media',
                ),
          currentUser.role != 'client'
              ? BottomNavigationBarItem(
                  icon: Icon(
                    _selectedIndex == 2 ? Ionicons.cash : Ionicons.cash_outline,
                  ),
                  label: 'Expenses',
                )
              : BottomNavigationBarItem(
                  icon: Icon(
                    _selectedIndex == 2 ? Ionicons.cart : Ionicons.cart_outline,
                  ),
                  label: 'Items',
                ),
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 3 ? Icons.person : Icons.person_outline),
            label: currentUser.role == 'client' || currentUser.role == 'manager'
                ? 'Proile'
                : 'Connection',
          ),
        ],
      ),
    );
  }
}
