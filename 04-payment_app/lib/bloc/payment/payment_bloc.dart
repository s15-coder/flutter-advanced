import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paymeny_app/models/credit_card_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

final _initialPaymentState = PaymentState(
  activeCreditCard: false,
  amountToPay: 512.6,
  currency: 'USD',
);

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(_initialPaymentState) {
    on<OnStartUsingCreditCard>(
      (event, emit) => emit(
        state.copyWith(creditCard: event.creditCard, activeCreditCard: true),
      ),
    );
    on<OnStopUsingCreditCard>(
      (event, emit) => emit(
        state.copyWith(activeCreditCard: false, creditCard: null),
      ),
    );
  }
}
