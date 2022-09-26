import 'package:greeny/application/models/membership.dart';
import 'package:greeny/application/models/user.dart';

class Order {
  final int id;
  final String orderNo;
  final String amount;
  final String status;
  final User? user;
  final Membership? membership;
  final String createdAt;

  Order.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        orderNo = jsonMap['name'] ?? "",
        amount = jsonMap['email'] ?? "",
        status = jsonMap['phone'] ?? "",
        user = jsonMap['user'] != null ? User.fromJson(jsonMap['user']) : null,
        membership = jsonMap['membership'] != null
            ? Membership.fromJson(jsonMap['membership'])
            : null,
        createdAt = jsonMap['created_at'] ?? "";
}
