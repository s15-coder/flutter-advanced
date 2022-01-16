import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  static const routeName = "LoadingPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("LoadingPage"),
      ),
    );
  }
}
