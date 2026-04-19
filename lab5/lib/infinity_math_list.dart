import 'dart:math';

import 'package:flutter/material.dart';

class InfinityMathList extends StatefulWidget {
  const InfinityMathList({super.key});

  @override
  State<InfinityMathList> createState() => _InfinityMathListState();
}

class _InfinityMathListState extends State<InfinityMathList> {
  final List<int> _powers = <int>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        final int index = i ~/ 2;

        if (index >= _powers.length) {
          _powers.addAll([
            _powers.length,
            _powers.length + 1,
            _powers.length + 2,
          ]);
        }

        final int power = _powers[index];
        final num result = pow(2, power);

        return ListTile(
          leading: const Icon(Icons.functions, color: Colors.green),
          title: Text('2 ^ $power = $result'),
          subtitle: Text('Степень числа 2: $power'),
        );
      },
    );
  }
}
