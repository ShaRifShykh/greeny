// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/user_trial.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class TrialService extends ChangeNotifier {
  UserTrial? _userTrial;

  Future getTrial() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);

      var res = await GreenyApi.dio.get(
        "users-trial",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (res.data["trial-days"] != null) {
        String trialDays = res.data["trial-days"].toString();
        return LocalStorage.setItem(TRIAL_EXPIRATION_DAYS_LEFT, trialDays);
      }
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future startTrial() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);

      var res = await GreenyApi.dio.get(
        "trial",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _userTrial = UserTrial.fromJson(res.data["trial"]);

      String trialDays = res.data["trial-days"].toString();
      LocalStorage.setItem(TRIAL_EXPIRATION_DAYS_LEFT, trialDays);

      notifyListeners();
      return _userTrial;
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
