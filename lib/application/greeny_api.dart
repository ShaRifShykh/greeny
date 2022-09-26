import 'package:dio/dio.dart';
import 'package:greeny/values/common.dart';

class GreenyApi {
  static final BaseOptions _baseOptions = BaseOptions(baseUrl: Common.baseUrl);

  // For unauthenticated routes
  static Dio dio = Dio(_baseOptions);

  // For authenticated routes
  static Dio dioAuth() {
    return Dio();
  }
}
