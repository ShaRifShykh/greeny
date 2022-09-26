import 'package:greeny/application/models/brand.dart';

class Banners {
  final int id;
  final String title;
  final String image;
  final Brand? brand;
  final String createdAt;

  Banners.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        title = jsonMap['title'] ?? "",
        image = jsonMap['image'] ?? "",
        brand =
            jsonMap['brand'] != null ? Brand.fromJson(jsonMap['brand']) : null,
        createdAt = jsonMap['created_at'] ?? "";
}
