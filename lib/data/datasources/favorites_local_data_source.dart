import '../../core/config/hive_config.dart';
abstract class FavoritesLocalDataSource {
  List<int> getFavoriteIds();
  Future<List<int>> toggleFavorite(int courseId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  @override
  List<int> getFavoriteIds() {
    final raw = HiveConfig.favoritesBox
        .get(HiveConfig.favoriteIdsKey, defaultValue: <dynamic>[]) as List;
    return raw.cast<int>();
  }

  @override
  Future<List<int>> toggleFavorite(int courseId) async {
    final ids = getFavoriteIds();
    if (ids.contains(courseId)) {
      ids.remove(courseId);
    } else {
      ids.add(courseId);
    }
    await HiveConfig.favoritesBox.put(HiveConfig.favoriteIdsKey, ids);
    return ids;
  }
}
