import 'package:flutter/material.dart';

class InfinityList extends StatefulWidget {
  const InfinityList({super.key});

  @override
  State<InfinityList> createState() => _InfinityListState();
}

class _InfinityListState extends State<InfinityList> {
  final List<String> _items = <String>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }

        final int index = i ~/ 2;

        if (index >= _items.length) {
          final int nextNumber = _items.length + 1;
          _items.addAll([
            'Строка $nextNumber',
            'Строка ${nextNumber + 1}',
            'Строка ${nextNumber + 2}',
          ]);
        }

        return ListTile(
          leading: const Icon(Icons.format_list_numbered, color: Colors.green),
          title: Text(_items[index]),
          subtitle: Text('Индекс элемента: $index'),
        );
      },
    );
  }
}
