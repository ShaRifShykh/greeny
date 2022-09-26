import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Common extends ChangeNotifier {
  static const String baseUrl = "https://greeny.ie/api/";
  static const String imgUrl = "https://greeny.ie/storage/";

  // static const String baseUrl = "http://10.0.2.2:8000/api/";
  // static const String imgUrl = "http://10.0.2.2:8000/storage/";

  File? _img;
  File? get getimg => _img;

  PreferredSizeWidget appBar({
    required BuildContext context,
    required String location,
    required Function onLocationPressed,
    required Function onMenuPressed,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80), // Set this height
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: ConstantColors.main,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: ConstantColors.whiteColor,
                ),
                const SizedBox(width: 5),
                Text(
                  location,
                  style: GoogleFonts.poppins(
                    color: ConstantColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, notificationRoute),
                  child: const Icon(
                    Icons.notifications,
                    color: ConstantColors.whiteColor,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () => onMenuPressed(),
                  child: const Icon(
                    Icons.menu,
                    color: ConstantColors.whiteColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget tile({required Function onPressed, required String title}) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
      onTap: () => onPressed(),
    );
  }

  Widget drawer(BuildContext context) {
    return Drawer(
      backgroundColor: ConstantColors.main,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: ConstantColors.whiteColor,
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hey There !",
                        style: GoogleFonts.poppins(
                          color: ConstantColors.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            height: MediaQuery.of(context).size.height / 1.4,
            decoration: const BoxDecoration(
              color: ConstantColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                tile(
                  onPressed: () {
                    Navigator.pushNamed(context, editProfileRoute);
                  },
                  title: "Edit Profile",
                ),
                tile(
                  onPressed: () {
                    Navigator.pushNamed(context, notificationRoute);
                  },
                  title: "Notifications",
                ),
                // tile(
                //   onPressed: () {
                //     Navigator.pushNamed(context, orderRoute);
                //   },
                //   title: "My Orders",
                // ),
                tile(
                  onPressed: () {
                    Navigator.pushNamed(context, referRoute);
                  },
                  title: "Invite Friends",
                ),
                tile(
                  onPressed: () {
                    Navigator.pushNamed(context, aboutUsRoute);
                  },
                  title: "About Us",
                ),
                tile(
                  onPressed: () {
                    Navigator.pushNamed(context, contactUsRoute);
                  },
                  title: "Contact Us",
                ),
                tile(
                  onPressed: () {
                    Navigator.pushNamed(context, ppRoute);
                  },
                  title: "Privacy Policy",
                ),
                tile(
                  onPressed: () {
                    Navigator.pushNamed(context, tosRoute);
                  },
                  title: "Terms and Conditions",
                ),
                tile(
                  onPressed: () {
                    Provider.of<AuthService>(context, listen: false)
                        .logout(context)
                        .then((value) {
                      if (value != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, signInRoute, (route) => false);
                      }
                    });
                  },
                  title: "Logout",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputDecoration({required Widget textField}) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: ConstantColors.main,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: textField,
    );
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'Just Now';
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);

      _img = imageTemp;
      notifyListeners();

      return _img;
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
