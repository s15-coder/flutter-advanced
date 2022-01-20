import 'package:chat/helpers/show_alert.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/blue_button.dart';
import 'package:chat/widgets/custom_field.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Logo(title: "Messenger"),
                  _Form(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const Labels(page: FromPage.login),
                  Text(
                    "Terminos y condiciones de uso",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatelessWidget {
  _Form({
    required this.passwordController,
    required this.emailController,
  });
  TextEditingController emailController;
  TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.12),
      child: Column(
        children: [
          CustomField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            prefixIcon: Icons.email,
          ),
          CustomField(
            controller: passwordController,
            obscureText: true,
            hintText: "Contraseña",
            prefixIcon: Icons.lock,
          ),
          BlueButton(
            text: "Ingresar",
            onPressed: authService.loggingIn
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOK = await authService.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    if (loginOK) {
                      Navigator.pushNamed(context, UsersPage.routeName);
                    } else {
                      showCustomAlert(
                        context,
                        "Incorrecto",
                        "Tus credenciales son incorrectas",
                      );
                    }
                  },
          )
          // SizedBox(height: 10),
          // ElevatedButton(onPressed: () {}, child: Text("Entrar")),
        ],
      ),
    );
  }
}
