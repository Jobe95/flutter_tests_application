import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:test_application/models/models.dart';
import 'package:test_application/ui/async_data/async_data_change_notifier.dart';
import 'package:test_application/ui/async_data/async_data_show_service.dart';
import 'package:test_application/ui/ui.dart';

class MockShowService extends Mock implements AsyncDataShowService {}

void main() {
  late MockShowService mockShowService;

  setUp(() {
    mockShowService = MockShowService();
  });

  final showsFromService = [
    Show(id: 1, name: 'Batman'),
    Show(id: 2, name: 'Spiderman'),
    Show(id: 3, name: 'Aquaman')
  ];

  void arrangeShowsServiceReturnsThreeShows() {
    when(() => mockShowService.getShows()).thenAnswer(
      (_) async => showsFromService,
    );
  }

  void arrangeShowsServiceReturnsThreeShowsAfterTwoSecondsWait() {
    when(() => mockShowService.getShows()).thenAnswer(
      (_) async {
        await Future.delayed(const Duration(seconds: 2));
        return showsFromService;
      },
    );
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => AsyncDataChangeNotifier(mockShowService),
        child: const AsyncDataPage(),
      ),
    );
  }

  // Static parts
  testWidgets('title is displayed', (WidgetTester tester) async {
    arrangeShowsServiceReturnsThreeShows();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Async data demo'), findsOneWidget);
  });

  // Dynamic parts

  testWidgets('loading indicator is shown while wating for shows',
      (WidgetTester tester) async {
    arrangeShowsServiceReturnsThreeShowsAfterTwoSecondsWait();

    await tester.pumpWidget(createWidgetUnderTest());

    // Trigger rebuilds after duration
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const Key('progress-indicator')), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('shows are displayed', (WidgetTester tester) async {
    arrangeShowsServiceReturnsThreeShows();

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pump();

    for (final show in showsFromService) {
      expect(find.text(show.name ?? ''), findsOneWidget);
    }
  });
}
