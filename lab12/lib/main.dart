import 'package:flutter/material.dart';

import 'models/coffee.dart';
import 'models/resources.dart';
import 'pages/coffee_page.dart';
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
      title: 'Coffee Machine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7D584B)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFD6EB29),
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
  CoffeeType _selectedCoffee = CoffeeType.espresso;
  int _insertedMoney = 0;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _machine = CoffeeMachine(
      Resources(coffeeBeans: 250, milk: 250, water: 250, cash: 0),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _selectCoffee(CoffeeType type) {
    setState(() {
      _selectedCoffee = type;
    });
  }

  void _addMoney(int amount) {
    setState(() {
      _insertedMoney += amount;
    });
    _showMessage('Added $amount rub.');
  }

  void _returnInsertedMoney() {
    if (_insertedMoney == 0) {
      _showMessage('Add money first.');
      return;
    }

    final amount = _insertedMoney;
    setState(() {
      _insertedMoney = 0;
    });
    _showMessage('Returned $amount rub.');
  }

  Future<void> _brewCoffee() async {
    if (_isBusy) {
      return;
    }

    final recipe = recipeByType(_selectedCoffee);
    if (_insertedMoney < recipe.resources.cash) {
      _showMessage('Not enough inserted money for ${recipe.name}.');
      return;
    }

    setState(() {
      _isBusy = true;
    });

    final result = await _machine.makeCoffee(_selectedCoffee);

    if (!mounted) {
      return;
    }

    setState(() {
      _isBusy = false;
      if (result.success) {
        _insertedMoney -= recipe.resources.cash;
      }
    });
    _showMessage(result.message);
  }

  void _serviceAction({
    required bool increase,
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) {
    final result = _machine.changeResources(
      increase: increase,
      coffeeBeans: coffeeBeans,
      milk: milk,
      water: water,
      cash: cash,
    );

    setState(() {});
    _showMessage(result.message);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF7D584B),
          foregroundColor: Colors.white,
          title: const Text('Coffee Machine'),
          bottom: const TabBar(
            indicatorColor: Color(0xFFE5E5E5),
            tabs: [
              Tab(icon: Icon(Icons.coffee_outlined)),
              Tab(icon: Icon(Icons.local_shipping_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoffeePage(
              resources: _machine.resources.copy(),
              insertedMoney: _insertedMoney,
              selectedCoffee: _selectedCoffee,
              isBusy: _isBusy,
              onCoffeeChanged: _selectCoffee,
              onAddMoney: _addMoney,
              onReturnMoney: _returnInsertedMoney,
              onBrewCoffee: _brewCoffee,
            ),
            ServicePage(
              resources: _machine.resources.copy(),
              onApply: _serviceAction,
            ),
          ],
        ),
      ),
    );
  }
}
