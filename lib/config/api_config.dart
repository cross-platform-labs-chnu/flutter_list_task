import 'package:dio/dio.dart';

/// Override with --dart-define=API_BASE_URL=https://api.example.com.
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8080',
);

const feedCursorParameter = 'cursor';

Dio createApiClient() => Dio(
  BaseOptions(
    baseUrl: apiBaseUrl,
    headers: {'Accept': 'application/json'},
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
