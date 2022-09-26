import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/contact_service.dart';
import 'package:greeny/application/services/extra_service.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/views/extra/extra_helper.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController issue = TextEditingController();
  final TextEditingController feature = TextEditingController();
  final TextEditingController question = TextEditingController();

  submitIssue() {
    if (issue.text.isNotEmpty) {
      Provider.of<ContactService>(context, listen: false)
          .reportIssue(issue: issue.text)
          .then((value) {
        if (value != null) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Issue Submitted!",
              textStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          );
        }
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Issue field can't be empty!",
          textStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  submitFeature() {
    if (feature.text.isNotEmpty) {
      Provider.of<ContactService>(context, listen: false)
          .requestFeature(feature: feature.text)
          .then((value) {
        if (value != null) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Feature Submitted!",
              textStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          );
        }
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Feature field can't be empty!",
          textStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  submitQuestion() {
    if (question.text.isNotEmpty) {
      Provider.of<ContactService>(context, listen: false)
          .askQuestion(question: question.text)
          .then((value) {
        if (value != null) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Question Submitted!",
              textStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          );
        }
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Question field can't be empty!",
          textStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var extra = Provider.of<ExtraHelper>(context, listen: false);
    var extraService = Provider.of<ExtraService>(context, listen: true).extra;

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We're here to help.",
                style: GoogleFonts.roboto(
                  color: ConstantColors.main,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              extra.listBtn(
                onTap: () {
                  extra.modalBottomSheet(
                    context: context,
                    onIconTap: () => submitIssue(),
                    title: "Report an Issue",
                    placeHolderText: "Enter Issue",
                    controller: issue,
                  );
                },
                icon: Icons.error_outline_sharp,
                text: "Report an issue",
              ),
              const SizedBox(height: 8),
              extra.listBtn(
                onTap: () {
                  extra.modalBottomSheet(
                    context: context,
                    onIconTap: () => submitFeature(),
                    title: "Request a Feature",
                    placeHolderText: "Enter Feature",
                    controller: feature,
                  );
                },
                icon: FontAwesomeIcons.lightbulb,
                text: "Request a Feature",
              ),
              const SizedBox(height: 8),
              extra.listBtn(
                onTap: () {
                  extra.modalBottomSheet(
                    context: context,
                    onIconTap: () => submitQuestion(),
                    title: "Ask a Question",
                    placeHolderText: "Enter your question",
                    controller: question,
                  );
                },
                icon: Icons.contact_support_outlined,
                text: "Ask a Question",
              ),
              const SizedBox(height: 25),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ConstantColors.main,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Email",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Send us an email to ${extraService!.email}",
                style: GoogleFonts.roboto(
                  color: ConstantColors.textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
