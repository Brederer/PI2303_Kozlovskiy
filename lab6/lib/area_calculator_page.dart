import 'package:flutter/material.dart';

class AreaCalculatorPage extends StatefulWidget {
  const AreaCalculatorPage({super.key});

  @override
  State<AreaCalculatorPage> createState() => _AreaCalculatorPageState();
}

class _AreaCalculatorPageState extends State<AreaCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  String _result = 'S = ширина * высота = результат';

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  String? _validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Пожалуйста, введите значение';
    }

    final number = double.tryParse(value.replaceAll(',', '.'));
    if (number == null) {
      return 'Введите числовое значение';
    }

    if (number <= 0) {
      return 'Значение должно быть больше нуля';
    }

    return null;
  }

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }

  void _calculateArea() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final width = double.parse(_widthController.text.replaceAll(',', '.'));
    final height = double.parse(_heightController.text.replaceAll(',', '.'));
    final area = width * height;

    setState(() {
      _result =
          'S = ${_formatNumber(width)} * ${_formatNumber(height)} = ${_formatNumber(area)}';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Площадь успешно вычислена'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор площади'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Введите ширину и высоту фигуры',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _widthController,
                    decoration: const InputDecoration(
                      labelText: 'Ширина',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.straighten),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: _validateNumber,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                      labelText: 'Высота',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.height),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: _validateNumber,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _calculateArea,
                    child: const Text('Вычислить'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _result,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
