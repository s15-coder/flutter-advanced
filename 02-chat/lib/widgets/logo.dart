import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            width: 150,
            image: AssetImage("assets/tag-logo.png"),
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(fontSize: 25),
          )
        ],
      ),
    );
  }
}
