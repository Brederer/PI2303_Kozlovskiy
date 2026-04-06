import 'dart:io';

import '../coffee/coffee_factory.dart';
import '../coffee/i_coffee.dart';
import '../enums/coffee_type.dart';
import '../models/resources.dart';

class Machine {
  final Resources resources;

  Machine(this.resources);

  void showMenu() {
    print('\n=== Кофемашина ===');
    print('1 - Показать ресурсы');
    print('2 - Купить кофе');
    print('3 - Заправить машину');
    print('4 - Забрать деньги');
    print('0 - Выйти');
  }

  void showResources() {
    print('\nТекущие ресурсы:');
    print(resources);
  }

  Future<void> buyCoffee() async {
    print('\nВыберите кофе:');
    print('1 - Эспрессо');
    print('2 - Капучино');
    print('3 - Американо');
    stdout.write('Ваш выбор: ');

    final input = stdin.readLineSync();

    CoffeeType? type;
    switch (input) {
      case '1':
        type = CoffeeType.espresso;
        break;
      case '2':
        type = CoffeeType.cappuccino;
        break;
      case '3':
        type = CoffeeType.americano;
        break;
      default:
        print('Ошибка: неверный выбор кофе');
        return;
    }

    await makeCoffee(type);
  }

  Future<void> makeCoffee(CoffeeType type) async {
    final ICoffee coffee = await CoffeeFactory.create(type);

    final needed = Resources(
      coffeeBeans: coffee.coffeeBeans(),
      milk: coffee.milk(),
      water: coffee.water(),
      cash: coffee.cash(),
    );

    final missing = resources.firstMissingResource(needed);
    if (missing != null) {
      print('Простите, не хватает $missing.');
      return;
    }

    resources.consume(needed);
    print('${coffee.name()} готов. Цена: ${coffee.cash()}');
  }

  void refillMachine() {
    stdout.write('\nДобавить зерна кофе: ');
    final coffeeBeans = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    stdout.write('Добавить молоко: ');
    final milk = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    stdout.write('Добавить воду: ');
    final water = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    resources.refill(coffeeBeans: coffeeBeans, milk: milk, water: water);

    print('Машина успешно заправлена.');
  }

  void takeCash() {
    final amount = resources.takeCash();
    print('\nВы взяли $amount денег.');
  }

  Future<void> run() async {
    while (true) {
      showMenu();
      stdout.write('Выберите действие: ');
      final action = stdin.readLineSync();

      switch (action) {
        case '1':
          showResources();
          break;
        case '2':
          await buyCoffee();
          break;
        case '3':
          refillMachine();
          break;
        case '4':
          takeCash();
          break;
        case '0':
          print('Досвидания!');
          return;
        default:
          print('Неизвестная команда.');
      }
    }
  }
}
