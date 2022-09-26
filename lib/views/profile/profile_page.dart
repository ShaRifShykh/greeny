import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthService>(context, listen: false).user;

    return Scaffold(
      backgroundColor: ConstantColors.main,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.3,
          decoration: const BoxDecoration(
            color: ConstantColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    child: user!.profileImage.isEmpty ||
                            user.profileImage == "def.png"
                        ? Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: ConstantColors.main,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              Common.imgUrl + "profile/" + user.profileImage,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  ((LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) != null) &&
                          (int.parse(LocalStorage.getItem(
                                      TRIAL_EXPIRATION_DAYS_LEFT) ??
                                  "0") >
                              0))
                      ? Container()
                      : Positioned(
                          top: 90,
                          left: 100,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: ConstantColors.whiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.star_rate_rounded,
                              color: ConstantColors.yellow,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                user.fullName,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(
                user.phoneNumber,
                style: GoogleFonts.roboto(
                  color: ConstantColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Referral Code".toUpperCase(),
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.textColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user.referralCode.toUpperCase(),
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              ((LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) != null) &&
                      (int.parse(LocalStorage.getItem(
                                  TRIAL_EXPIRATION_DAYS_LEFT) ??
                              "0") >
                          0))
                  ? Text(
                      "Your Trial Days left: ${LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT)}",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, membershipCardRoute),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.1, 0.7, 1],
                      colors: [
                        ConstantColors.main,
                        Colors.yellow,
                        ConstantColors.main,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: GoogleFonts.roboto(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: ConstantColors.whiteColor,
                            ),
                          ),
                          Text(
                            "View Membership Card",
                            style: GoogleFonts.roboto(
                              color: ConstantColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        FontAwesomeIcons.arrowRight,
                        color: ConstantColors.whiteColor,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ((LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) != null) &&
                      (int.parse(LocalStorage.getItem(
                                  TRIAL_EXPIRATION_DAYS_LEFT) ??
                              "0") >
                          0))
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, buyMembershipRoute);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ConstantColors.main,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Buy Membership",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              color: ConstantColors.main,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
