import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ConnectionProvider extends ChangeNotifier {
  /// =================
  /// This is property
  /// =================

  /// Connectivity status
  bool? _internetConnected = true;
  bool? get internetConnected => _internetConnected;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency Injection

  /// ======================
  /// This is logic function
  /// ======================

  /// Instance provider
  static ConnectionProvider instance(BuildContext context) =>
      Provider.of<ConnectionProvider>(context, listen: false);

  void setConnection(bool value) {
    if (_internetConnected != value) {
      _internetConnected = value;
      notifyListeners();
    }
  }

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
