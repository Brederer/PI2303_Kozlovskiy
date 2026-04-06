import 'i_coffee.dart';

class Espresso implements ICoffee {
  @override
  int coffeeBeans() => 20;

  @override
  int milk() => 0;

  @override
  int water() => 50;

  @override
  int cash() => 100;

  @override
  String name() => 'Эспрессо';
}
