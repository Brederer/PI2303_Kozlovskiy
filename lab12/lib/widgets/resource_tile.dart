import 'package:flutter/material.dart';

class ResourceTile extends StatelessWidget {
  const ResourceTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
  });

  final IconData icon;
  final String title;
  final int value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        trailing: Text(
          '$value $unit',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
