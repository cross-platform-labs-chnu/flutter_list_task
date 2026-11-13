import 'package:dio/dio.dart';

import '../config/api_config.dart';
import '../models/feed_item.dart';

class FeedService {
  FeedService(this._dio);
  final Dio _dio;

  Future<FeedPage> fetchFeed({String? cursor}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/feed',
      queryParameters: cursor == null ? null : {feedCursorParameter: cursor},
    );
    final data = response.data;
    if (data == null) {
      throw const FormatException('The feed response was empty.');
    }
    return FeedPage.fromJson(data);
  }
}
