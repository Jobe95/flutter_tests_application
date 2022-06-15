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

  testWidgets(
    '''Tapping on the first show opens the show detail page
   where the full show content is displayed''',
    (WidgetTester tester) async {
      arrangeShowsServiceReturnsThreeShows();

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump();

      await tester.tap(find.text('Batman'));

      await tester.pumpAndSettle();

      expect(find.byType(AsyncDataPage), findsNothing);
      expect(find.byType(DetailShowPage), findsOneWidget);

      expect(find.text('Batman'), findsOneWidget);
    },
  );
}
