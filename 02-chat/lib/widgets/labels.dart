import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';

enum FromPage { register, login }

class Labels extends StatelessWidget {
  const Labels({Key? key, required this.page}) : super(key: key);
  final FromPage page;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        children: [
          Text(
            page == FromPage.login
                ? "¿No tienes una cuenta?"
                : "Ya tienes cuenta",
            style: TextStyle(
                color: Colors.grey.withOpacity(0.9),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              page == FromPage.login
                  ? RegisterPage.routeName
                  : LoginPage.routeName,
            ),
            child: Text(
              page == FromPage.login ? "Crea una ahora!" : "Ingresa ahora!",
              style: TextStyle(
                color: Colors.blueAccent.withRed(40).withGreen(100),
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
