import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_tickets_app/src/ui/screens/DiscoverScreen.dart';
import 'package:movie_tickets_app/src/ui/screens/HomeScreen.dart';
import 'package:movie_tickets_app/src/ui/screens/ProfileScreen.dart';
import 'package:movie_tickets_app/src/ui/screens/WatchListScreen.dart';

import '../../models/style.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  final _screens = [
    HomeScreen(),
    DiscoverScreen(),
    WatchListScreen(),
    ProfileScreen(),
  ];

  final _items = <Widget>[
    Icon(FluentIcons.home_12_filled, color: Styles.bgColor),
    Icon(FluentIcons.compass_northwest_16_filled, color: Styles.bgColor),
    Icon(FluentIcons.bookmark_16_filled, color: Styles.bgColor),
    Icon(FluentIcons.person_12_filled, color: Styles.bgColor)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        items: _items,
        backgroundColor: Colors.transparent,
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
      ),
      body: _screens[_currentIndex],
    );
  }
}
