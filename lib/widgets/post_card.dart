import 'package:flutter/material.dart';

import '../models/feed_item.dart';

class PostCard extends StatelessWidget {
  const PostCard({required this.post, super.key});
  final Post post;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(
        child: Text(
          post.author.displayName.isEmpty
              ? '?'
              : post.author.displayName[0].toUpperCase(),
        ),
      ),
      title: Text(
        post.author.displayName.isEmpty
            ? '@${post.author.username}'
            : post.author.displayName,
      ),
      subtitle: Text(post.content),
      isThreeLine: true,
    ),
  );
}
