import 'package:test_application/models/show.dart';

import '../../api/api.dart';

class AsyncDataShowService {
  final _api = Api();

  Future<List<Show>> getShows() async {
    return await _api.getShows();
  }
}
