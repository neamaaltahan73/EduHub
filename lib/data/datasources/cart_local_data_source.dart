import '../../core/config/hive_config.dart';
abstract class CartLocalDataSource {
  List<int> getCartIds();
  Future<List<int>> addToCart(int courseId);
  Future<List<int>> removeFromCart(int courseId);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  @override
  List<int> getCartIds() {
    final raw = HiveConfig.cartBox
        .get(HiveConfig.cartIdsKey, defaultValue: <dynamic>[]) as List;
    return raw.cast<int>();
  }

  @override
  Future<List<int>> addToCart(int courseId) async {
    final ids = getCartIds();
    if (!ids.contains(courseId)) {
      ids.add(courseId);
      await HiveConfig.cartBox.put(HiveConfig.cartIdsKey, ids);
    }
    return ids;
  }

  @override
  Future<List<int>> removeFromCart(int courseId) async {
    final ids = getCartIds();
    ids.remove(courseId);
    await HiveConfig.cartBox.put(HiveConfig.cartIdsKey, ids);
    return ids;
  }
}
