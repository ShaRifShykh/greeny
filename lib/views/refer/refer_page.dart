import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:provider/provider.dart';

class ReferPage extends StatelessWidget {
  const ReferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthService>(context, listen: false).user;

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: ConstantColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 100,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ConstantColors.main,
                    width: 10,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.network(
                  "https://greeny.ie/storage/qr-code/img-1658162338.svg",
                ),
              ),
              const SizedBox(height: 60),
              Text(
                "Greeny User",
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user!.referralCode.toUpperCase(),
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Scan for a 30 day free trial",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: ConstantColors.textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
