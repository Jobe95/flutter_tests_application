/// Counter that has a value property with initial value of 0
class Counter {
  int value = 0;

  /// Increases value with 1
  void increment() => value++;

  /// Decrements value with 1 but cant go below 0
  void decrement() {
    if (value <= 0) {
      value = 0;
    } else {
      value--;
    }
  }
}
