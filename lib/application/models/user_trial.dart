import 'package:greeny/application/models/user.dart';

class UserTrial {
  final int id;
  final String trialUntil;
  final String daysLeft;
  final User? user;
  final String createdAt;

  UserTrial.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        trialUntil = jsonMap['trial_until'] ?? "",
        daysLeft = jsonMap['leftDays'] ?? "",
        user = jsonMap['user'] != null ? User.fromJson(jsonMap['user']) : null,
        createdAt = jsonMap['created_at'] ?? "";
}
