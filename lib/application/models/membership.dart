class Membership {
  final int id;
  final String name;
  final int price;
  final String duration;
  final String createdAt;

  Membership.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['type'] ?? "",
        price = jsonMap['price'] ?? 0,
        duration = jsonMap['duration'] ?? "",
        createdAt = jsonMap['created_at'] ?? "";
}
