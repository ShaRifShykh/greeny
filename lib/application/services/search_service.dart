// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/brand.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class SearchService extends ChangeNotifier {
  List<Brand> _brands = [];
  List<Brand> get brands => _brands;

  Future getSearchedBrand({required String search}) async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.post(
        "brands/search",
        data: {
          "search": search,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _brands = [];

      // print(res.data);
      for (var element in (res.data as List)) {
        _brands.add(Brand.fromJson(element));
      }

      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
