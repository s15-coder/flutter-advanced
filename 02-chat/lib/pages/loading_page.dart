import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  static const routeName = "LoadingPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: verifyToken(context),
          builder: (context, snapshot) {
            return const Center(
              child: Text("Espere..."),
            );
          }),
    );
  }

  Future verifyToken(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticated = await authService.verifyToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => authenticated ? const UsersPage() : const LoginPage(),
      ),
    );
  }
}
