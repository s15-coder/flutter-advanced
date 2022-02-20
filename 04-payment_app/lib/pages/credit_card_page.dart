import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:paymeny_app/bloc/payment/payment_bloc.dart';
import 'package:paymeny_app/widgets/payment_section.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final paymentBloc = BlocProvider.of<PaymentBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            paymentBloc.add(OnStopUsingCreditCard());
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Pay'),
      ),
      body: Stack(
        children: [
          Positioned(
            height: size.height,
            width: size.width,
            top: 120,
            child: BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (!state.activeCreditCard) {
                  return const SizedBox();
                }
                final tarjetaCredito = state.creditCard!;
                return Hero(
                  tag: tarjetaCredito.cardNumber,
                  child: CreditCardWidget(
                    cardNumber: tarjetaCredito.cardNumberHidden,
                    expiryDate: tarjetaCredito.expiracyDate,
                    cardHolderName: tarjetaCredito.cardHolderName,
                    cvvCode: tarjetaCredito.cvv,
                    showBackView: false,
                    onCreditCardWidgetChange: (_) {},
                  ),
                );
              },
            ),
          ),
          const Positioned(bottom: 0, child: PaymentSection())
        ],
      ),
    );
  }
}
