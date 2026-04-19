import 'package:flutter/material.dart';

import '../models/photo.dart';
import '../services/api_service.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key, required this.apiService});

  final ApiService apiService;

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  late final Future<List<Photo>> _photosFuture;

  @override
  void initState() {
    super.initState();
    _photosFuture = widget.apiService.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: _photosFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const _Message(text: 'Ошибка запроса фотографий');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final photos = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            return GridTile(
              footer: ColoredBox(
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    photo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              child: Image.network(
                photo.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(
                    color: Color(0xFFE8F5E9),
                    child: Icon(Icons.broken_image, color: Colors.green),
                  );
                },
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
