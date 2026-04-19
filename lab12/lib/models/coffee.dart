import 'resources.dart';

enum CoffeeType { espresso, cappuccino, americano }

class CoffeeRecipe {
  const CoffeeRecipe({
    required this.type,
    required this.name,
    required this.resources,
    required this.icon,
  });

  final CoffeeType type;
  final String name;
  final Resources resources;
  final String icon;

  bool get hasMilk => resources.milk > 0;
}

final coffeeRecipes = [
  CoffeeRecipe(
    type: CoffeeType.espresso,
    name: 'Эспрессо',
    icon: '☕',
    resources: Resources(coffeeBeans: 20, milk: 0, water: 50, cash: 100),
  ),
  CoffeeRecipe(
    type: CoffeeType.cappuccino,
    name: 'Капучино',
    icon: '🥛',
    resources: Resources(coffeeBeans: 20, milk: 100, water: 30, cash: 150),
  ),
  CoffeeRecipe(
    type: CoffeeType.americano,
    name: 'Американо',
    icon: '💧',
    resources: Resources(coffeeBeans: 20, milk: 0, water: 100, cash: 120),
  ),
];

CoffeeRecipe recipeByType(CoffeeType type) {
  return coffeeRecipes.firstWhere((recipe) => recipe.type == type);
}
