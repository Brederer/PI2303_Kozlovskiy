# Лабораторная работа 12

Flutter-приложение с интерфейсом кофемашины, основанное на логике лабораторных работ 10-11.

## Реализовано

- экран ресурсов кофемашины;
- панель выбора напитка;
- сервисный экран для заправки ресурсов и выдачи денег;
- асинхронное приготовление кофе;
- уведомления `SnackBar` о результатах операций;
- разделение кода на модели, сервис, страницы и виджеты.

## Запуск

```bash
flutter pub get
flutter run
```

## Проверка

```bash
dart format lib/main.dart lib/models/resources.dart lib/models/coffee.dart lib/services/coffee_machine.dart lib/widgets/resource_tile.dart lib/pages/resources_page.dart lib/pages/coffee_page.dart lib/pages/service_page.dart test/widget_test.dart
flutter test
```
