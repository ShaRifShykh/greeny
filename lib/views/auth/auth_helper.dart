import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/values/constant_colors.dart';

class AuthHelper extends ChangeNotifier {
  Widget spacing({required BuildContext context, required int spacing}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - spacing,
    );
  }

  Widget contentBody({required BuildContext context, required Widget widget}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: ConstantColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: widget,
    );
  }

  Widget heading({required String text}) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: ConstantColors.main,
      ),
    );
  }

  Widget signUpRedirection({required Function onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Don't have an account? ",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        GestureDetector(
          onTap: () => onTap(),
          child: Text(
            "Sign Up Now",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: ConstantColors.main,
            ),
          ),
        ),
      ],
    );
  }

  Widget footerLinks(
      GestureRecognizer recognizerForTOS, GestureRecognizer recognizerForPP) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "By Signing up you accept the ",
        style: GoogleFonts.roboto(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: ConstantColors.black.withOpacity(0.7),
        ),
        children: [
          TextSpan(
            text: "Terms Of Service ",
            style: const TextStyle(
              color: ConstantColors.main,
            ),
            recognizer: recognizerForTOS,
          ),
          const TextSpan(
            text: "and ",
          ),
          TextSpan(
            text: "Privacy Policy",
            style: const TextStyle(
              color: ConstantColors.main,
            ),
            recognizer: recognizerForPP,
          )
        ],
      ),
    );
  }
}
