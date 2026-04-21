import 'package:flutter/material.dart';

import '../models/coffee.dart';
import '../models/resources.dart';
import '../widgets/machine_display.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({
    super.key,
    required this.resources,
    required this.insertedMoney,
    required this.selectedCoffee,
    required this.isBusy,
    required this.onCoffeeChanged,
    required this.onAddMoney,
    required this.onReturnMoney,
    required this.onBrewCoffee,
  });

  final Resources resources;
  final int insertedMoney;
  final CoffeeType selectedCoffee;
  final bool isBusy;
  final ValueChanged<CoffeeType> onCoffeeChanged;
  final ValueChanged<int> onAddMoney;
  final VoidCallback onReturnMoney;
  final Future<void> Function() onBrewCoffee;

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  final _formKey = GlobalKey<FormState>();
  final _moneyController = TextEditingController();

  @override
  void dispose() {
    _moneyController.dispose();
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

  void _submitMoney() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = int.parse(_moneyController.text.trim());
    widget.onAddMoney(amount);
    _moneyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFD6EB29),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Text(
              'Beans: ${widget.resources.coffeeBeans}\nMilk: ${widget.resources.milk}\nWater: ${widget.resources.water}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: const Color(0xFF5B5C36)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: MachineDisplay(
              title: 'Coffee Maker',
              lines: ['Your money: ${widget.insertedMoney}'],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 24),
            child: Column(
              children: [
                for (final recipe in coffeeRecipes)
                  RadioListTile<CoffeeType>(
                    value: recipe.type,
                    groupValue: widget.selectedCoffee,
                    activeColor: const Color(0xFF7D584B),
                    title: Text(recipe.type.name),
                    onChanged: widget.isBusy
                        ? null
                        : (value) {
                            if (value != null) {
                              widget.onCoffeeChanged(value);
                            }
                          },
                  ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: widget.isBusy ? null : widget.onBrewCoffee,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF0A9A90),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(64, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: widget.isBusy
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow_rounded, size: 32),
                  ),
                ),
                const Divider(height: 36),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _moneyController,
                    validator: _validateNumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Put money here',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: _submitMoney,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFC4DE91),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(58, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.attach_money, size: 28),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: widget.onReturnMoney,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFEF8BAF),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(58, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(
                        Icons.money_off_csred_outlined,
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
