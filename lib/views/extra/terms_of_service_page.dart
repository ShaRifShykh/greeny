import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/extra_service.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:provider/provider.dart';

class TermsOfServicePage extends StatefulWidget {
  const TermsOfServicePage({Key? key}) : super(key: key);

  @override
  State<TermsOfServicePage> createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  getData() {
    Provider.of<ExtraService>(context, listen: false).getService();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _extra = Provider.of<ExtraService>(context, listen: true);

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Terms Of Service",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: _extra.extra == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Html(
                  data: _extra.extra!.termsAndConditions,
                  shrinkWrap: true,
                  style: {
                    // tables will have the below background color
                    "p": Style(
                      color: ConstantColors.textColor,
                    ),
                    "li": Style(
                      color: ConstantColors.textColor,
                    ),
                    "strong": Style(
                      color: ConstantColors.black.withOpacity(0.7),
                    ),
                  },
                ),
        ),
      ),
    );
  }
}
