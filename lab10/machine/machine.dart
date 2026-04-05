import '../models/resources.dart';
import '../coffee/coffee_factory.dart';
import '../coffee/i_coffee.dart';
import '../enums/coffee_type.dart';

class Machine {
  Resources resources;

  Machine(this.resources);

  void makeCoffee(CoffeeType type) {
    ICoffee coffee = CoffeeFactory.create(type);

    Resources needed = Resources(
      coffeeBeans: coffee.coffeeBeans(),
      milk: coffee.milk(),
      water: coffee.water(),
      cash: coffee.cash(),
    );

    if (resources.hasEnough(needed)) {
      resources.consume(needed);
      print("Coffee is ready!");
    } else {
      print("Not enough resources!");
    }
  }
}
