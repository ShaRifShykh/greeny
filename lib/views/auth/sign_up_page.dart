import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/views/auth/auth_helper.dart';
import 'package:greeny/widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _referralCode = TextEditingController();
  DateTime? date;

  String getText() {
    if (date == null) {
      return "Date of Birth";
    } else {
      return "${date!.month}/${date!.day}/${date!.year}";
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
    });
  }

  void _signUp({required BuildContext context}) {
    if (_title.text.isNotEmpty &&
        _fullName.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _confirmPassword.text.isNotEmpty &&
        _phoneNumber.text.isNotEmpty &&
        _address.text.isNotEmpty &&
        date != null) {
      Provider.of<AuthService>(context, listen: false)
          .register(
        context,
        _title.text,
        _fullName.text,
        _email.text,
        _password.text,
        _confirmPassword.text,
        date.toString(),
        _phoneNumber.text,
        _address.text,
        _referralCode.text,
      )
          .then((value) {
        if (value != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            initialRoute,
            (route) => false,
          );
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantColors.transparent,
      ),
      backgroundColor: ConstantColors.main,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Provider.of<AuthHelper>(context, listen: false).spacing(
              context: context,
              spacing: 580,
            ),
            Provider.of<AuthHelper>(context, listen: false).contentBody(
              context: context,
              widget: Column(
                children: [
                  Provider.of<AuthHelper>(context, listen: false)
                      .heading(text: "Sign Up"),
                  const SizedBox(height: 50),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _title,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: GoogleFonts.roboto(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.person,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _fullName,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Full Name",
                        hintStyle: GoogleFonts.roboto(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.person,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Email",
                        hintStyle: GoogleFonts.roboto(
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
                        hintStyle: GoogleFonts.roboto(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.lock,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _confirmPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Password Again",
                        hintStyle: GoogleFonts.roboto(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.lock,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: GestureDetector(
                      onTap: () => pickDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getText(),
                              style: GoogleFonts.roboto(
                                color: ConstantColors.main,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              Icons.calendar_month,
                              color: ConstantColors.main,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _phoneNumber,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Phone Number",
                        hintStyle: GoogleFonts.roboto(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.phone,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _address,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Address",
                        hintStyle: GoogleFonts.roboto(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          Icons.location_on,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Optional:",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Provider.of<Common>(context, listen: false).inputDecoration(
                    textField: TextField(
                      controller: _referralCode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Refer Code",
                        hintStyle: GoogleFonts.roboto(
                          color: ConstantColors.main,
                        ),
                        suffixIcon: const Icon(
                          FontAwesomeIcons.peopleGroup,
                          color: ConstantColors.main,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  MainButton(
                    onTap: () => _signUp(context: context),
                    text: "Sign Up",
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
