import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/ui/async_data/async_data_change_notifier.dart';
import 'package:test_application/ui/async_data/async_data_show_service.dart';
import 'package:test_application/ui/counter/counter_change_notifier.dart';
import 'package:test_application/ui/ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => CounterChangeNotifier(),
                      child: const CounterPage(),
                    ),
                  ),
                );
              },
              child: const Text('Go to counter demo'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) =>
                          AsyncDataChangeNotifier(AsyncDataShowService()),
                      child: const AsyncDataPage(),
                    ),
                  ),
                );
              },
              child: const Text('Go api demo'),
            ),
          ],
        ),
      ),
    );
  }
}
