import 'package:flutter/material.dart';

class CreatePostingTileButton extends StatelessWidget {
  const CreatePostingTileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add),
          Text(
            'Create Posting',
            style: TextStyle(fontSize: 21),
          ),
        ],
      ),
    );
  }
}
