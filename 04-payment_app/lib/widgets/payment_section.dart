import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paymeny_app/bloc/payment/payment_bloc.dart';
import 'package:paymeny_app/helpers/alerts.dart';
import 'package:paymeny_app/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      width: width,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${state.amountToPay} ${state.currency}")
                ],
              );
            },
          ),
          _ButtonPay()
        ],
      ),
    );
  }
}

class _ButtonPay extends StatelessWidget {
  const _ButtonPay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return state.activeCreditCard
            ? buildCreditCardBtn(context)
            : buildAppleAndGoogleBtn(context);
      },
    );
  }

  Widget buildAppleAndGoogleBtn(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: () async {
        showLoadingAlert(context);
        final stripeService = StripeService();
        final state = BlocProvider.of<PaymentBloc>(context).state;
        final paymentResponse = await stripeService.payWithGoogleOrApple(
          amount: state.getAmountString,
          currency: state.currency,
        );
        Navigator.pop(context);
        if (paymentResponse.ok) {
          showMessageAlert(
            context: context,
            title: 'Ok',
            message: 'Successfull payment',
          );
        } else {
          showMessageAlert(
            context: context,
            title: 'Sorry',
            message: '${paymentResponse.msg}',
          );
        }
      },
      minWidth: widthScreen * 0.35,
      height: 45,
      shape: const StadiumBorder(),
      color: Colors.black,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Platform.isAndroid
                ? FontAwesomeIcons.google
                : FontAwesomeIcons.apple,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          const Text(
            'Pay',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildCreditCardBtn(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: () async {
        showLoadingAlert(context);
        final stripeService = StripeService();
        final state = BlocProvider.of<PaymentBloc>(context).state;
        final tarjetaCredito = state.creditCard!;
        final number = tarjetaCredito.cardNumber;
        final monthAnio = tarjetaCredito.expiracyDate.split('/');
        final paymentResponse = await stripeService.payWithExistingCreditCard(
          amount: state.getAmountString,
          currency: state.currency,
          creditCard: CreditCard(
              number: number,
              expMonth: int.parse(monthAnio[0]),
              expYear: int.parse(monthAnio[1])),
        );
        Navigator.pop(context);
        if (paymentResponse.ok) {
          showMessageAlert(
            context: context,
            title: 'Ok',
            message: 'Successfull payment',
          );
        } else {
          showMessageAlert(
            context: context,
            title: 'Sorry',
            message: '${paymentResponse.msg}',
          );
        }
      },
      height: 45,
      minWidth: widthScreen * 0.35,
      shape: const StadiumBorder(),
      color: Colors.black,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Icon(
            FontAwesomeIcons.creditCard,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            'Pay',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
