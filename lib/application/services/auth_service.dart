// ignore_for_file: avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/user.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthService extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future register(
    BuildContext context,
    String title,
    String fullName,
    String email,
    String password,
    String confirmPassword,
    String dateOfBirth,
    String phoneNumber,
    String address,
    String referralCode,
  ) async {
    try {
      var res = await GreenyApi.dio.post(
        "auth/signup",
        data: {
          "title": title,
          "fullName": fullName,
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
          "dateOfBirth": dateOfBirth,
          "phoneNumber": phoneNumber,
          "address": address,
          "referralCode": referralCode
        },
      );
      String accessToken = res.data["token"];

      await LocalStorage.setItem(TOKEN, accessToken);

      _user = User.fromJson(res.data["user"]);
      notifyListeners();

      return _user;
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        String message = "";
        Map<String, dynamic> errors = e.response!.data["errors"];
        for (var err in errors.values) {
          message += "$err \n";
        }
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: message,
            maxLines: 5,
            textStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        );
      } else {
        print(e);
      }
    }
  }

  Future signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      var res = await GreenyApi.dio.post(
        "auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      String accessToken = res.data["token"];

      await LocalStorage.setItem(TOKEN, accessToken);
      _user = User.fromJson(res.data["user"]);
      notifyListeners();

      // print(LocalStorage.getItem(TOKEN));
      return _user;
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        String message = "";
        Map<String, dynamic> errors = e.response!.data["errors"];
        for (var err in errors.values) {
          message += "$err \n";
        }
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: message,
            maxLines: 5,
            textStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        );
      } else {
        print(e);
      }
    }
  }

  Future getUser() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "auth/user",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _user = User.fromJson(res.data);
      notifyListeners();

      return res;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future updateUserInfo({
    required File? profileImage,
    required String title,
    required String fullName,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      String? fileName;
      if (profileImage != null) {
        fileName = profileImage.path.split('/').last;
      } else {
        fileName = null;
      }

      FormData data = FormData.fromMap({
        "profileImage": profileImage != null
            ? await MultipartFile.fromFile(
                profileImage.path,
                filename: fileName,
              )
            : null,
        "title": title,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "address": address,
      });

      var res = await GreenyApi.dio.post(
        "user/update-profile",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      _user = User.fromJson(res.data["user"]);
      notifyListeners();

      return res.data["user"];
    } on DioError catch (e) {
      print(e);
    }
  }

  Future logout(BuildContext context) async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "auth/logout",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      LocalStorage.clearAll();

      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: res.data["message"],
          textStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      );

      return res;
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
