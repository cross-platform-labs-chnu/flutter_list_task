import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/feed_item.dart';
import '../services/feed_service.dart';
import '../widgets/ad_card.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({required this.feedService, super.key});
  final FeedService feedService;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _scrollController = ScrollController();
  final _items = <FeedItem>[];
  String? _nextCursor;
  String? _error;
  bool _hasMore = true;
  bool _isLoading = false;
  bool _initialLoadComplete = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 400) _loadPage();
  }

  Future<void> _loadPage() async {
    if (_isLoading || !_hasMore) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final page = await widget.feedService.fetchFeed(cursor: _nextCursor);
      if (!mounted) return;
      setState(() {
        _items.addAll(page.items);
        _nextCursor = page.nextCursor;
        _hasMore = page.hasMore && page.nextCursor != null;
        _initialLoadComplete = true;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = _errorMessage(error);
        _initialLoadComplete = true;
        _isLoading = false;
      });
    }
  }

  String _errorMessage(Object error) =>
      error is DioException && error.message != null
      ? error.message!
      : 'Could not load the feed. Please try again.';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Feed')),
    body: _buildBody(),
  );

  Widget _buildBody() {
    if (!_initialLoadComplete && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_items.isEmpty && _error != null) {
      return _ErrorState(message: _error!, onRetry: _loadPage);
    }
    if (_items.isEmpty) return const Center(child: Text('No items yet.'));

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _items.clear();
          _nextCursor = null;
          _hasMore = true;
          _initialLoadComplete = false;
        });
        await _loadPage();
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: _items.length + (_isLoading || _error != null ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _items.length) {
            if (_error != null) {
              return _ErrorState(message: _error!, onRetry: _loadPage);
            }
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return switch (_items[index]) {
            Post post => PostCard(post: post),
            Ad ad => AdCard(ad: ad),
          };
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    ),
  );
}
