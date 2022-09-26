import 'package:greeny/application/models/category.dart';

class Brand {
  final int id;
  final String name;
  final String subTitle;
  final String email;
  final String phone;
  final String address;
  final String address2;
  final String latitude;
  final String longitude;
  final String description;
  final String video;
  final String image;
  final Category? category;
  final String createdAt;

  Brand.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['name'] ?? "",
        subTitle = jsonMap['sub_title'] ?? "",
        email = jsonMap['email'] ?? "",
        phone = jsonMap['phone'] ?? "",
        address = jsonMap['address'] ?? "",
        address2 = jsonMap['address2'] ?? "",
        latitude = jsonMap['latitude'] ?? "",
        longitude = jsonMap['longitude'] ?? "",
        description = jsonMap['description'] ?? "",
        video = jsonMap['video'] ?? "",
        image = jsonMap['image'] ?? "",
        category = jsonMap['category'] != null
            ? Category.fromJson(jsonMap['category'])
            : null,
        createdAt = jsonMap['created_at'] ?? "";
}
