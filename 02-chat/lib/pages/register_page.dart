import 'package:chat/helpers/show_alert.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/blue_button.dart';
import 'package:chat/widgets/custom_field.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = "registerPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

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
                  const Logo(title: "Registro"),
                  _Form(
                    emailController: emailController,
                    passwordController: passwordController,
                    nameController: nameController,
                    authService: authService,
                  ),
                  const Labels(page: FromPage.register),
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

class _Form extends StatefulWidget {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController nameController;
  AuthService authService;

  _Form({
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.authService,
  });

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.12),
      child: Column(
        children: [
          CustomField(
            controller: widget.nameController,
            keyboardType: TextInputType.text,
            hintText: "Nombre",
            prefixIcon: Icons.person,
          ),
          CustomField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            prefixIcon: Icons.email,
          ),
          CustomField(
            controller: widget.passwordController,
            obscureText: true,
            hintText: "Contraseña",
            prefixIcon: Icons.lock,
          ),
          BlueButton(
            text: "Registrar",
            onPressed: widget.authService.loggingIn
                ? null
                : () async {
                    final registerOk = await widget.authService.register(
                      widget.nameController.text.trim(),
                      widget.emailController.text.trim(),
                      widget.passwordController.text.trim(),
                    );
                    if (registerOk == true) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(
                          context, UsersPage.routeName);
                    } else {
                      showCustomAlert(
                        context,
                        "Incorrecto",
                        registerOk['msg']?.toString() ??
                            "Credenciales invalidas",
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
