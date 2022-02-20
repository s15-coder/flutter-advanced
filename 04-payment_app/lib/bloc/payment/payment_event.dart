part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class OnStartUsingCreditCard extends PaymentEvent {
  final TarjetaCredito creditCard;

  OnStartUsingCreditCard(this.creditCard);
}

class OnStopUsingCreditCard extends PaymentEvent {}
