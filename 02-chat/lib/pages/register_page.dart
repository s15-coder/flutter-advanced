import 'package:chat/widgets/blue_button.dart';
import 'package:chat/widgets/custom_field.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = "registerPage";
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
                  const Logo(title: "Registro"),
                  _Form(),
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
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.12),
      child: Column(
        children: [
          CustomField(
            controller: nameController,
            keyboardType: TextInputType.text,
            hintText: "Nombre",
            prefixIcon: Icons.person,
          ),
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
            text: "Registrar",
            onPressed: () {
              print("Credenciales");
              print(nameController.text);
              print(emailController.text);
              print(passwordController.text);
            },
          )
          // SizedBox(height: 10),
          // ElevatedButton(onPressed: () {}, child: Text("Entrar")),
        ],
      ),
    );
  }
}
