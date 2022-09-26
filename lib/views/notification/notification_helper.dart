import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';

class NotificationHelper extends ChangeNotifier {
  Widget notification({
    required BuildContext context,
    required String createdAt,
    required String title,
    required String description,
    String? image,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ConstantColors.textColor.shade300,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              createdAt,
              style: GoogleFonts.roboto(
                color: ConstantColors.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: GoogleFonts.roboto(
                color: ConstantColors.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            image!.isNotEmpty ? const SizedBox(height: 12) : Container(),
            if (image.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: ConstantColors.whiteColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    Common.imgUrl + "notification/" + image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
