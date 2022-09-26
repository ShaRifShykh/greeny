import 'package:greeny/application/models/brand.dart';

class FeaturedBrand {
  final int id;
  final String title;
  final int price;
  final Brand? brand;
  final String createdAt;

  FeaturedBrand.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        title = jsonMap['title'] ?? "",
        price = jsonMap['price'] ?? 0,
        brand =
            jsonMap['brand'] != null ? Brand.fromJson(jsonMap['brand']) : null,
        createdAt = jsonMap['created_at'] ?? "";
}
