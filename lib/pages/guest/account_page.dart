import 'package:airbnb_portfolio/constant/text/strings.dart';
import 'package:airbnb_portfolio/host/host_home_page.dart';
import 'package:airbnb_portfolio/pages/auth/login_page.dart';
import 'package:airbnb_portfolio/pages/guest/guest_home_page.dart';
import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? _hostingTitle = 'Show my host Dashboard';

  Widget _buildActionTile(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      color: Colors.white12,
      child: MaterialButton(
        onPressed: onTap,
        height: MediaQuery.of(context).size.height / 9.5,
        child: ListTile(
          leading: Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            icon,
            size: 32,
          ),
        ),
      ),
    );
  }

  _showPersonalInfo() {}

  _changeHosting() {
    if (TStrings.currentUser.isHost!) {
      if (TStrings.currentUser.isCurrentlyHosting!) {
        TStrings.currentUser.isCurrentlyHosting = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GuestHomePage()),
        );
      } else {
        TStrings.currentUser.isCurrentlyHosting = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HostHomePage(
              index: 0,
            ),
          ),
        );
      }
    } else {
      TStrings.currentUser.becomeHost().whenComplete(() {
        TStrings.currentUser.isCurrentlyHosting = true;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HostHomePage(index: 0)),
        );
      });
    }
  }

  _logOut() async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();

    if (TStrings.currentUser.isHost!) {
      _hostingTitle = TStrings.currentUser.isCurrentlyHosting!
          ? 'Show my Guest Dashboard'
          : 'Show my Host Dashbord';
    } else {
      _hostingTitle = 'Become a Host';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 50, 20, 0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        radius: MediaQuery.of(context).size.width / 4.5,
                        child: CircleAvatar(
                          backgroundImage: TStrings.currentUser.displayImage,
                          radius: MediaQuery.of(context).size.width / 4.6,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    AutoSizeText(
                      TStrings.currentUser.getFullName(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    AutoSizeText(
                      TStrings.currentUser.email!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(178),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _buildActionTile(
                context,
                'Personal Information',
                Icons.person_pin,
                _showPersonalInfo,
              ),
              SizedBox(height: 15),
              _buildActionTile(
                context,
                _hostingTitle!,
                Icons.person_pin,
                _changeHosting,
              ),
              SizedBox(height: 15),
              _buildActionTile(
                context,
                'Logout',
                Icons.logout,
                _logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
