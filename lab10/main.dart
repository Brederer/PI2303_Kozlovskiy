import 'machine/machine.dart';
import 'models/resources.dart';

void main() {
  final machine = Machine(
    Resources(coffeeBeans: 100, milk: 200, water: 500, cash: 0),
  );

  machine.run();
}
