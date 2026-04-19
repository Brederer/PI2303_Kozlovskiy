import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:lab8/main.dart';
import 'package:lab8/services/api_service.dart';

void main() {
  testWidgets('App shows photos and KubSAU news tabs', (tester) async {
    final apiService = ApiService(client: _FakeClient());

    await tester.pumpWidget(
      MaterialApp(home: RestApiPage(apiService: apiService)),
    );
    await tester.pump();

    expect(find.text('Фотогалерея'), findsOneWidget);
    expect(find.text('Новости КубГАУ'), findsOneWidget);

    await tester.tap(find.text('Новости КубГАУ'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Новости КубГАУ'), findsOneWidget);
  });

  test('ApiService parses photos and KubSAU news', () async {
    final apiService = ApiService(client: _FakeClient());

    final photos = await apiService.fetchPhotos();
    final news = await apiService.fetchNews();

    expect(photos.single.title, 'Тестовая фотография');
    expect(news.single.title, 'Новость КубГАУ');
    expect(news.single.description, 'Описание новости');
  });
}

class _FakeClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final body = request.url.toString().contains('jsonplaceholder')
        ? jsonEncode([
            {
              'albumId': 1,
              'id': 1,
              'title': 'Тестовая фотография',
              'url': 'https://example.com/photo.jpg',
              'thumbnailUrl': 'https://example.com/thumb.jpg',
            },
          ])
        : jsonEncode([
            {
              'title': 'Новость КубГАУ',
              'description': 'Описание новости',
              'date': '2026-04-19',
              'url': 'https://kubsau.ru',
              'image': '',
            },
          ]);

    return http.StreamedResponse(
      Stream<List<int>>.value(utf8.encode(body)),
      200,
      headers: {'content-type': 'application/json; charset=utf-8'},
      request: request,
    );
  }
}
