import 'package:flutter/cupertino.dart';

abstract class Controller with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loadingStarted() {
    _isLoading = true;
    notifyListeners();
  }

  void loadingFinished() {
    _isLoading = false;
    notifyListeners();
  }
}
