import 'package:flutter/material.dart';

import 'models/coffee.dart';
import 'models/resources.dart';
import 'pages/coffee_page.dart';
import 'pages/resources_page.dart';
import 'pages/service_page.dart';
import 'services/coffee_machine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const CoffeeMachineApp(),
    );
  }
}

class CoffeeMachineApp extends StatefulWidget {
  const CoffeeMachineApp({super.key});

  @override
  State<CoffeeMachineApp> createState() => _CoffeeMachineAppState();
}

class _CoffeeMachineAppState extends State<CoffeeMachineApp> {
  late final CoffeeMachine _machine;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _machine = CoffeeMachine(
      Resources(coffeeBeans: 100, milk: 300, water: 500, cash: 0),
    );
  }

  Future<void> _makeCoffee(CoffeeType type) async {
    if (_isBusy) return;

    setState(() {
      _isBusy = true;
    });

    final result = await _machine.makeCoffee(type);

    if (!mounted) return;
    setState(() {
      _isBusy = false;
    });
    _showMessage(result.message);
  }

  void _refill(int coffeeBeans, int milk, int water) {
    setState(() {
      _machine.refill(coffeeBeans: coffeeBeans, milk: milk, water: water);
    });
    _showMessage('Кофемашина заправлена.');
  }

  void _takeCash() {
    final amount = _machine.takeCash();
    setState(() {});
    _showMessage('Вы забрали $amount руб.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Кофемашина'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.monitor_heart), text: 'Ресурсы'),
              Tab(icon: Icon(Icons.coffee_maker), text: 'Кофе'),
              Tab(icon: Icon(Icons.build), text: 'Сервис'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ResourcesPage(resources: _machine.resources.copy()),
            CoffeePage(isBusy: _isBusy, onCoffeeSelected: _makeCoffee),
            ServicePage(onRefill: _refill, onTakeCash: _takeCash),
          ],
        ),
      ),
    );
  }
}
