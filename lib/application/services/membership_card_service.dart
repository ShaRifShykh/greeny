// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greeny/application/greeny_api.dart';
import 'package:greeny/application/models/membership_card.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/application/storage/storage_keys.dart';

class MembershipCardService extends ChangeNotifier {
  MembershipCard? _membershipCard;
  MembershipCard? get membershipCard => _membershipCard;

  Future createMembershipCard(String membershipID) async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "memberships/card/create/" + membershipID,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _membershipCard = MembershipCard.fromJson(res.data["membership-card"]);

      String expiresAt = res.data["expire_at"].toString();
      LocalStorage.setItem(MEMBERSHIP_CARD_EXPIRATION_DATE, expiresAt);

      notifyListeners();

      return _membershipCard;
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future getMembershipCard() async {
    try {
      String? token = LocalStorage.getItem(TOKEN);
      var res = await GreenyApi.dio.get(
        "memberships/card/details",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      _membershipCard = MembershipCard.fromJson(res.data["membership-card"]);

      String expiresAt = _membershipCard!.expiresAt;
      LocalStorage.setItem(MEMBERSHIP_CARD_EXPIRATION_DATE, expiresAt);

      notifyListeners();

      return _membershipCard;
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
