import 'package:flutter_test/flutter_test.dart';
import 'package:list_task/models/feed_item.dart';

void main() {
  test('parses posts and ads as distinct feed item types', () {
    final post = FeedItem.fromJson({
      'type': 'post',
      'data': {
        'id': 'post-1',
        'author': {
          'id': 'author-1',
          'username': 'alice',
          'displayName': 'Alice',
        },
        'content': 'Hello',
        'createdAt': '2026-10-18T12:00:00Z',
      },
    });
    final ad = FeedItem.fromJson({
      'type': 'ad',
      'data': {
        'id': 'ad-1',
        'advertiser': 'Example Company',
        'content': 'Try this',
        'targetUrl': 'https://example.com',
        'createdAt': '2026-10-18T11:00:00Z',
      },
    });

    expect(post, isA<Post>());
    expect(ad, isA<Ad>());
  });
}
