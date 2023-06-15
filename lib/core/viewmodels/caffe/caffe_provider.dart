import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/caffe/caffe_model.dart';
import 'package:flutter_caffe_ku/core/services/caffe/caffe_service.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:provider/provider.dart';

class CaffeProvider extends ChangeNotifier {
  ///==========================
  /// This is Field or Property
  ///==========================

  /// List of caffes
  List<CaffeModel>? _caffes;
  List<CaffeModel>? get caffes => _caffes;

  /// Detail of Caffe
  CaffeModel? _caffe;
  CaffeModel? get caffe => _caffe;

  /// List of city
  List<String>? _cities;
  List<String>? get cities => _cities;

  /// List of search result caffes
  List<CaffeModel>? _searchCaffes;
  List<CaffeModel>? get searchCaffes => _searchCaffes;

  /// List of caffe by Cities
  List<CaffeModel>? _caffesByCity;
  List<CaffeModel>? get caffesByCity => _caffesByCity;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  final caffeServices = locator<CaffeService>();

  ///=========================
  /// Function Logic
  ///=========================

  /// Instance provider
  static CaffeProvider instance(BuildContext context) {
    return Provider.of<CaffeProvider>(context, listen: false);
  }

  /// Find List of Caffe from APi
  Future<void> getCaffes() async {
    await Future.delayed(const Duration(microseconds: 100));
    setOnSearch(true);
    try {
      final result = await caffeServices.getCaffes();
      if (result.error == false) {
        _caffes = result.data;
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _caffes = [];
    }
    setOnSearch(false);
  }

  /// Get Detail Of Caffe
  Future<void> getCaffe(String id) async {
    await Future.delayed(const Duration(microseconds: 100));
    setOnSearch(true);
    try {
      final result = await caffeServices.getCaffe(id);
      if (result.error == false) {
        _caffe = result.data;
      } else {
        _caffe = CaffeModel.failure();
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _caffe = CaffeModel.failure();
    }
    setOnSearch(false);
  }

  /// Find List of Caffes BY Cities
  void getRestaurantsByCity(String city) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    if (_caffes == null) {
      await getCaffes();
    } else {
      try {
        _caffesByCity = _caffes!
            .where((item) => item.city.toLowerCase() == city.toLowerCase())
            .toList();
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        _caffesByCity = [];
      }
      setOnSearch(false);
    }
  }

  /// Finding list of city from local assets
  void getCities() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await caffeServices.getCaffes();
      if (result.error == false) {
        _cities =
            result.data!.map((e) => e.city).toSet().toList().reversed.toList();
      } else {
        _cities = [];
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      _cities = [];
    }
    setOnSearch(false);
  }

  /// Search caffe by keywords
  Future<void> search(String keyword) async {
    _searchCaffes = null;
    if (keyword.isEmpty) {
      _searchCaffes = null;
      setOnSearch(false);
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      setOnSearch(true);

      try {
        final result = await caffeServices.searchRestaurants(keyword);
        if (result.error == false) {
          _searchCaffes = result.data;
        } else {
          _searchCaffes = [];
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        _searchCaffes = [];
      }
      setOnSearch(false);
    }
  }

  void setOnSearch(bool value) {
    _onSearch = value;
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
