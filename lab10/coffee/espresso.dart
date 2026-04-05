import 'i_coffee.dart';

class Espresso implements ICoffee {
  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 0;

  @override
  int water() => 100;

  @override
  int cash() => 5;
}
