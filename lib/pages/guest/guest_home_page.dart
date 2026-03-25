import 'package:airbnb_portfolio/constant/colors/colors.dart';
import 'package:airbnb_portfolio/constant/text/strings.dart';
import 'package:airbnb_portfolio/pages/guest/account_page.dart';
import 'package:airbnb_portfolio/pages/guest/explore_page.dart';
import 'package:airbnb_portfolio/pages/guest/inbox_page.dart';
import 'package:flutter/material.dart';

import 'saved_page.dart';
import 'trips_page.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  int _selectedIndex = 0;

  final List<String> _pageTitles = [
    'Explore',
    'Favorites',
    'Trips',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    ExplorePage(),
    SavedPage(),
    TripsPage(),
    InboxPage(),
    AccountPage(),
  ];

  BottomNavigationBarItem _buildNavigationItem(
    int index,
    IconData icon,
    String text,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(
        icon,
        color: TColors.selectedIcon,
      ),
      label: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome ${TStrings.currentUser.firstName}'),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildNavigationItem(0, Icons.search, _pageTitles[0]),
          _buildNavigationItem(1, Icons.favorite_border, _pageTitles[1]),
          _buildNavigationItem(2, Icons.hotel, _pageTitles[2]),
          _buildNavigationItem(3, Icons.message, _pageTitles[3]),
          _buildNavigationItem(4, Icons.person_outline, _pageTitles[4]),
        ],
      ),
    );
  }
}
