import '../enums/coffee_type.dart';
import 'espresso.dart';
import 'cappuccino.dart';
import 'americano.dart';
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
