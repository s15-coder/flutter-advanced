import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:paymeny_app/models/credit_card_model.dart';
import 'package:paymeny_app/widgets/payment_section.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({Key? key, required this.tarjetaCredito})
      : super(key: key);
  final TarjetaCredito tarjetaCredito;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('Im here');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pay'),
      ),
      body: Stack(
        children: [
          Positioned(
            height: size.height,
            width: size.width,
            top: 120,
            child: Hero(
              tag: tarjetaCredito.cardNumber,
              child: CreditCardWidget(
                cardNumber: tarjetaCredito.cardNumberHidden,
                expiryDate: tarjetaCredito.expiracyDate,
                cardHolderName: tarjetaCredito.cardHolderName,
                cvvCode: tarjetaCredito.cvv,
                showBackView: false,
                onCreditCardWidgetChange: (_) {},
              ),
            ),
          ),
          const Positioned(bottom: 0, child: PaymentSection())
        ],
      ),
    );
  }
}
