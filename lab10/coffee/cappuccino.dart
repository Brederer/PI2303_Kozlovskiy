import 'i_coffee.dart';

class Cappuccino implements ICoffee {
  @override
  int coffeeBeans() => 20;

  @override
  int milk() => 100;

  @override
  int water() => 30;

  @override
  int cash() => 150;

  @override
  String name() => 'Капучино';
}
