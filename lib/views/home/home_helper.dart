import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/values/constant_colors.dart';

class HomeHelper extends ChangeNotifier {
  Widget searchBar({
    required BuildContext context,
    required TextEditingController textEditingController,
    required Function onSearchTap,
  }) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: const BoxDecoration(
            color: ConstantColors.main,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: ConstantColors.whiteColor,
            border: Border.all(
              color: ConstantColors.main,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: GoogleFonts.roboto(
                color: ConstantColors.main,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: GestureDetector(
                onTap: () => onSearchTap(),
                child: const Icon(
                  Icons.search,
                  color: ConstantColors.main,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget heading({required String title}) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}
