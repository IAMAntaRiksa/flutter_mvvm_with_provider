import 'dart:async';

import 'package:flutter_caffe_ku/core/utils/global/shared_manager.dart';

class FavoriteUtils {
  final String _key = "favorites";

  Future<List<String>> getFavorites() async {
    final shared = SharedManager<List<String>>();
    List<String>? data = await shared.read(_key);
    return data ?? [];
  }

  Future<void> addFavorite(String id) async {
    final shared = SharedManager<List<String>>();
    final favorites = await getFavorites();
    favorites.add(id);
    await shared.store(_key, favorites);
  }

  Future<void> removeFavorite(String id) async {
    final shared = SharedManager<List<String>>();
    final favorites = await getFavorites();
    favorites.remove(id);
    await shared.store(_key, favorites);
  }
}
