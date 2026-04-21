import 'package:flutter/material.dart';

import '../models/resources.dart';
import '../widgets/machine_display.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({
    super.key,
    required this.resources,
    required this.onApply,
  });

  final Resources resources;
  final void Function({
    required bool increase,
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  })
  onApply;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final _formKey = GlobalKey<FormState>();
  final _milkController = TextEditingController();
  final _waterController = TextEditingController();
  final _beansController = TextEditingController();
  final _cashController = TextEditingController();

  @override
  void dispose() {
    _milkController.dispose();
    _waterController.dispose();
    _beansController.dispose();
    _cashController.dispose();
    super.dispose();
  }

  String? _validateNumber(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Enter a number';
    }

    final parsed = int.tryParse(text);
    if (parsed == null || parsed < 0) {
      return 'Enter a non-negative number';
    }

    return null;
  }

  void _submit(bool increase) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onApply(
      increase: increase,
      coffeeBeans: int.parse(_beansController.text.trim()),
      milk: int.parse(_milkController.text.trim()),
      water: int.parse(_waterController.text.trim()),
      cash: int.parse(_cashController.text.trim()),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: _validateNumber,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFD6EB29),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
            child: MachineDisplay(
              title: 'Resources:',
              lines: [
                'Milk: ${widget.resources.milk}',
                'Water: ${widget.resources.water}',
                'Beans: ${widget.resources.coffeeBeans}',
                'Cash: ${widget.resources.cash}',
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildField(controller: _milkController, label: 'put milk'),
                  _buildField(controller: _waterController, label: 'put water'),
                  _buildField(controller: _beansController, label: 'put beans'),
                  _buildField(controller: _cashController, label: 'put cash'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () => _submit(true),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF91CC43),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(58, 58),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('+', style: TextStyle(fontSize: 30)),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () => _submit(false),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5A59),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(58, 58),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('-', style: TextStyle(fontSize: 30)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
