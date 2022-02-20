import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:paymeny_app/bloc/payment/payment_bloc.dart';
import 'package:paymeny_app/data/tarjetas.dart';
import 'package:paymeny_app/helpers/alerts.dart';
import 'package:paymeny_app/helpers/fadein_navigation.dart';
import 'package:paymeny_app/pages/credit_card_page.dart';
import 'package:paymeny_app/services/stripe_service.dart';
import 'package:paymeny_app/widgets/payment_section.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = 'HomePage';
  final stripeService = StripeService();
  @override
  Widget build(BuildContext context) {
    final paymentBloc = BlocProvider.of<PaymentBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pay'),
          actions: [
            IconButton(
                onPressed: () async {
                  showLoadingAlert(context);
                  final amount = paymentBloc.state.getAmountString;
                  final currency = paymentBloc.state.currency;
                  final paymentResponse =
                      await stripeService.payWithNewCreditCard(
                    amount: amount,
                    currency: currency,
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
                icon: const Icon(Icons.add)),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              height: size.height,
              width: size.width,
              top: 250,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.85),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: tarjetas.length,
                  itemBuilder: (_, i) {
                    final creditCard = tarjetas[i];
                    return GestureDetector(
                      onTap: () {
                        paymentBloc.add(OnStartUsingCreditCard(creditCard));
                        Navigator.push(context,
                            navigateFadeIn(context, const CreditCardPage()));
                      },
                      child: Hero(
                        tag: creditCard.cardNumber,
                        child: CreditCardWidget(
                            cardNumber: creditCard.cardNumberHidden,
                            expiryDate: creditCard.expiracyDate,
                            cardHolderName: creditCard.cardHolderName,
                            cvvCode: creditCard.cvv,
                            showBackView: false,
                            onCreditCardWidgetChange: (_) {}),
                      ),
                    );
                  }),
            ),
            const Positioned(bottom: 0, child: PaymentSection())
          ],
        ));
  }
}
