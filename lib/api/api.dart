import 'package:dio/dio.dart';
import 'package:test_application/models/models.dart';

class Api {
  var options = BaseOptions(
    baseUrl: 'https://api.tvmaze.com',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  late Dio dio;

  Api() {
    dio = Dio(options);
  }

  Future<List<Show>> getShows() async {
    try {
      var response = await dio.get('/shows');
      if (response.statusCode == 200) {
        final list = response.data as Iterable;

        return list.map((e) => Show.fromJson(e)).toList();
      } else {
        return [];
      }
    } on DioError {
      rethrow;
    }
  }
}
