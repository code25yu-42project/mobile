import 'package:flutter/material.dart';
// math_expressions removed — buttons will only print to console now

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/*
|-------------------|ㅊㅇ
| Button Model.     |
|-------------------|
*/

enum ButtonType {
  mode,      // history, unit, scientific
  digit,     // 0-9, ., +/-
  operator,  // %, /, -, +, *, ()
  function,  // back, AC, =
}

enum ButtonStyle {
  styleA,
  styleB,
  styleC,
}

/*
|--------------------------------------------------------------------------
| Button Model
|--------------------------------------------------------------------------
*/

class CalcButton{
  final ButtonType type; // operator, number, action, 
  final ButtonStyle style;
  final String value;
  final String? text;
  final IconData? icon;

  const CalcButton({
    required this.type,
    required this.style,
    required this.value,
    this.text,
    this.icon,
  });
}

class _HomePageState extends State<HomePage> {
  final TextEditingController exp = 
  TextEditingController(text: '');
  final TextEditingController res =
  TextEditingController(text: '');
  // 상태 클래스 상단에 선언
  // history and extra features removed; buttons will only print to console
  
  final List<CalcButton> buttons = const [
    CalcButton(type: ButtonType.mode, style: ButtonStyle.styleA, value: 'history', icon: Icons.access_time),
    CalcButton(type: ButtonType.mode, style: ButtonStyle.styleA, value: 'unit', icon: Icons.horizontal_rule),
    CalcButton(type: ButtonType.mode, style: ButtonStyle.styleA, value: 'scientific', icon: Icons.calculate_outlined),
    CalcButton(type: ButtonType.function, style: ButtonStyle.styleB, value: 'back', icon: Icons.backspace_outlined),

    CalcButton(type: ButtonType.function, style: ButtonStyle.styleC, value: 'AC', text: 'AC'),
    CalcButton(type: ButtonType.operator, style: ButtonStyle.styleC, value: '()', text: '()'),
    CalcButton(type: ButtonType.operator, style: ButtonStyle.styleC, value: '%', text: '%'),
    CalcButton(type: ButtonType.operator, style: ButtonStyle.styleC, value: '/', text: '÷'),

    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '7', text: '7'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '8', text: '8'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '9', text: '9'),
    CalcButton(type: ButtonType.operator, style: ButtonStyle.styleC, value: '*', text: 'x'),

    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '4', text: '4'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '5', text: '5'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '6', text: '6'),
    CalcButton(type: ButtonType.operator, style: ButtonStyle.styleC, value: '-', text: '-'),

    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '1', text: '1'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '2', text: '2'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '3', text: '3'),
    CalcButton(type: ButtonType.operator, style: ButtonStyle.styleC, value: '+', text: '+'),

    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '+/-', text: '+/-'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '0', text: '0'),
    CalcButton(type: ButtonType.digit, style: ButtonStyle.styleC, value: '.', text: '.'),
    CalcButton(type: ButtonType.function, style: ButtonStyle.styleC, value: '=', text: '='),
  ];



  // ======================
  // Button Handler
  // ======================

  // mode,      // history, unit, scientific
  // digit,     // 0-9, ., +/-
  // operator,  // %, /, -, +, *, ()
  // function,  // back, AC, 

  void onButtonPressed(ButtonType type, String value) {
    // Print the button value to the terminal in requested format.
    print('Button Pressed: $value');
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Calculator',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    backgroundColor: Colors.black,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display Area
            _buildDisplayArea(),
            // Top Button Row
            _buildTopButtonRow(),
            // Second Button Row
            _buildSecondButtonRow(),
            // Digit Button Area
            _buildDigitButtonArea(),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDigitButtonArea() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.35,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: buttons.length - 8,
        itemBuilder: (context, index) {
          return _buildButton(buttons[index + 8]);
        },
      ),
    ),
  );
}

Widget _buildDisplayArea() {
  return Container(
    padding: const EdgeInsets.all(20),
    alignment: Alignment.bottomRight,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height * 0.3,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: exp,
          enabled: false,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 24,
          ),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
        TextField(
          controller: res,
          enabled: false,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ],
    ),
  );
}

Widget _buildTopButtonRow() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildButton(buttons[index]);
      },
    ),
  );
}

Widget _buildSecondButtonRow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildButton(buttons[index + 4]);
      },
    ),
  );
}

Widget _buildDigitButtonGrid() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: buttons.length - 8,
      itemBuilder: (context, index) {
        return _buildButton(buttons[index + 8]);
      },
    ),
  );
}

// History UI helpers removed

// History UI removed — simplified calculator prints button presses to console

    Widget _buildButton(CalcButton button) {
      Color bgColor = Colors.grey[800]!;
      Color textColor = Colors.white;

      if (button.style == ButtonStyle.styleA) {
        bgColor = Colors.grey[700]!;
      } else if (button.style == ButtonStyle.styleB) {
        bgColor = Colors.orange;
        textColor = Colors.white;
      } else if (button.style == ButtonStyle.styleC) {
        if (button.value == '=') {
          bgColor = Colors.orange;
          textColor = Colors.white;
        } else if (button.type != ButtonType.digit) {
          bgColor = const Color.fromARGB(255, 32, 32, 32);
        } else {
          bgColor = const Color.fromARGB(255, 92, 92, 92)!;
        }
      }

      return GestureDetector(
        onTap: () => onButtonPressed(button.type, button.value),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: button.icon != null
                ? Icon(button.icon, color: textColor, size: 24)
                : Text(
                    button.text ?? button.value,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      );
    }

}

