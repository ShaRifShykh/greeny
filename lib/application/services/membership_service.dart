// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/membership.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class MembershipService extends ChangeNotifier {
  List<Membership> _memberships = [];
  List<Membership> get memberships => _memberships;

  Future getMemberships() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "memberships",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _memberships = [];

      for (var element in (res.data as List)) {
        _memberships.add(Membership.fromJson(element));
      }

      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
