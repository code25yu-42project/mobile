import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hello Flutter',
                style: TextStyle(fontSize: 24)
              ),
              ElevatedButton(onPressed: () {
                debugPrint('Button Pressed');
              }, child: const Text('Press Button'))
            ],

          )
        )
      )
    );
  }
}
