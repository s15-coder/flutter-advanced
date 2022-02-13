import 'package:flutter/material.dart';
import 'package:paymeny_app/pages/complete_payment_page.dart';
import 'package:paymeny_app/pages/credit_card_page.dart';
import 'package:paymeny_app/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        CompletedPaymentPage.routeName: (_) => const CompletedPaymentPage(),
      },
      initialRoute: HomePage.routeName,
      theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xff284879),
          scaffoldBackgroundColor: const Color(0xff21232A),
          appBarTheme:
              const AppBarTheme(backgroundColor: const Color(0xff284879))),
    );
  }
}
