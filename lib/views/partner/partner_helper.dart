import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/values/constant_colors.dart';

class PartnerHelper extends ChangeNotifier {
  Widget appBarIcons({required Function onTap, required Icon icon}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: ConstantColors.whiteColor,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }

  Widget detailList({
    required BuildContext context,
    required IconData icons,
    required String title,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ConstantColors.greyColor,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icons,
            color: ConstantColors.main,
            size: 15,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  color: ConstantColors.textColor,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.35,
                child: Text(
                  text,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget title({required String title}) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.w900,
        fontSize: 22,
      ),
    );
  }
}
