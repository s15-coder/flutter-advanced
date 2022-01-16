import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  ChatPage.routeName: (_) => ChatPage(),
  LoadingPage.routeName: (_) => LoadingPage(),
  LoginPage.routeName: (_) => LoginPage(),
  RegisterPage.routeName: (_) => RegisterPage(),
  UsersPage.routeName: (_) => UsersPage(),
};
