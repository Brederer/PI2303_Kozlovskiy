import 'i_coffee.dart';

class Cappuccino implements ICoffee {
  @override
  int coffeeBeans() => 40;

  @override
  int milk() => 100;

  @override
  int water() => 150;

  @override
  int cash() => 7;
}
