import '../enums/coffee_type.dart';
import 'americano.dart';
import 'cappuccino.dart';
import 'espresso.dart';
import 'i_coffee.dart';

class CoffeeFactory {
  static ICoffee create(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return Espresso();
      case CoffeeType.cappuccino:
        return Cappuccino();
      case CoffeeType.americano:
        return Americano();
    }
  }
}
