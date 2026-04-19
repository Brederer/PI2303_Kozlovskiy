import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({
    super.key,
    required this.onRefill,
    required this.onTakeCash,
  });

  final void Function(int coffeeBeans, int milk, int water) onRefill;
  final VoidCallback onTakeCash;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final _coffeeController = TextEditingController(text: '100');
  final _milkController = TextEditingController(text: '200');
  final _waterController = TextEditingController(text: '500');

  @override
  void dispose() {
    _coffeeController.dispose();
    _milkController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  int _readValue(TextEditingController controller) {
    return int.tryParse(controller.text.trim()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Обслуживание', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        TextField(
          controller: _coffeeController,
          decoration: const InputDecoration(
            labelText: 'Добавить кофейные зерна',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _milkController,
          decoration: const InputDecoration(
            labelText: 'Добавить молоко',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _waterController,
          decoration: const InputDecoration(
            labelText: 'Добавить воду',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            widget.onRefill(
              _readValue(_coffeeController),
              _readValue(_milkController),
              _readValue(_waterController),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Заправить машину'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: widget.onTakeCash,
          icon: const Icon(Icons.payments),
          label: const Text('Забрать деньги'),
        ),
      ],
    );
  }
}
