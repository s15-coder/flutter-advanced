import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);
  static const routeName = "ChatPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ChatPage"),
      ),
    );
  }
}
