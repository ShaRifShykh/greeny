import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/application/services/trial_service.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/values/path.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final images = [Path.i2, Path.i1, Path.i3];

  _getUser() {
    Provider.of<AuthService>(context, listen: false).getUser();
  }

  _startTrial() {
    Provider.of<TrialService>(context, listen: false)
        .startTrial()
        .then((value) {
      if (value != null) {
        Navigator.pushNamedAndRemoveUntil(context, mainRoute, (route) => false);
      }
    });
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                Path.pngLogo,
                height: 140,
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 300,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    );
                  },
                  loop: true,
                  autoplay: true,
                  duration: 1200,
                  itemCount: images.length,
                ),
              ),
              const SizedBox(height: 50),
              LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) == null &&
                      (int.parse(LocalStorage.getItem(
                                  TRIAL_EXPIRATION_DAYS_LEFT) ??
                              "0") <=
                          0)
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _startTrial();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: ConstantColors.main,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Get Free Trial for 30 Days",
                                style: GoogleFonts.roboto(
                                  color: ConstantColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "OR",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: ConstantColors.main,
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    )
                  : Container(),
              GestureDetector(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
