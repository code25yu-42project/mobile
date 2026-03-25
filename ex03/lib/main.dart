import 'package:flutter/material.dart'; // Flutter Material UI 라이브러리 import
import 'package:math_expressions/math_expressions.dart'; // 수식 파싱 및 계산을 위한 라이브러리 import

void main() {            // 프로그램 시작 지점
  runApp(const MyApp()); // MyApp 위젯을 실행
}

class MyApp extends StatelessWidget {     // 상태 없는 루트 위젯
  const MyApp({super.key});               // 생성자

  @override
  Widget build(BuildContext context) {    // UI 구성
    return const MaterialApp(             // 앱 전체를 감싸는 루트 위젯
      debugShowCheckedModeBanner: false,  // 디버그 배너 제거
      home: HomePage(),                   // 첫 화면 지정
    );
  }
}

class HomePage extends StatefulWidget {    // 상태가 있는 위젯
  const HomePage({super.key});             // 생성자

  @override
  State<HomePage> createState() => _HomePageState(); // 상태 객체 생성
}

/*
|-------------------|ㅊㅇ
| Button Model.     |
|-------------------|
*/

// 버튼의 유형을 정의하는 열거형 enum
enum ButtonType {
  mode,      // 상단 기능 버튼 (history, unit, scientific)
  digit,     // 숫자 버튼 (0-9, ., +/-)
  operator,  // 연산자 버튼 (%, /, -, +, *, ())
  function,  // 기능 버튼 (back, AC, =)
}

// 버튼의 스타일을 정의하는 열거형 enum
enum ButtonStyle {
  styleA,    // 상단 기능 버튼 스타일
  styleB,    // 연산자 버튼 스타일
  styleC,    // 숫자 및 일부 기능 버튼 스타일
}

/*
|--------------------------------------------------------------------------
| Button Model
|--------------------------------------------------------------------------
*/

// final: 한 번만 값이 설정되고 이후 변경할 수 없는 변
class CalcButton {           // 계산기 버튼 모델 클래스

  final ButtonType type;    // 버튼 종류(operator, number, action)
  final ButtonStyle style;  // 버튼 스타일(A, B, C)
  final String value;       // 버튼의 실제 값 (예: '1', '+', 'AC')
  final String? text;       // 버튼에 표시할 텍스트 (value와 다를 수 있음)
  final IconData? icon;     // 버튼에 아이콘이 필요한 경우 (예: backspace)

  const CalcButton({       // 생성자
    required this.type,     // 버튼 유형(필수)
    required this.style,    // 버튼 스타일(필수)
    required this.value,    // 버튼 값(필수)
    this.text,              // 버튼 텍스트(선택)
    this.icon,              // 버튼 아이콘(선택)
  });
}

// HomePage의 상태를 관리하는 클래스
class _HomePageState extends State<HomePage> {
  final TextEditingController exp = TextEditingController(text: ''); // 수식 TextField 제어용
  final TextEditingController res = TextEditingController(text: ''); // 결과 TextField 제어용

  List<Map<String, String>> history = [];
  bool showHistory = false; // History 표시 여부 추가
  
  // 최대값/최소값 제한 상수
  static const double MAX_INPUT_VALUE = 1e15; // 입력 최대값: 1,000,000,000,000,000
  static const double MAX_RESULT_VALUE = 1e15; // 계산 결과 최대값
  
  // 버튼 목록 정의 (상단 기능 버튼 4개 + 연산자 버튼 4개 + 숫자 및 기타 버튼 16개 = 총 24개)
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

  // 버튼 클릭 처리 함수
  void onButtonPressed(ButtonType type, String value) {
    setState(() {
      // 모드 버튼 처리
      if (type ==  ButtonType.mode)  {
        manageMode(value);
        return ;
      } 
      // 기능 버튼 처리
      if (type == ButtonType.function) { 
        manageFunction(value);
        return ;
      }
      // 연산자 버튼 처리
      if (type == ButtonType.operator) {
        manageOperator(value);
        return ;
      }
      // 숫자 버튼 처리
      if (type == ButtonType.digit) {
        manageDigit(value);
      }
    });
  }

  // 숫자 버튼 관리 함수
  void manageDigit(String value) {
    
    // '.'는 연속된 digit에서 한 번만 입력 가능하도록 처리
    if (value == '.') {
      // 현재 입력된 수식에서 마지막 숫자 그룹을 추출하여 '.'이 이미 포함되어 있는지 확인
      String text = exp.text;
      String lastNumber = '';

      // 뒤에서부터 숫자와 '.'가 나올 때까지 추출하여 lastNumber에 저장
      for (int i = text.length - 1; i >= 0; i--) {
        if (RegExp(r'[0-9.]').hasMatch(text[i])) {
          lastNumber = text[i] + lastNumber;
        } else {
          break;
        }
      }
      // 마지막 숫자 그룹에 '.'가 이미 포함되어 있으면 추가 입력하지 않음
      if (lastNumber.contains('.')) {
        return;
      }
    }

    // '+/-' 버튼 처리: 현재 입력된 수식에서 마지막 숫자 그룹을 찾아 부호를 토글
    if (value == '+/-') {
      String text = exp.text;
      String lastNumber = '';
      int lastNumberStart = text.length;

      // 뒤에서부터 숫자, '.' 또는 '-'가 나올 때까지 추출하여 lastNumber에 저장
      for (int i = text.length - 1; i >= 0; i--) {
        if (RegExp(r'[0-9.-]').hasMatch(text[i])) {
          lastNumber = text[i] + lastNumber;
          lastNumberStart = i;
        } else {
          break;
        }
      }

      // 마지막 숫자가 없으면 '+/-'가 뒤에 올 숫자의 부호로 작용하도록 입력
      // 단, 이미 '(-'가 있으면 '(-' 제거, '(-'가 없으면 '(-' 추가
      if (lastNumber.isEmpty) {
        if (text.endsWith('(-')) {
          exp.text = text.substring(0, text.length - 2);
        } else {
          exp.text += '(-';
        } 
        return; 
      }

      // 마지막 숫자가 있으면 부호를 토글
      if (lastNumber.startsWith('-')) {
        // 이미 음수이면 부호 제거
        exp.text = text.substring(0, lastNumberStart) + lastNumber.substring(1);
      } else {
        // 양수이면 부호 추가
        exp.text = text.substring(0, lastNumberStart) + '-' + lastNumber;
      }

    } else {
      // 입력 최대값 체크
      String tempText = exp.text + value;
      
      // 마지막 숫자 그룹 추출
      String lastNumber = '';
      for (int i = tempText.length - 1; i >= 0; i--) {
        if (RegExp(r'[0-9.-]').hasMatch(tempText[i])) {  
          lastNumber = tempText[i] + lastNumber;
        } else {
          break;
        }
      }

      // 숫자가 있으면 최대값 체크
      if (lastNumber.isNotEmpty && lastNumber != '.' && lastNumber != '-') {
        try {
          double numValue = double.parse(lastNumber);
          if (numValue.abs() > MAX_INPUT_VALUE) {
            showCustomPopup(context, '入力値が大きすぎます。');
            return;
          }
        } catch (e) {
          // 파싱 실패 시 무시하고 계속
        }
      }
      
      // 숫자 입력은 최대값 체크 후에 추가
      exp.text += value;
    }

    // 숫자 버튼이 눌릴 때마다 실시간 계산 결과 업데이트
    calculateLiveResult();
  }

  // 연산자 버튼 관리 함수
  void manageOperator(String value) {
  
      // 이전 문자가 연산자면 새로 입력된 연산자로 대체, 단, 괄호는 예외
      if (exp.text.isNotEmpty) {
        String lastChar = exp.text[exp.text.length - 1];
        if (lastChar.contains(RegExp(r'[+\-*/%]')) && !value.contains('()')) {
          exp.text = exp.text.substring(0, exp.text.length - 1);
        }
      }

      // 괄호 버튼은 별도의 관리 함수로 처리
      if (value == '()') {
        manageParenthesis();
        return;
      }

      // 직전문자가 괄호인데 연산자가 입력되면 '완성되지 않은 수식입니다' 출력
      if (exp.text.isNotEmpty) {
        String lastChar = exp.text[exp.text.length - 1];
        if (lastChar == '(' && value.contains(RegExp(r'[+\-*/%]'))) {
          showCustomPopup(context, '正しくない数式です。');
          return;
        }
      }
      
      // 연산자 입력은 최대값 체크 없이 바로 추가 (연산자 자체는 숫자가 아니므로)
      exp.text += value;
      // 연산자 버튼이 눌릴 때마다 실시간 계산 결과 업데이트
      res.text = '';
  }

  // 괄호 관리 함수
  void manageParenthesis() {
    String text = exp.text;
  
    // 괄호 입력은 현재 수식의 상태에 따라 자동으로 '(' 또는 ')'를 입력하는 로직
    if (text.isEmpty) {
      exp.text += "(";
      return;
    }

    String lastChar = text[text.length - 1];
    
    // 1. 열린 괄호와 닫힌 괄호의 개수를 세어 '닫을 수 있는 상태'인지 확인
    int openParenCount = '('.allMatches(text).length;
    int closeParenCount = ')'.allMatches(text).length;

    // 2. 분기 처리
    // 숫자나 닫는 괄호 뒤에 괄호를 누른 경우
    if (RegExp(r'[0-9)]').hasMatch(lastChar)) {
      if (openParenCount > closeParenCount) {
        // 열린 괄호가 더 많으면 닫아줌
        exp.text += ")";
      } else {
        // 닫을 괄호가 없으면 곱셈 기호를 붙이고 새로 열어줌 (예: 5 -> 5*()
        exp.text += "×(";
      }
    } 
    // 연산자나 열린 괄호 뒤에 누른 경우
    else {
      exp.text += "(";
    }
  }

  // 커스텀 팝업 메시지 함수
  void showCustomPopup(BuildContext context, String message) {
    // 1. 현재 떠 있는 알림이 있다면 즉시 제거 (메시지 쌓임 방지)
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 2. 새로운 알림 띄우기
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center, // 텍스트 중앙 정렬
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 2), // 2초 후 자동 소멸
        behavior: SnackBarBehavior.floating,   // 화면 하단에 떠 있는 스타일
        margin: const EdgeInsets.all(20),      // 화면 가장자리와의 간격
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 모서리 둥글게
        ),
        backgroundColor: Colors.black87,       // 반투명 검정색
      ),
    );
  }

  // 실시간 계산 함수
  void calculateLiveResult() {
    try {
      String expression = exp.text;
      if (expression.isEmpty) {
        res.text = '';
        return;
      }

      // 1. 열린 괄호와 닫힌 괄호의 개수를 비교하여 부족한 만큼 보정
      int openCount = '('.allMatches(expression).length;
      int closeCount = ')'.allMatches(expression).length;
      
      if (openCount > closeCount) {
        // 부족한 닫기 괄호를 뒤에 붙여줌
        expression += ')' * (openCount - closeCount);
      }
      
      // 2. 연산자 치환
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      
      // 3. 계산 (마지막이 연산자로 끝나는 경우 Parser 에러가 날 수 있으므로 한 번 더 체크)
      // 예: "5 + (3 +" -> "5 + (3 + )" 는 계산이 안 됨
      // 마지막 문자가 연산자라면 계산 결과 표시 안 함
      String lastChar = expression.trim().characters.last;
      if (RegExp(r'[+\-*/]$').hasMatch(lastChar)) {
        res.text = '';
        return;
      }

      // 계산 결과가 무한대이거나 NaN인 경우 (예: 5 / 0) 적절한 메세지 표시
      final result = evaluateExpression(expression);
      if (result.isInfinite || result.isNaN) {
        res.text = '';
        showCustomPopup(context, '正しくない数式です。');
        return;
      }
      
      // 결과값이 최대값을 초과하는 경우 처리
      if (result.abs() > MAX_RESULT_VALUE) {
        res.text = '';
        showCustomPopup(context, '計算結果が大きすぎます。');
        return;
      }

      // 결과가 정수면 소수점 제거, 아니면 그대로 표시
      if (result % 1 == 0) {
        res.text = result.toInt().toString();
      } else {
        res.text = result.toString();
      }
      
    } catch (e) {
      res.text = '';
    }
  }

  // 수식 계산 함수
  double evaluateExpression(String expression) {
    try {
      // math_expressions 패키지의 Parser를 사용하여 수식을 파싱하고 계산
      // final parser = Parser(); 
      // 1. Parser (deprecated): 예전 파서, 내부 구현이 모호하고 유지보수 어려움, 그래서 사용 중단(deprecated)
      // 2. ShuntingYardParser: 표준 수식 파싱 알고리즘 기반, 연산자 우선순위 (*, + 등) 정확하게 처리, 완성된 수식만 정상적으로 파싱 가능
      final parser = ShuntingYardParser();

      // ContextModel: 변수나 함수의 값을 제공하는 역할, 현재는 사용하지 않지만 파서에서 요구하기 때문에 생성
      final cm = ContextModel();

      // 수식을 파싱하여 Expression 객체로 변환한 후, REAL 타입으로 평가하여 결과를 얻음
      final parsedExpression = parser.parse(expression);

      // 계산 결과가 double이므로 toDouble()로 변환하여 반환
      final result = parsedExpression.evaluate(EvaluationType.REAL, cm);
      return result.toDouble();

    } catch (e) {
      throw Exception('Invalid expression');
    }
  }

  // 기능 버튼 관리 함수 (AC, back, =)
  void manageFunction(String value) {

    // 'back' 버튼 처리: 입력된 수식에서 마지막 문자 제거
    if (value == 'back') {
      if (exp.text.length <= 1) {
        exp.text = '';
      } else {
        exp.text = exp.text.substring(0, exp.text.length - 1);
        calculateLiveResult();
      }
      return;
    }
    // 'AC' 버튼 처리: 입력된 수식과 결과 모두 초기화
    if (value == 'AC') {
      exp.text = '';
      res.text = '';
      return;
    }
    // '=' 버튼 처리: 수식을 계산하여 결과를 입력창으로 옮기고 결과창 초기화
    if (value == '=') {
      onEqualPressed();
      // exp.text = res.text;
      // res.text = '';
    }
  }

  // '=' 버튼 처리 함수
  void onEqualPressed() {
    if (res.text.isEmpty) {
      showCustomPopup(context, '正しくない数式です。');
      return;
    }
    // 1. 결과가 비어있지 않을 때만 히스토리에 추가
    history.insert(0, {'expression': exp.text, 'result': res.text});
    
    // 2. 수식과 결과를 입력창으로 옮기고 결과창 초기화
    exp.text = res.text;
    res.text = '';
  }

  // 모드 관리 함수 (history, unit, scientific)
  void manageMode(String value) {
    if (value == 'history') {
      setState(() {
        showHistory = !showHistory;
      });
    }
  }

  // 버튼 빌드 함수
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

  // 버튼 빌드 함수
  Widget _buildDigitButtonArea() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.35,
        ),
        child: Stack(
          children: [
            // Digit buttons grid
            GridView.builder(
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
            // History overlay
            if (showHistory)
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildHistoryHeader(),
                    const Divider(color: Colors.grey),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildHistoryListContent(),
                      ),
                    ),
                    if (history.isNotEmpty) _buildClearHistoryButton(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // History 리스트를 빌드하는 함수 (리스트뷰 대신 컬럼과 맵으로 구현)
  Widget _buildHistoryListContent() {
    return history.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'No history yet',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: history.map((item) => _buildHistoryItem(item)).toList(),
          );
  }

  // History 항목을 누르면 해당 수식이나 결과가 입력창으로 복사되는 기능 추가
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

  // 상단 버튼 행 빌드 함수
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

  // 두 번째 버튼 행 빌드 함수
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

  // 숫자 버튼 그리드 빌드 함수
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

  // History 오버레이를 빌드하는 함수
  Widget _buildHistoryOverlay() {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.65, // 전체 너비의 65% 할당
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildHistoryHeader(),
          const Divider(color: Colors.grey),
          _buildHistoryList(),
          if (history.isNotEmpty) _buildClearHistoryButton(),
        ],
      ),
    );
  }

  // History 헤더를 빌드하는 함수
  Widget _buildHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showHistory = false;
              });
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  // History 리스트를 빌드하는 함수
  Widget _buildHistoryList() {
    return Expanded(
      child: history.isEmpty
          ? const Center(
              child: Text(
                'No history yet',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return _buildHistoryItem(item);
              },
            ),
    );
  }

  // History 항목을 누르면 해당 수식이나 결과가 입력창으로 복사되는 기능 추가
  Widget _buildHistoryItem(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expression
          GestureDetector(
            onTap: () {
              setState(() {
                exp.text += item['expression']!;
                calculateLiveResult();
              });
            },
            child: Text(
              item['expression']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Result
          GestureDetector(
            onTap: () {
              setState(() {
                exp.text += item['result']!;
                calculateLiveResult();
              });
            },
            child: Text(
              '= ${item['result']!}',
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Divider(
            color: Colors.grey[700],
            height: 1,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }

  // History 항목을 누르면 해당 수식이나 결과가 입력창으로 복사되는 기능 추가
  Widget _buildHistoryButton({
    required String label,
    required String value,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor.withOpacity(0.6),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // History 항목을 누르면 해당 수식이나 결과가 입력창으로 복사되는 기능 추가
  Widget _buildClearHistoryButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            setState(() {
              history.clear();
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          child: const Text(
            'Clear History',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // 버튼 스타일에 따라 색상과 텍스트 색상을 결정하는 함수
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

