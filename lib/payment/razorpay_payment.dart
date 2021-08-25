import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

typedef void HandlePaymentSuccess(PaymentSuccessResponse response);
typedef void HandlePaymentError(PaymentFailureResponse response);
typedef void HandleExternalWallet(ExternalWalletResponse response);

void openCheckout(
    {double payment = 100,
    HandlePaymentSuccess handlePaymentSuccess,
    HandlePaymentError handlePaymentError,
    HandleExternalWallet handleExternalWallet}) async {
  Razorpay _razorpay;
  _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    handlePaymentSuccess(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    handlePaymentError(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    handleExternalWallet(response);
  }

  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  var options = {
    'key': 'rzp_live_xGYuyE2D0EhfGH',
    'amount': payment * 100,
    // 'name': 'Acme Corp.',
    // 'description': 'Fine T-Shirt',
    // 'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    'external': {
      'wallets': ['paytm']
    }
  };

  try {
    _razorpay.open(options);
  } catch (e) {
    debugPrint(e);
  }
}
