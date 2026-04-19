import 'package:flutter/material.dart';

import '../models/news_item.dart';
import '../services/api_service.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.apiService});

  final ApiService apiService;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final Future<List<NewsItem>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = widget.apiService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsItem>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const _Message(text: 'Ошибка запроса новостей');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final news = snapshot.data!;
        if (news.isEmpty) {
          return const _Message(text: 'Новости не найдены');
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: news.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = news[index];
            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.imageUrl,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    if (item.imageUrl.isNotEmpty) const SizedBox(height: 12),
                    Text(
                      item.title.isEmpty ? 'Новость КубГАУ' : item.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (item.date.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        item.date,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                    if (item.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
