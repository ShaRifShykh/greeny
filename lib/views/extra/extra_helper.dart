import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/values/constant_colors.dart';

class ExtraHelper extends ChangeNotifier {
  Widget listBtn({
    required Function onTap,
    required IconData icon,
    required String text,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Icon(
            icon,
            color: ConstantColors.black.withOpacity(0.5),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.roboto(
              color: ConstantColors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  modalBottomSheet({
    required BuildContext context,
    required Function onIconTap,
    required String title,
    required String placeHolderText,
    required TextEditingController controller,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ConstantColors.transparent,
      context: context,
      builder: (context) {
        // final theme = Theme.of(context);
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 5,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: ConstantColors.whiteColor,
            ),
            height: MediaQuery.of(context).size.height / 3.5,
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: ConstantColors.main,
                      borderRadius: BorderRadius.circular(5)),
                ),
                const SizedBox(height: 30),
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ConstantColors.main,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: placeHolderText,
                      hintStyle: GoogleFonts.poppins(
                        color: ConstantColors.main,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => onIconTap(),
                        child: const Icon(
                          Icons.send,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
