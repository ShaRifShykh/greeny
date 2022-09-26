import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/widgets/main_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController dOB = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();

  updateProfile({required File? profileImage}) {
    Provider.of<AuthService>(context, listen: false)
        .updateUserInfo(
      profileImage: profileImage,
      title: title.text,
      fullName: fullName.text,
      phoneNumber: phone.text,
      address: address.text,
    )
        .then((value) {
      if (value != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "Profile Updated!",
            textStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var common = Provider.of<Common>(context, listen: true);
    var user = Provider.of<AuthService>(context, listen: true).user;
    title.text = user!.title;
    fullName.text = user.fullName;
    email.text = user.email;
    dOB.text = DateFormat('d-MM-y').format(DateTime.parse(user.dateOfBirth));
    phone.text = user.phoneNumber;
    address.text = user.address;

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  user.profileImage.isEmpty || user.profileImage == "def.png"
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
                  Positioned(
                    top: 90,
                    left: 100,
                    child: GestureDetector(
                        onTap: () {
                          common.pickImage().then((value) {
                            if (value != null) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  message: "Profile Image Selected!",
                                  textStyle: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: ConstantColors.whiteColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: ConstantColors.main,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Provider.of<Common>(context, listen: false).inputDecoration(
                textField: TextField(
                  controller: title,
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
              const SizedBox(height: 15),
              Provider.of<Common>(context, listen: false).inputDecoration(
                textField: TextField(
                  controller: fullName,
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
              const SizedBox(height: 15),
              Provider.of<Common>(context, listen: false).inputDecoration(
                textField: TextField(
                  controller: email,
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Email Address",
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
              const SizedBox(height: 15),
              Provider.of<Common>(context, listen: false).inputDecoration(
                textField: TextField(
                  controller: dOB,
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Date Of Birth",
                    hintStyle: GoogleFonts.roboto(
                      color: ConstantColors.main,
                    ),
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: ConstantColors.main,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Provider.of<Common>(context, listen: false).inputDecoration(
                textField: TextField(
                  controller: phone,
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
              const SizedBox(height: 15),
              Provider.of<Common>(context, listen: false).inputDecoration(
                textField: TextField(
                  controller: address,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Address",
                    hintStyle: GoogleFonts.roboto(
                      color: ConstantColors.main,
                    ),
                    suffixIcon: const Icon(
                      Icons.location_pin,
                      color: ConstantColors.main,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              MainButton(
                onTap: () => updateProfile(
                  profileImage: common.getimg,
                ),
                text: "Update Profile",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
