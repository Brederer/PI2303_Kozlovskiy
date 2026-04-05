class Resources {
  int coffeeBeans;
  int milk;
  int water;
  int cash;

  Resources({
    required this.coffeeBeans,
    required this.milk,
    required this.water,
    required this.cash,
  });

  bool hasEnough(Resources needed) {
    return coffeeBeans >= needed.coffeeBeans &&
        milk >= needed.milk &&
        water >= needed.water;
  }

  String? firstMissingResource(Resources needed) {
    if (coffeeBeans < needed.coffeeBeans) return 'Кофейные зерна';
    if (milk < needed.milk) return 'Молоко';
    if (water < needed.water) return 'Вода';
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

  @override
  String toString() {
    return 'Кофейные зерна: $coffeeBeans\n'
        'Молоко: $milk\n'
        'Вода: $water\n'
        'Деньги: $cash';
  }
}
