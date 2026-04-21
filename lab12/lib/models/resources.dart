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
    if (coffeeBeans < needed.coffeeBeans) return 'beans';
    if (milk < needed.milk) return 'milk';
    if (water < needed.water) return 'water';
    return null;
  }

  String? firstMissingForDecrease({
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) {
    if (this.coffeeBeans < coffeeBeans) return 'beans';
    if (this.milk < milk) return 'milk';
    if (this.water < water) return 'water';
    if (this.cash < cash) return 'cash';
    return null;
  }

  void consume(Resources needed) {
    coffeeBeans -= needed.coffeeBeans;
    milk -= needed.milk;
    water -= needed.water;
    cash += needed.cash;
  }

  void restock({
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) {
    this.coffeeBeans += coffeeBeans;
    this.milk += milk;
    this.water += water;
    this.cash += cash;
  }

  void decrease({
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) {
    this.coffeeBeans -= coffeeBeans;
    this.milk -= milk;
    this.water -= water;
    this.cash -= cash;
  }
}
