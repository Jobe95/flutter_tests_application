import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_application/models/show.dart';
import 'package:test_application/ui/async_data/async_data_change_notifier.dart';
import 'package:test_application/ui/async_data/async_data_show_service.dart';

class MockShowService extends Mock implements AsyncDataShowService {}

void main() {
  late AsyncDataChangeNotifier sut;
  late MockShowService mockShowService;

  setUp(() {
    mockShowService = MockShowService();
    sut = AsyncDataChangeNotifier(mockShowService);
  });

  test('Initial values are correct', () {
    expect(sut.shows, []);
    expect(sut.isLoading, false);
  });

  group('getShows', () {
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

    test('Get shows using the ShowService', () async {
      arrangeShowsServiceReturnsThreeShows();
      await sut.getShows();
      verify(() => mockShowService.getShows()).called(1);
    });

    test('''Indicates loading of data,
    sets shows to the ones from the service,
    indicates that data is not loading anymore''', () async {
      arrangeShowsServiceReturnsThreeShows();
      final future = sut.getShows();
      expect(sut.isLoading, true);
      await future;
      expect(sut.shows, showsFromService);
      expect(sut.isLoading, false);
    });
  });
}
