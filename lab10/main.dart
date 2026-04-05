import 'machine/machine.dart';
import 'models/resources.dart';
import 'enums/coffee_type.dart';

void main() {
  final machine = Machine(
    Resources(coffeeBeans: 500, milk: 500, water: 1000, cash: 0),
  );

  machine.makeCoffee(CoffeeType.espresso);
  machine.makeCoffee(CoffeeType.cappuccino);
}
