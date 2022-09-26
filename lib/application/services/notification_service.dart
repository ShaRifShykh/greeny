import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/notifications.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class NotificationService extends ChangeNotifier {
  List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;

  Future getNotifications() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "notifications",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _notifications = [];

      for (var element in (res.data as List)) {
        _notifications.add(Notifications.fromJson(element));
      }

      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
