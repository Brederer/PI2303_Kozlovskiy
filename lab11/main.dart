import 'machine/machine.dart';
import 'models/resources.dart';

Future<void> main() async {
  final machine = Machine(
    Resources(coffeeBeans: 100, milk: 200, water: 500, cash: 0),
  );

  await machine.run();
}
