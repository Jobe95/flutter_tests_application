import 'package:flutter/material.dart';
import 'package:test_application/models/models.dart';

class CounterChangeNotifier extends ChangeNotifier {
  final counter = Counter();

  void increment() {
    counter.increment();
    notifyListeners();
  }

  void decrement() {
    counter.decrement();
    notifyListeners();
  }
}
