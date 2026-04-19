import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const CampusPage(),
    );
  }
}

class CampusPage extends StatefulWidget {
  const CampusPage({super.key});

  @override
  State<CampusPage> createState() => _CampusPageState();
}

class _CampusPageState extends State<CampusPage> {
  bool _isFavorite = false;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _favoriteCount += _isFavorite ? 1 : -1;
    });
  }

  void _showActionMessage(String action) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Выбрано действие: $action')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Верстка интерфейса'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const _HeaderImage(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleSection(
                  isFavorite: _isFavorite,
                  favoriteCount: _favoriteCount,
                  onFavoritePressed: _toggleFavorite,
                ),
                const SizedBox(height: 24),
                _ButtonSection(onActionPressed: _showActionMessage),
                const SizedBox(height: 24),
                const _TextSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Image.asset('assets/nature.jpg', fit: BoxFit.cover),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({
    required this.isFavorite,
    required this.favoriteCount,
    required this.onFavoritePressed,
  });

  final bool isFavorite;
  final int favoriteCount;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Студенческий городок Кубанского ГАУ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text('Краснодар, Россия', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        IconButton(
          onPressed: onFavoritePressed,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: Colors.red,
          tooltip: 'Нравится',
        ),
        Text('$favoriteCount'),
      ],
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection({required this.onActionPressed});

  final ValueChanged<String> onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionButton(
          icon: Icons.call,
          label: 'Позвонить',
          onPressed: () => onActionPressed('Позвонить'),
        ),
        _ActionButton(
          icon: Icons.near_me,
          label: 'Маршрут',
          onPressed: () => onActionPressed('Маршрут'),
        ),
        _ActionButton(
          icon: Icons.share,
          label: 'Поделиться',
          onPressed: () => onActionPressed('Поделиться'),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: Colors.green),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon), const SizedBox(height: 8), Text(label)],
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection();

  static const String campusText =
      'Студенческий городок или так называемый кампус Кубанского ГАУ '
      'состоит из двадцати общежитий, в которых проживает более 8000 '
      'студентов, что составляет 96% от всех нуждающихся. Студенты первого '
      'курса обеспечены местами в общежитии полностью. В соответствии с '
      'Положением о студенческих общежитиях университета, при поселении '
      'между администрацией и студентами заключается договор найма жилого '
      'помещения. Воспитательная работа в общежитиях направлена на улучшение '
      'быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных '
      'явлений в молодежной среде. Условия проживания в общежитиях '
      'университетского кампуса полностью отвечают санитарным нормам и '
      'требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, '
      'читальных залов, комнат самоподготовки, помещений для заседаний '
      'студенческих советов и наглядной агитации. С целью улучшения условий '
      'быта студентов активно работает система студенческого самоуправления - '
      'студенческие советы организуют всю работу по самообслуживанию.';

  @override
  Widget build(BuildContext context) {
    return const Text(
      campusText,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 16, height: 1.4),
    );
  }
}
