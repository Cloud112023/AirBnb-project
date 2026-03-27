import 'package:flutter/material.dart';

class MyPostingPage extends StatefulWidget {
  const MyPostingPage({super.key});

  @override
  State<MyPostingPage> createState() => _MyPostingPageState();
}

class _MyPostingPageState extends State<MyPostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Posting page')));
  }
}
