import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  HiveConfig._();

  static const String authBoxName = 'auth_box';
  static const String favoritesBoxName = 'favorites_box';
  static const String cartBoxName = 'cart_box';

  static const String tokenKey = 'token';
  static const String favoriteIdsKey = 'favorite_course_ids';
  static const String cartIdsKey = 'cart_course_ids';

  static late Box authBox;
  static late Box favoritesBox;
  static late Box cartBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    authBox = await Hive.openBox(authBoxName);
    favoritesBox = await Hive.openBox(favoritesBoxName);
    cartBox = await Hive.openBox(cartBoxName);
  }
}
