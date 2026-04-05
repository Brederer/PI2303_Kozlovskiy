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

  void consume(Resources needed) {
    coffeeBeans -= needed.coffeeBeans;
    milk -= needed.milk;
    water -= needed.water;
    cash += needed.cash;
  }
}
