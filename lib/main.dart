import 'package:flutter/material.dart';

import 'config/api_config.dart';
import 'screens/feed_screen.dart';
import 'services/feed_service.dart';

void main() => runApp(MyApp(feedService: FeedService(createApiClient())));

class MyApp extends StatelessWidget {
  const MyApp({required this.feedService, super.key});

  final FeedService feedService;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Feed',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: FeedScreen(feedService: feedService),
  );
}
