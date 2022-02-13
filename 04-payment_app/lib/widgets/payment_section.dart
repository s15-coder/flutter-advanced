import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'TOTAL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('252 USD')
            ],
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
    return true ? buildCreditCardBtn(context) : buildAppleAndGoogleBtn(context);
  }

  Widget buildAppleAndGoogleBtn(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: () {},
      minWidth: widthScreen * 0.35,
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
      onPressed: () {},
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
