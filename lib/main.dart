import 'package:airbnb_portfolio/constant/theme/appTheme.dart';
import 'package:airbnb_portfolio/pages/auth/login_page.dart';
import 'package:airbnb_portfolio/pages/auth/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Bnb',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.appTheme,
      home: LoginPage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignupPage.routeName: (context) => SignupPage(),
      },
    );
  }
}
