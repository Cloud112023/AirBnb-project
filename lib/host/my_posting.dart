import 'package:airbnb_portfolio/host/create_update_posting_page.dart';
import 'package:airbnb_portfolio/widgets/create_posting_tile_button.dart';
import 'package:flutter/material.dart';

class MyPostingPage extends StatefulWidget {
  const MyPostingPage({super.key});

  @override
  State<MyPostingPage> createState() => _MyPostingPageState();
}

class _MyPostingPageState extends State<MyPostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: InkResponse(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateUpdatePostingPage(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: 5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: CreatePostingTileButton(),
          ),
        ),
      ),
    );
  }
}
