import 'package:flutter/material.dart';

import 'infinity_list.dart';
import 'infinity_math_list.dart';
import 'simple_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const ListsPage(),
    );
  }
}

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Работа со списками'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Простой'),
              Tab(text: 'Строки'),
              Tab(text: 'Степени'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [SimpleList(), InfinityList(), InfinityMathList()],
        ),
      ),
    );
  }
}
