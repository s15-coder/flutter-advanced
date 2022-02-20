import 'package:dio/dio.dart';
import 'package:paymeny_app/models/payment_custom_response.dart';
import 'package:paymeny_app/models/paymeny_intent_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  static final _secretKey =
      'sk_test_51KSt0eDmOoSXP9g5brNpdWC7yFWYRtwNqyrV1NKADvvs64IjrdBxqxjpIZ3wvDBpcWwSiRB3ixXuUN8z5lntVkvW00EXuQmSFY';
  final _publishableKey =
      'pk_test_51KSt0eDmOoSXP9g5BwpSl9N0yzj8Y9acZ05dTtdUo6NCPA8fvRnmWMFfKxZIunVcRPDcUlKoGmdrcBdfvK9EukJ0002L9oLT66';
  final _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';

  static final StripeService _instance = StripeService._privateConstructor();

  final headersOptions =
      Options(contentType: Headers.formUrlEncodedContentType, headers: {
    'Authorization': "Bearer ${StripeService._secretKey}",
  });
  factory StripeService() => _instance;
  StripeService._privateConstructor();
  final dio = Dio();

  void init() {
    StripePayment.setOptions(StripeOptions(
      publishableKey: _publishableKey,
      androidPayMode: 'test',
      merchantId: '',
    ));
  }

  Future<PaymentCustomResponse> payWithExistingCreditCard({
    required String amount,
    required String currency,
    required CreditCard creditCard,
  }) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: creditCard),
      );

      final response = await _executePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );
      return response;
    } catch (e) {
      return PaymentCustomResponse(ok: false, msg: 'Something went wrong,\n$e');
    }
  }

  Future<PaymentCustomResponse> payWithNewCreditCard({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      final resp = await _executePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );
      return resp;
    } catch (e) {
      return PaymentCustomResponse(ok: false, msg: 'Something went wrong,\n$e');
    }
  }

  Future payWithGoogleOrApple({
    required String amount,
    required String currency,
  }) async {
    try {
      final newAmount = (int.parse(amount) / 100).toString();
      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: currency,
          totalPrice: amount,
        ),
        applePayOptions: ApplePayPaymentOptions(
            countryCode: 'US',
            currencyCode: currency,
            items: [ApplePayItem(label: '', amount: newAmount)]),
      );

      final resp = await _executePayment(
        amount: amount,
        currency: currency,
        paymentMethod: PaymentMethod(
          card: CreditCard(token: token.tokenId),
        ),
      );
      await StripePayment.completeNativePayRequest();
      return resp;
    } catch (e) {
      return PaymentCustomResponse(ok: false, msg: 'Something went wrong,\n$e');
    }
  }

  Future<PaymentIntentResponse> _createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      final respDio = await dio.post(
        _paymentApiUrl,
        data: {'amount': amount, "currency": currency},
        options: headersOptions,
      );
      return PaymentIntentResponse.fromJson(respDio.data);
    } catch (e) {
      return PaymentIntentResponse(status: '400-MOB');
    }
  }

  Future<PaymentCustomResponse> _executePayment({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod,
  }) async {
    try {
      final paymentIntentResp = await _createPaymentIntent(
        amount: amount,
        currency: currency,
      );
      final paymentResult =
          await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: paymentIntentResp.clientSecret,
        paymentMethodId: paymentMethod.id,
      ));
      if (paymentResult.status == 'succeeded') {
        return PaymentCustomResponse(
          ok: true,
          msg: "Successfull payment",
        );
      } else {
        return PaymentCustomResponse(
          ok: false,
          msg: "Something went wrong: ${paymentResult.status}",
        );
      }
    } catch (e) {
      return PaymentCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }
}
