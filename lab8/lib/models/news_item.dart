import 'package:intl/intl.dart';

class NewsItem {
  const NewsItem({
    required this.title,
    required this.description,
    required this.date,
    required this.url,
    required this.imageUrl,
  });

  final String title;
  final String description;
  final String date;
  final String url;
  final String imageUrl;

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: _clean(_readString(json, ['title', 'name', 'zagolovok'])),
      description: _clean(
        _readString(json, ['description', 'text', 'announce', 'content']),
      ),
      date: _readString(json, ['date', 'created_at', 'pubDate']),
      url: _readString(json, ['url', 'link']),
      imageUrl: _readString(json, ['image', 'img', 'picture', 'preview']),
    );
  }

  static String _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }

    return '';
  }

  static String _clean(String value) {
    return Bidi.stripHtmlIfNeeded(value).replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
