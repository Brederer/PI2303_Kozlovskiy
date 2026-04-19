import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_item.dart';
import '../models/photo.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String photosUrl = 'https://jsonplaceholder.typicode.com/photos';
  static const String newsUrl =
      'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90';

  Future<List<Photo>> fetchPhotos() async {
    final response = await _client.get(Uri.parse(photosUrl));

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки фотографий');
    }

    return _parsePhotos(response.body);
  }

  Future<List<NewsItem>> fetchNews() async {
    final response = await _client.get(Uri.parse(newsUrl));

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки новостей');
    }

    return _parseNews(response.body);
  }
}

List<Photo> _parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  return parsed
      .cast<Map<String, dynamic>>()
      .map<Photo>(Photo.fromJson)
      .take(60)
      .toList();
}

List<NewsItem> _parseNews(String responseBody) {
  final decoded = jsonDecode(responseBody);
  final List<dynamic> items = switch (decoded) {
    final List<dynamic> list => list,
    final Map<String, dynamic> map when map['data'] is List =>
      map['data'] as List,
    final Map<String, dynamic> map when map['news'] is List =>
      map['news'] as List,
    final Map<String, dynamic> map when map['items'] is List =>
      map['items'] as List,
    _ => <dynamic>[],
  };

  return items
      .cast<Map<String, dynamic>>()
      .map<NewsItem>(NewsItem.fromJson)
      .toList();
}
