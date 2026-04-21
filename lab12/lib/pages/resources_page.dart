import 'package:flutter/material.dart';

import '../models/resources.dart';
import '../widgets/resource_tile.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key, required this.resources});

  final Resources resources;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Дисплей ресурсов',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        ResourceTile(
          icon: Icons.coffee,
          title: 'Кофейные зерна',
          value: resources.coffeeBeans,
          unit: 'г',
        ),
        ResourceTile(
          icon: Icons.local_drink,
          title: 'Молоко',
          value: resources.milk,
          unit: 'мл',
        ),
        ResourceTile(
          icon: Icons.water_drop,
          title: 'Вода',
          value: resources.water,
          unit: 'мл',
        ),
        ResourceTile(
          icon: Icons.payments,
          title: 'Деньги',
          value: resources.cash,
          unit: 'руб.',
        ),
      ],
    );
  }
}
