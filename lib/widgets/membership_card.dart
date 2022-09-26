import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/values/constant_colors.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({
    Key? key,
    required this.packageName,
    required this.expireAt,
  }) : super(key: key);

  final String packageName;
  final String expireAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      decoration: BoxDecoration(
        color: ConstantColors.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            packageName,
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: ConstantColors.whiteColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Expires at: $expireAt",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              color: ConstantColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
