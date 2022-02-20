part of 'payment_bloc.dart';

class PaymentState {
  final double amountToPay;
  final String currency;
  final TarjetaCredito? creditCard;
  final bool activeCreditCard;

  PaymentState({
    this.creditCard,
    required this.activeCreditCard,
    required this.amountToPay,
    required this.currency,
  });
  String get getAmountString => "${(amountToPay * 100).floor()}";
  PaymentState copyWith({
    double? amountToPay,
    String? currency,
    TarjetaCredito? creditCard,
    bool? activeCreditCard,
  }) =>
      PaymentState(
        creditCard: creditCard ?? this.creditCard,
        currency: currency ?? this.currency,
        amountToPay: amountToPay ?? this.amountToPay,
        activeCreditCard: activeCreditCard ?? this.activeCreditCard,
      );
}
