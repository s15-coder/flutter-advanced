import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_signin/src/services/google_signin_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await GoogleSingIn.signOut();
              },
              icon: const Icon(FontAwesomeIcons.doorOpen),
            )
          ],
          title: const Text('Whatever'),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async => GoogleSingIn.signIn(),
                child: const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    child: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
