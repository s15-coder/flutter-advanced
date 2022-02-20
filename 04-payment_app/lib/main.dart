import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymeny_app/bloc/payment/payment_bloc.dart';
import 'package:paymeny_app/pages/complete_payment_page.dart';
import 'package:paymeny_app/pages/credit_card_page.dart';
import 'package:paymeny_app/pages/home_page.dart';
import 'package:paymeny_app/services/stripe_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StripeService().init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PaymentBloc()),
      ],
      child: MaterialApp(
        title: 'Material App',
        routes: {
          HomePage.routeName: (_) => HomePage(),
          CompletedPaymentPage.routeName: (_) => const CompletedPaymentPage(),
        },
        initialRoute: HomePage.routeName,
        theme: ThemeData.light().copyWith(
            primaryColor: const Color(0xff284879),
            scaffoldBackgroundColor: const Color(0xff21232A),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xff284879))),
      ),
    );
  }
}
