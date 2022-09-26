// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/brand.dart';
import 'package:greeny/application/models/featured_brand.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class BrandService extends ChangeNotifier {
  List<Brand> _brands = [];
  List<Brand> get brands => _brands;

  List<FeaturedBrand> _featuredBrands = [];
  List<FeaturedBrand> get featuredBrands => _featuredBrands;

  bool _isLoading = false;
  bool get getIsLoading => _isLoading;

  Future getBrands() async {
    try {
      _isLoading = true;
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "brands",
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

      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.response);
    }
  }

  Future getFeaturedBrands() async {
    try {
      _isLoading = true;

      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "brands/featured",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _featuredBrands = [];

      // print(res.data);
      for (var element in (res.data as List)) {
        _featuredBrands.add(FeaturedBrand.fromJson(element));
      }

      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.response);
    }
  }
}
