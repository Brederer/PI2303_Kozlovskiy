import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  void _returnAnswer(BuildContext context, String answer) {
    Navigator.pop(context, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Второй экран'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Передать выбранное значение на первый экран?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _returnAnswer(context, 'Да'),
                    child: const Text('Да'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => _returnAnswer(context, 'Нет'),
                    child: const Text('Нет'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
