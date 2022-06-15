import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/ui/counter/counter_change_notifier.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter test demo'),
      ),
      body: Center(
        child: Consumer<CounterChangeNotifier>(
          builder: ((context, notifier, child) =>
              Text('Counter: ${notifier.counter.value}')),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () => context.read<CounterChangeNotifier>().increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () => context.read<CounterChangeNotifier>().decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
