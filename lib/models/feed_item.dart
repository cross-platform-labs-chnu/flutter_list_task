sealed class FeedItem {
  const FeedItem({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  final String id;
  final String content;
  final DateTime createdAt;

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    final data = Map<String, dynamic>.from(json['data'] as Map? ?? const {});
    return switch (json['type'] as String?) {
      'post' => Post.fromJson(data),
      'ad' => Ad.fromJson(data),
      final type => throw FormatException('Unsupported feed item type: $type'),
    };
  }
}

class Author {
  const Author({
    required this.id,
    required this.username,
    required this.displayName,
  });

  final String id;
  final String username;
  final String displayName;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json['id'] as String? ?? '',
    username: json['username'] as String? ?? '',
    displayName: json['displayName'] as String? ?? '',
  );
}

class Post extends FeedItem {
  const Post({
    required super.id,
    required super.content,
    required super.createdAt,
    required this.author,
  });
  final Author author;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'] as String? ?? '',
    content: json['content'] as String? ?? '',
    createdAt: DateTime.parse(json['createdAt'] as String),
    author: Author.fromJson(
      Map<String, dynamic>.from(json['author'] as Map? ?? const {}),
    ),
  );
}

class Ad extends FeedItem {
  const Ad({
    required super.id,
    required super.content,
    required super.createdAt,
    required this.advertiser,
    required this.targetUrl,
  });
  final String advertiser;
  final String targetUrl;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json['id'] as String? ?? '',
    content: json['content'] as String? ?? '',
    createdAt: DateTime.parse(json['createdAt'] as String),
    advertiser: json['advertiser'] as String? ?? '',
    targetUrl: json['targetUrl'] as String? ?? '',
  );
}

class FeedPage {
  const FeedPage({
    required this.items,
    required this.nextCursor,
    required this.hasMore,
  });
  final List<FeedItem> items;
  final String? nextCursor;
  final bool hasMore;

  factory FeedPage.fromJson(Map<String, dynamic> json) => FeedPage(
    items: (json['items'] as List? ?? const [])
        .map(
          (item) => FeedItem.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(),
    nextCursor: json['nextCursor'] as String?,
    hasMore: json['hasMore'] as bool? ?? false,
  );
}
