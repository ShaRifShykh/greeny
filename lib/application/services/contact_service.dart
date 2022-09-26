// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class ContactService extends ChangeNotifier {
  Future reportIssue({required String issue}) async {
    try {
      String? token = LocalStorage.getItem(TOKEN);

      var res = await GreenyApi.dio.post(
        "support/report-issue",
        data: {
          "issue": issue,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return res;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future askQuestion({required String question}) async {
    try {
      String? token = LocalStorage.getItem(TOKEN);

      var res = await GreenyApi.dio.post(
        "support/ask-question",
        data: {
          "question": question,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return res;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future requestFeature({required String feature}) async {
    try {
      String? token = LocalStorage.getItem(TOKEN);

      var res = await GreenyApi.dio.post(
        "support/request-feature",
        data: {
          "feature": feature,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return res;
    } on DioError catch (e) {
      print(e);
    }
  }
}
