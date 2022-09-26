import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/application/services/membership_card_service.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/values/path.dart';
import 'package:provider/provider.dart';

class MembershipCardPage extends StatefulWidget {
  const MembershipCardPage({Key? key}) : super(key: key);

  @override
  State<MembershipCardPage> createState() => _MembershipCardPageState();
}

class _MembershipCardPageState extends State<MembershipCardPage> {
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secureScreen();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthService>(context, listen: true).user;
    var membershipCard =
        Provider.of<MembershipCardService>(context, listen: true)
            .membershipCard;

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                FontAwesomeIcons.xmark,
                color: ConstantColors.black,
              ),
            ),
          )
        ],
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Path.pngLogo,
                scale: 6,
              ),
              const SizedBox(height: 20),
              Text(
                "Digital Membership Card",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: ConstantColors.main,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 60),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
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
                      user!.fullName,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: ConstantColors.whiteColor,
                      ),
                    ),
                    Text(
                      ((LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) !=
                                  null) &&
                              (int.parse(LocalStorage.getItem(
                                          TRIAL_EXPIRATION_DAYS_LEFT) ??
                                      "0") >
                                  0))
                          ? "Trial Membership"
                          : "${membershipCard!.membership!.name} Membership",
                      style: GoogleFonts.roboto(
                        color: ConstantColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          // width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            Path.brBar,
                            width: 150,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "32145 98563 85614",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ConstantColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
