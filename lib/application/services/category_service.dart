// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/brand.dart';
import 'package:greeny/application/models/category.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class CategoryService extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Brand> _categoryBrands = [];
  List<Brand> get categoryBrands => _categoryBrands;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getCategories() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "category",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _categories = [];

      for (var element in (res.data as List)) {
        _categories.add(Category.fromJson(element));
      }

      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

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

      _categoryBrands = [];

      // print(res.data);
      for (var element in (res.data as List)) {
        _categoryBrands.add(Brand.fromJson(element));
      }

      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.response);
    }
  }

  Future getCategoryBrands(String categoryID) async {
    try {
      _isLoading = true;
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "brands/$categoryID",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _categoryBrands = [];

      // print(res.data);
      for (var element in (res.data as List)) {
        _categoryBrands.add(Brand.fromJson(element));
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
