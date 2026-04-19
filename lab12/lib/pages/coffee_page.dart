import 'package:flutter/material.dart';

import '../models/coffee.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({
    super.key,
    required this.isBusy,
    required this.onCoffeeSelected,
  });

  final bool isBusy;
  final ValueChanged<CoffeeType> onCoffeeSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Панель управления',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        for (final recipe in coffeeRecipes)
          Card(
            child: ListTile(
              leading: Text(recipe.icon, style: const TextStyle(fontSize: 28)),
              title: Text(recipe.name),
              subtitle: Text(
                'Кофе: ${recipe.resources.coffeeBeans} г, '
                'молоко: ${recipe.resources.milk} мл, '
                'вода: ${recipe.resources.water} мл',
              ),
              trailing: Text('${recipe.resources.cash} руб.'),
              enabled: !isBusy,
              onTap: isBusy ? null : () => onCoffeeSelected(recipe.type),
            ),
          ),
        if (isBusy) ...[
          const SizedBox(height: 16),
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 8),
          const Center(child: Text('Кофе готовится...')),
        ],
      ],
    );
  }
}
