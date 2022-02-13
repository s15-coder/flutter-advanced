import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:paymeny_app/data/tarjetas.dart';
import 'package:paymeny_app/helpers/alerts.dart';
import 'package:paymeny_app/helpers/fadein_navigation.dart';
import 'package:paymeny_app/pages/credit_card_page.dart';
import 'package:paymeny_app/widgets/payment_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = 'HomePage';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pay'),
          actions: [
            IconButton(onPressed: () async {}, icon: const Icon(Icons.add)),
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
                        Navigator.push(
                            context,
                            navigateFadeIn(
                                context,
                                CreditCardPage(
                                  tarjetaCredito: creditCard,
                                )));
                      },
                      child: Hero(
                        tag: creditCard.cardNumber,
                        child: CreditCardWidget(
                            cardNumber: creditCard.cardNumberHidden,
                            expiryDate: creditCard.expiracyDate,
                            cardHolderName: creditCard.cardHolderName,
                            cvvCode: creditCard.cvv,
                            showBackView: false,
                            onCreditCardWidgetChange: (_) {
                              navigateFadeIn(
                                  context,
                                  CreditCardPage(
                                    tarjetaCredito: creditCard,
                                  ));
                            }),
                      ),
                    );
                  }),
            ),
            const Positioned(bottom: 0, child: PaymentSection())
          ],
        ));
  }
}
