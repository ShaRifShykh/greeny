import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/application/services/trial_service.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/views/auth/auth_helper.dart';
import 'package:greeny/widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _signIn() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      Provider.of<AuthService>(context, listen: false)
          .signIn(
        context,
        _email.text,
        _password.text,
      )
          .then((value) {
        if (value != null) {
          Provider.of<TrialService>(context, listen: false)
              .getTrial()
              .then((value) {
            if ((LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) != null) &&
                (int.parse(LocalStorage.getItem(TRIAL_EXPIRATION_DAYS_LEFT) ??
                        "0") >
                    0)) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                mainRoute,
                (route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                initialRoute,
                (route) => false,
              );
            }
          });
        }
      });
    } else {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Input Fields can't be empty!",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.main,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Provider.of<AuthHelper>(context, listen: false).spacing(
              context: context,
              spacing: 500,
            ),
            Provider.of<AuthHelper>(context, listen: false).contentBody(
              context: context,
              widget: Column(
                children: [
                  Provider.of<AuthHelper>(context, listen: false)
                      .heading(text: "Sign In"),
                  const SizedBox(height: 50),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Email",
                        hintStyle: GoogleFonts.poppins(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.mail,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Password",
                        hintStyle: GoogleFonts.poppins(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.lock,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Provider.of<AuthHelper>(context, listen: false)
                      .signUpRedirection(
                    onTap: () {
                      Navigator.pushNamed(context, signUpRoute);
                    },
                  ),
                  const SizedBox(height: 30),
                  MainButton(
                    onTap: () => _signIn(),
                    text: "Sign In",
                  ),
                  const SizedBox(height: 50),
                  Provider.of<AuthHelper>(context).footerLinks(
                    TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, tosRoute);
                      },
                    TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, ppRoute);
                      },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
