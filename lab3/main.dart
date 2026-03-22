import 'dart:io';
import 'classes/Machine.dart';

void main() {
  // Создаём кофемашину с начальными ресурсами
  Machine machine = Machine(
    coffeeBeans: 500,
    milk: 1000,
    water: 2000,
    cash: 0,
  );

  // Основной цикл взаимодействия
  while (true) {
    print('\n=== Кофемашина ===');
    print('1. Приготовить эспрессо');
    print('2. Пополнить ресурсы');
    print('3. Забрать деньги');
    print('4. Показать состояние');
    print('5. Выход');
    stdout.write('Выберите действие: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        if (machine.makingCoffee()) {
          print('Кофе готов! Приятного аппетита.');
        } else {
          print('Недостаточно ресурсов для приготовления эспрессо.');
          print('Требуется: кофе 50г, вода 100мл.');
          print('Пополните запасы (пункт 2).');
        }
        break;

      case '2':
        print('Пополнение ресурсов:');
        stdout.write('Сколько добавить кофе (гр): ');
        int? coffee = int.tryParse(stdin.readLineSync() ?? '');
        stdout.write('Сколько добавить молока (мл): ');
        int? milk = int.tryParse(stdin.readLineSync() ?? '');
        stdout.write('Сколько добавить воды (мл): ');
        int? water = int.tryParse(stdin.readLineSync() ?? '');
        if (coffee != null && coffee > 0) machine.coffeeBeans += coffee;
        if (milk != null && milk > 0) machine.milk += milk;
        if (water != null && water > 0) machine.water += water;
        print('Ресурсы обновлены.');
        break;

      case '3':
        print('Вы забрали ${machine.cash} руб.');
        machine.cash = 0;
        break;

      case '4':
        print('Состояние машины:');
        print('Кофе: ${machine.coffeeBeans} г');
        print('Молоко: ${machine.milk} мл');
        print('Вода: ${machine.water} мл');
        print('Деньги: ${machine.cash} руб.');
        break;

      case '5':
        print('До свидания!');
        return;

      default:
        print('Неверный выбор, попробуйте снова.');
    }
  }
}