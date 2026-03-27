import 'package:airbnb_portfolio/constant/colors/colors.dart';
import 'package:airbnb_portfolio/constant/text/strings.dart';
import 'package:airbnb_portfolio/host/booking_page.dart';
import 'package:airbnb_portfolio/host/earning_page.dart';
import 'package:airbnb_portfolio/host/my_posting.dart';
import 'package:airbnb_portfolio/pages/guest/account_page.dart';
import 'package:airbnb_portfolio/pages/guest/inbox_page.dart';
import 'package:flutter/material.dart';

class HostHomePage extends StatefulWidget {
  const HostHomePage({super.key, required this.index});

  final int index;

  @override
  State<HostHomePage> createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  int _selectedIndex = 4;

  final List<String> _pagesTitle = [
    'Booking',
    'Posting',
    'Inbox',
    'Earning',
    'Profile',
  ];
  List<Widget> _pages = [];

  BottomNavigationBarItem _buildNavigationBar(
    int index,
    String text,
    IconData icon,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: TColors.unselectedIcon,
      ),
      label: text,
      activeIcon: Icon(
        icon,
        color: TColors.selectedIcon,
      ),
    );
  }

  @override
  initState() {
    super.initState();

    _selectedIndex = widget.index;
    _pages = [
      BookingsPage(),
      MyPostingPage(),
      InboxPage(),
      EarningPage(),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesTitle[_selectedIndex]),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: TColors.selectedIcon,
        unselectedItemColor: TColors.unselectedIcon,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          _buildNavigationBar(0, _pagesTitle[0], Icons.calendar_today),
          _buildNavigationBar(1, _pagesTitle[1], Icons.home),
          _buildNavigationBar(2, _pagesTitle[2], Icons.message),
          _buildNavigationBar(3, _pagesTitle[3], Icons.currency_exchange),
          _buildNavigationBar(4, _pagesTitle[4], Icons.person_outline),
        ],
      ),
    );
  }
}
