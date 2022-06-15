import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/ui/async_data/async_data_change_notifier.dart';
import 'package:test_application/ui/ui.dart';

class AsyncDataPage extends StatefulWidget {
  const AsyncDataPage({Key? key}) : super(key: key);

  @override
  State<AsyncDataPage> createState() => AsyncDataPageState();
}

class AsyncDataPageState extends State<AsyncDataPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<AsyncDataChangeNotifier>().getShows(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Async data demo'),
        ),
        body: Consumer<AsyncDataChangeNotifier>(
          builder: (context, notifier, child) {
            if (notifier.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  key: Key('progress-indicator'),
                ),
              );
            }
            return ListView.builder(
              itemCount: notifier.shows.length,
              itemBuilder: (context, index) {
                final show = notifier.shows[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailShowPage(show: show),
                        ),
                      );
                    },
                    title: Text(show.name ?? ''),
                    subtitle:
                        Text(show.rating?.average.toString() ?? 'No rating'),
                  ),
                );
              },
            );
          },
        ));
  }
}
