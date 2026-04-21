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
        message: 'Not enough $missing for ${recipe.name}.',
      );
    }

    await _prepare(recipe);
    resources.consume(recipe.resources);

    return MachineResult(
      success: true,
      message: '${recipe.name} is ready. Price: ${recipe.resources.cash}',
    );
  }

  MachineResult changeResources({
    required bool increase,
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) {
    if (increase) {
      resources.restock(
        coffeeBeans: coffeeBeans,
        milk: milk,
        water: water,
        cash: cash,
      );
      return const MachineResult(
        success: true,
        message: 'Machine resources updated.',
      );
    }

    final missing = resources.firstMissingForDecrease(
      coffeeBeans: coffeeBeans,
      milk: milk,
      water: water,
      cash: cash,
    );

    if (missing != null) {
      return MachineResult(
        success: false,
        message: 'Not enough $missing to decrease resources.',
      );
    }

    resources.decrease(
      coffeeBeans: coffeeBeans,
      milk: milk,
      water: water,
      cash: cash,
    );
    return const MachineResult(
      success: true,
      message: 'Machine resources decreased.',
    );
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
