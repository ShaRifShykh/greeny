// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/extra.dart';

class ExtraService extends ChangeNotifier {
  Extra? extra;

  Future getService() async {
    try {
      var res = await GreenyApi.dio.get("config");
      print(res.data);
      extra = Extra.fromJson(res.data);
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
