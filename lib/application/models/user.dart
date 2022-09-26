import 'package:greeny/application/models/user_trial.dart';

class User {
  final int id;
  final String profileImage;
  final String title;
  final String fullName;
  final String email;
  final String dateOfBirth;
  final String phoneNumber;
  final String address;
  final String referralCode;
  final String createdAt;
  final UserTrial? userTrial;

  User.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        profileImage = jsonMap['profile_image'] ?? "",
        title = jsonMap['title'] ?? "",
        fullName = jsonMap['full_name'] ?? "",
        email = jsonMap['email'] ?? "",
        dateOfBirth = jsonMap['date_of_birth'] ?? "",
        phoneNumber = jsonMap['phone_number'] ?? "",
        address = jsonMap['address'] ?? "",
        referralCode = jsonMap['referral_code'] ?? "",
        createdAt = jsonMap['created_at'] ?? "",
        userTrial = jsonMap['trial'] != null
            ? UserTrial.fromJson(jsonMap['trial'])
            : null;
}
