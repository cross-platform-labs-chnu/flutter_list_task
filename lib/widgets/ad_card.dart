import 'package:flutter/material.dart';

import '../models/feed_item.dart';

class AdCard extends StatelessWidget {
  const AdCard({required this.ad, super.key});
  final Ad ad;

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.secondaryContainer,
    child: ListTile(
      leading: const Icon(Icons.campaign_outlined),
      title: Text(ad.advertiser),
      subtitle: Text('${ad.content}\n${ad.targetUrl}'),
      isThreeLine: true,
    ),
  );
}
