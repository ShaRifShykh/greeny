// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/models/user.dart';
import 'package:greeny/application/services/membership_card_service.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PaymentService extends ChangeNotifier {
  Map<String, dynamic>? paymentIntentData;

  Future makePayment({
    required BuildContext context,
    required User? user,
    required String amount,
    required String currency,
    required String membershipID,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: BillingDetails(
              name: user!.fullName,
              email: user.email,
            ),
            applePay: true,
            googlePay: true,
            merchantCountryCode: 'IE',
            merchantDisplayName: "Greeny",
            customerId: paymentIntentData!['customer'],
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        displayPaymentSheet(context, membershipID);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context, String membershipID) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Payment Done Successfully!",
          textStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
      Provider.of<MembershipCardService>(context, listen: false)
          .createMembershipCard(
        membershipID,
      )
          .then((value) {
        if (value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, mainRoute, (route) => false);
        }
      });
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
    } catch (e) {
      print("exception: $e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LEKIbIPBP8dKhwV3Uy9g3Ybre9w5pRv5XFMD7dKuz60ZeHJDBLKVbrfiMSRPji9eBu0OL99IenPmeJJZzDM4I8B00FyOUqtzt',
            // 'Authorization':
            //     'Bearer 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',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      // print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
