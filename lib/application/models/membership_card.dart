import 'package:greeny/application/models/membership.dart';

class MembershipCard {
  final int id;
  final Membership? membership;
  final String expiresAt;
  final String createdAt;

  MembershipCard.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        membership = jsonMap['membership'] != null
            ? Membership.fromJson(jsonMap['membership'])
            : null,
        expiresAt = jsonMap['expires_at'] ?? "",
        createdAt = jsonMap['created_at'] ?? "";
}
