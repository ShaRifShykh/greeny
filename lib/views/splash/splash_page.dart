import 'dart:async';
import 'package:flutter/material.dart';
import 'package:greeny/application/services/membership_card_service.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/values/path.dart';
import 'package:greeny/application/services/trial_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _getUserTrialOrMemberShipCard() {
    if (LocalStorage.getItem(TOKEN) != null) {
      Provider.of<TrialService>(context, listen: false).getTrial();
      Provider.of<MembershipCardService>(context, listen: false)
          .getMembershipCard();
    }
  }

  @override
  void initState() {
    _getUserTrialOrMemberShipCard();
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
        context,
        LocalStorage.getItem(TOKEN) == null
            ? signInRoute
            : ((LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) != null) &&
                    (int.parse(
                            LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) ??
                                "0") >
                        0))
                ? mainRoute
                : ((LocalStorage.getItem(MEMBERSHIP_CARD_EXPIRATION_DATE) !=
                            null) &&
                        DateTime.parse(LocalStorage.getItem(
                                        MEMBERSHIP_CARD_EXPIRATION_DATE) ??
                                    "")
                                .compareTo(DateTime.now()) >=
                            0)
                    ? mainRoute
                    : initialRoute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      body: Center(
        child: Image.asset(
          Path.pngLogo,
          width: MediaQuery.of(context).size.width - 100,
        ),
      ),
    );
  }
}
