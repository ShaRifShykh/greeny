class Category {
  final int id;
  final String name;
  final String image;
  final String createdAt;

  Category.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['category_name'] ?? "",
        image = jsonMap['image'] ?? "",
        createdAt = jsonMap['created_at'] ?? "";
}
