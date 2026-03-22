class Machine {
  // Закрытые поля (инкапсуляция)
  int _coffeeBeans; // кофейные зерна в граммах
  int _milk;        // молоко в мл
  int _water;       // вода в мл
  int _cash;        // деньги в рублях

  // Конструктор с начальными значениями
  Machine({
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) : _coffeeBeans = coffeeBeans,
       _milk = milk,
       _water = water,
       _cash = cash;

  // Геттеры
  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  // Сеттеры (позволяют добавлять ресурсы, например при пополнении)
  set coffeeBeans(int value) => _coffeeBeans = value;
  set milk(int value) => _milk = value;
  set water(int value) => _water = value;
  set cash(int value) => _cash = value;

  // Метод проверки доступности ресурсов для эспрессо
  bool isAvailable() {
    return _coffeeBeans >= 50 && _water >= 100;
  }

  // Закрытый метод уменьшения ресурсов для эспрессо
  void _subtractResources() {
    _coffeeBeans -= 50;
    _water -= 100;
  }

  // Метод приготовления кофе
  bool makingCoffee() {
    if (isAvailable()) {
      _subtractResources();
      _cash += 50; // предположим, цена эспрессо 50 руб.
      return true;
    } else {
      return false;
    }
  }
}