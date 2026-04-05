import 'i_coffee.dart';

class Americano implements ICoffee {
  @override
  int coffeeBeans() => 20;

  @override
  int milk() => 0;

  @override
  int water() => 100;

  @override
  int cash() => 120;

  @override
  String name() => 'Американо';
}
