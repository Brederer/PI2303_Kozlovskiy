import 'i_coffee.dart';

class Americano implements ICoffee {
  @override
  int coffeeBeans() => 30;

  @override
  int milk() => 0;

  @override
  int water() => 200;

  @override
  int cash() => 6;
}
