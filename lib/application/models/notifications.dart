class Notifications {
  final int id;
  final String title;
  final String description;
  final String image;
  final String createdAt;

  Notifications.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        title = jsonMap['title'] ?? "",
        description = jsonMap['description'] ?? "",
        image = jsonMap['image'] ?? "",
        createdAt = jsonMap['created_at'] ?? "";
}
