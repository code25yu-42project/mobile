import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CaculatorPage(),
    );
  }
}

class CaculatorPage extends StatefulWidget {
  const CaculatorPage({super.key});

  @override
  State<CaculatorPage> createState() => _CaculatorPageState();
}

/*
|--------------------------------------------------------------------------
| Button Model
|--------------------------------------------------------------------------
*/
class CalcButton {
  final bool isTop;
  final String value;
  final String? text;
  final IconData? icon;

  const CalcButton({
    required this.isTop,
    required this.value,
    this.text,
    this.icon,
  });
}

class _CaculatorPageState extends State<CaculatorPage> {
  final TextEditingController expressionController =
  TextEditingController(text: '0');
  final TextEditingController resultController =
  TextEditingController(text: '0');

  final List<CalcButton> buttons = const [
    CalcButton(isTop: true, value: 'history', icon: Icons.access_time),
    CalcButton(isTop: true, value: 'unit', icon: Icons.horizontal_rule),
    CalcButton(isTop: true, value: 'scientific', icon: Icons.calculate_outlined),
    CalcButton(isTop: true, value: 'back', icon: Icons.backspace_outlined),

    CalcButton(isTop: false, value: 'C', text: 'C'),
    CalcButton(isTop: false, value: '()', text: '()'),
    CalcButton(isTop: false, value: '%', text: '%'),
    CalcButton(isTop: false, value: '/', text: '/'),

    CalcButton(isTop: false, value: '7', text: '7'),
    CalcButton(isTop: false, value: '8', text: '8'),
    CalcButton(isTop: false, value: '9', text: '9'),
    CalcButton(isTop: false, value: '*', text: 'x'),

    CalcButton(isTop: false, value: '4', text: '4'),
    CalcButton(isTop: false, value: '5', text: '5'),
    CalcButton(isTop: false, value: '6', text: '6'),
    CalcButton(isTop: false, value: '-', text: '-'),

    CalcButton(isTop: false, value: '1', text: '1'),
    CalcButton(isTop: false, value: '2', text: '2'),
    CalcButton(isTop: false, value: '3', text: '3'),
    CalcButton(isTop: false, value: '+', text: '+'),

    CalcButton(isTop: false, value: '+/-', text: '+/-'),
    CalcButton(isTop: false, value: '0', text: '0'),
    CalcButton(isTop: false, value: '.', text: '.'),
    CalcButton(isTop: false, value: '=', text: '='),
  ];

  // ======================
  // Button Handler
  // ======================
  void onButtonPressed(String value) {
    setState(() {
      String exp = expressionController.text;

      if (value == 'C') {
        expressionController.text = '0';
        resultController.text = '0';
        return;
      }

      if (value == 'back') {
        if (exp.length <= 1) {
          expressionController.text = '0';
        } else {
          expressionController.text = exp.substring(0, exp.length - 1);
        }
        return;
      }

      if (value == '=') {
        try {
          final result = evaluateExpression(exp);
          resultController.text = result.toString();
        } catch (_) {
          resultController.text = 'Error';
        }
        return;
      }

      // if (value == '+/-') {
      //   if (exp.startsWith('-')) {
      //     expressionController.text = exp.substring(1);
      //   } else {
      //     expressionController.text = '-$exp';
      //   }
      //   return;
      // }

      if (exp == '0' && isNumber(value)) {
        expressionController.text = value;
      } else {
        expressionController.text += value;
      }
    });
  }

  // ======================
  // Expression Evaluation
  // ======================

  bool isNumber(String s) => double.tryParse(s) != null;

  int precedence(String op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
  }

  double applyOperator(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b == 0) throw Exception('Division by zero');
        return a / b;
      default:
        throw Exception('Unknown operator');
    }
  }

  /// 🔥 핵심 로직
  /// 1. 문자열 → 토큰 분리
  /// 2. 연산자 스택으로 우선순위 처리
  /// 3. 실수 계산
  double evaluateExpression(String expression) {
    final List<double> values = [];
    final List<String> ops = [];

    int i = 0;
    while (i < expression.length) {
      if (expression[i] == ' ') {
        i++;
        continue;
      }

      if (expression[i] == '-' &&
          (i == 0 || '+-*/'.contains(expression[i - 1]))) {
        int j = i + 1;
        while (j < expression.length &&
            (isDigit(expression[j]) || expression[j] == '.')) {
          j++;
        }
        values.add(double.parse(expression.substring(i, j)));
        i = j;
        continue;
      }

      if (isDigit(expression[i]) || expression[i] == '.') {
        int j = i;
        while (j < expression.length &&
            (isDigit(expression[j]) || expression[j] == '.')) {
          j++;
        }
        values.add(double.parse(expression.substring(i, j)));
        i = j;
        continue;
      }

      if ('+-*/'.contains(expression[i])) {
        while (ops.isNotEmpty &&
            precedence(ops.last) >= precedence(expression[i])) {
          final b = values.removeLast();
          final a = values.removeLast();
          values.add(applyOperator(a, b, ops.removeLast()));
        }
        ops.add(expression[i]);
      }
      i++;
    }

    while (ops.isNotEmpty) {
      final b = values.removeLast();
      final a = values.removeLast();
      values.add(applyOperator(a, b, ops.removeLast()));
    }

    return values.single;
  }

  bool isDigit(String c) => c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;

  // ======================
  // UI
  // ======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      expressionController.text,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                  FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      resultController.text,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(40),
              itemCount: buttons.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                final button = buttons[index];
                final isIcon = button.icon != null;

                return ElevatedButton(
                  onPressed: () => onButtonPressed(button.value),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isIcon ? Colors.grey.shade800 : Colors.grey.shade200,
                    foregroundColor:
                    isIcon ? Colors.white : Colors.black,
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: isIcon
                          ? Icon(button.icon, size: 30)
                          : Text(
                        button.text!,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
