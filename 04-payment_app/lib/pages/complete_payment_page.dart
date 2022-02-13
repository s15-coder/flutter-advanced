import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompletedPaymentPage extends StatelessWidget {
  const CompletedPaymentPage({Key? key}) : super(key: key);
  static const routeName = 'CompletedPaymentPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Succes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            FontAwesomeIcons.star,
            color: Colors.white,
            size: 45,
          ),
          SizedBox(height: 20),
          Text(
            'Your payment has been received successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
