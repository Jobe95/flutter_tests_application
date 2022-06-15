import 'package:flutter/material.dart';
import 'package:test_application/models/models.dart';

import 'async_data_show_service.dart';

class AsyncDataChangeNotifier extends ChangeNotifier {
  final AsyncDataShowService _asyncDataShowService;

  AsyncDataChangeNotifier(this._asyncDataShowService);

  List<Show> _shows = [];
  List<Show> get shows => _shows;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getShows() async {
    setIsLoading(true);
    _shows = await _asyncDataShowService.getShows();
    setIsLoading(false);
  }
}
