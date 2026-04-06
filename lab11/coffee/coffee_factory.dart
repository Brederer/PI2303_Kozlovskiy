import '../enums/coffee_type.dart';
import '../utils/coffee_process.dart';
import 'americano.dart';
import 'cappuccino.dart';
import 'espresso.dart';
import 'i_coffee.dart';

class CoffeeFactory {
  static Future<ICoffee> create(CoffeeType type) async {
    switch (type) {
      case CoffeeType.espresso:
        await CoffeeProcess.makeWithoutMilk('Эспрессо');
        return Espresso();

      case CoffeeType.cappuccino:
        await CoffeeProcess.makeWithMilk('Капучино ');
        return Cappuccino();

      case CoffeeType.americano:
        await CoffeeProcess.makeWithoutMilk('Американо');
        return Americano();
    }
  }
}
