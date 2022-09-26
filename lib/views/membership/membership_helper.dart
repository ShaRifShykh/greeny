import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/values/constant_colors.dart';

class MembershipHelper extends ChangeNotifier {
  Widget memberships({
    required BuildContext context,
    required Function onTap,
    required String packageName,
    required String price,
    required String duration,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.5, 0.8],
              colors: [
                ConstantColors.main,
                Colors.yellow,
                ConstantColors.main,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                packageName.toUpperCase(),
                style: GoogleFonts.roboto(
                  color: ConstantColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "$price EUR ",
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: ConstantColors.whiteColor,
                  ),
                  children: [
                    TextSpan(
                      text: duration,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ConstantColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Choose Plan",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      color: ConstantColors.whiteColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ConstantColors.whiteColor,
                    size: 12,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
