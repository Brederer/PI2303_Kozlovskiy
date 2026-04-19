class Resources {
  Resources({
    required this.coffeeBeans,
    required this.milk,
    required this.water,
    required this.cash,
  });

  int coffeeBeans;
  int milk;
  int water;
  int cash;

  Resources copy() {
    return Resources(
      coffeeBeans: coffeeBeans,
      milk: milk,
      water: water,
      cash: cash,
    );
  }

  String? firstMissingResource(Resources needed) {
    if (coffeeBeans < needed.coffeeBeans) return 'кофейных зерен';
    if (milk < needed.milk) return 'молока';
    if (water < needed.water) return 'воды';
    return null;
  }

  void consume(Resources needed) {
    coffeeBeans -= needed.coffeeBeans;
    milk -= needed.milk;
    water -= needed.water;
    cash += needed.cash;
  }

  void refill({
    required int coffeeBeans,
    required int milk,
    required int water,
  }) {
    this.coffeeBeans += coffeeBeans;
    this.milk += milk;
    this.water += water;
  }

  int takeCash() {
    final amount = cash;
    cash = 0;
    return amount;
  }
}
