// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/banner.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class BannerService extends ChangeNotifier {
  List<Banners> _banners = [];
  List<Banners> get banners => _banners;

  Future getBanners() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "banners",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _banners = [];

      for (var element in (res.data as List)) {
        _banners.add(Banners.fromJson(element));
      }

      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
