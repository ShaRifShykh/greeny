class Extra {
  final int id;
  final String appName;
  final String appLogo;
  final String address;
  final String phoneNumber;
  final String email;
  final String termsAndConditions;
  final String privacyPolicy;
  final String aboutUs;

  Extra.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        appName = jsonMap['app_name'] ?? "",
        appLogo = jsonMap['app_logo'] ?? "",
        address = jsonMap['address'] ?? "",
        phoneNumber = jsonMap['phone'] ?? "",
        email = jsonMap['email'] ?? "",
        termsAndConditions = jsonMap['terms_and_conditions'] ?? "",
        privacyPolicy = jsonMap['privacy_policy'] ?? "",
        aboutUs = jsonMap['about_us'] ?? "";
}
