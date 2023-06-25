import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/favorite/favorite_utils.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  /// =================
  /// This is property
  /// =================

  List<String>? _favorites;
  List<String>? get favorites => _favorites;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency Injection
  final favoriteUtils = locator<FavoriteUtils>();

  /// ======================
  /// This is logic function
  /// ======================

  /// Instance provider
  FavoriteProvider instance(BuildContext context) =>
      Provider.of<FavoriteProvider>(context, listen: false);

  /// get list of favorite caffe id
  Future<void> getFavorites() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    _favorites = await favoriteUtils.getFavorites();
    setOnSearch(false);
  }

  Future<void> toogleFavorite(String id) async {
    if (isFavorite(id) == false) {
      favoriteUtils.addFavorite(id);
    } else {
      favoriteUtils.removeFavorite(id);
    }
    getFavorites();
  }

  bool isFavorite(String id) => _favorites!.contains(id);

  // set event searh
  void setOnSearch(bool value) {
    _onSearch = true;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
