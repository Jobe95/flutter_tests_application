import 'package:flutter_test/flutter_test.dart';
import 'package:test_application/models/counter.dart';

void main() {
  group('Counter test', () {
    test('Initial counter should be 0', () {
      expect(Counter().value, 0);
    });
    test('Counter should increment to 1', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, greaterThan(0));
    });
    test('Counter should decrement but no more than 0', () {
      final counter = Counter();
      counter.increment();
      counter.decrement();
      counter.decrement();
      counter.decrement();

      expect(counter.value, 0);
    });
  });
}
