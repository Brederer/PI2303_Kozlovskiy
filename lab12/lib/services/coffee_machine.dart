import '../models/coffee.dart';
import '../models/resources.dart';

class MachineResult {
  const MachineResult({required this.success, required this.message});

  final bool success;
  final String message;
}

class CoffeeMachine {
  CoffeeMachine(this.resources);

  final Resources resources;

  Future<MachineResult> makeCoffee(CoffeeType type) async {
    final recipe = recipeByType(type);
    final missing = resources.firstMissingResource(recipe.resources);

    if (missing != null) {
      return MachineResult(
        success: false,
        message: 'Недостаточно $missing для приготовления ${recipe.name}.',
      );
    }

    await _prepare(recipe);
    resources.consume(recipe.resources);

    return MachineResult(
      success: true,
      message: '${recipe.name} готов. Цена: ${recipe.resources.cash}',
    );
  }

  void refill({
    required int coffeeBeans,
    required int milk,
    required int water,
  }) {
    resources.refill(coffeeBeans: coffeeBeans, milk: milk, water: water);
  }

  int takeCash() {
    return resources.takeCash();
  }

  Future<void> _prepare(CoffeeRecipe recipe) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    if (recipe.hasMilk) {
      await Future.wait([
        Future<void>.delayed(const Duration(milliseconds: 250)),
        Future<void>.delayed(const Duration(milliseconds: 250)),
      ]);
    }

    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
