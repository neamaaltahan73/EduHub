import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
class ApiConfig {
  ApiConfig._();

  static const int port = 8000;

  static const bool useRealDeviceIp = false;
  static const String realDeviceIp = '192.168.1.50';

  static String get baseUrl {
    if (useRealDeviceIp) return 'http://$realDeviceIp:$port';
    if (kIsWeb) return 'http://127.0.0.1:$port';
    if (Platform.isAndroid) return 'http://10.0.2.2:$port';
    return 'http://127.0.0.1:$port';
  }

  static const String loginEndpoint = '/api/login';
  static const String logoutEndpoint = '/api/logout';
  static const String coursesEndpoint = '/api/courses';
  static const String profileEndpoint = '/api/profile';
}
