import 'package:flutter/material.dart';  // Flutter Material UI 라이브러리 import

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

class CalcButton{           // 계산기 버튼 모델 클래스
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

class _HomePageState extends State<HomePage> {
  final TextEditingController exp = TextEditingController(text: ''); // 수식 TextField 제어용
  final TextEditingController res = TextEditingController(text: ''); // 결과 TextField 제어용
  
  final List<CalcButton> buttons = const [ // 버튼 리스트 정의 (UI + 데이터 역할)

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

  void onButtonPressed(ButtonType type, String value) {
    // 버튼 클릭 시 호출되는 함수
    print('Button Pressed: $value'); // 디버그 콘솔에 어떤 버튼이 눌렸는지 출력
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(                             // 화면의 기본 구조 제공
      appBar: AppBar(                            // 상단 앱 바
        title: const Text(                       // 앱 바 제목
          'Calculator', 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,           // 앱 바 배경색   
        elevation: 0,                            // 앱 바 그림자 제거
      ),
      backgroundColor: Colors.black,             // 전체 배경색

      body: SafeArea(                            // 안전 영역 내에서 UI 구성 # 안정영역: 노치, 상태바, 홈 인디케이터 등과 겹치지 않도록 보장 
        child: SingleChildScrollView(            // 화면이 작을 때 스크롤 가능하도록 감싸기  
          child: Column(                         // 수직으로 위젯 배치
            mainAxisSize: MainAxisSize.min,      // Column이 자식 위젯 크기에 맞게 최소한으로 공간 차지
            children: [
              _buildDisplayArea(),               // Display Area
              _buildTopButtonRow(),              // Top Button Row
              _buildSecondButtonRow(),           // Second Button Row
              _buildDigitButtonArea(),           // Digit Button Area
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDigitButtonArea() {  // 숫자 버튼과 일부 기능 버튼이 배치되는 영역
    return Padding(
      padding: const EdgeInsets.all(10),   // 버튼 영역 전체에 패딩 추가
      child: ConstrainedBox(               // 버튼 영역의 최소 높이 설정
        constraints: BoxConstraints(       
          minHeight: MediaQuery.of(context).size.height * 0.35, // 화면 높이의 35%를 최소 높이로 설정
        ),
        child: GridView.builder(           // 버튼 영역을 GridView로 구성, gridView: 격자 형태로 아이템을 배치하는 위젯
          shrinkWrap: true,                // GridView가 자식 위젯 크기에 맞게 최소한으로 공간 차지, shrinkWrap이 false면 GridView가 무한히 확장되어 오류 발생한다
          physics: const NeverScrollableScrollPhysics(), // GridView 자체는 스크롤 불가능하게 설정 (전체가 SingleChildScrollView로 감싸져 있기 때문)
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  // 그리드의 열 수와 간격 설정
            crossAxisCount: 4,        // 4열로 구성
            crossAxisSpacing: 10,     // 열 간격 10
            mainAxisSpacing: 10,      // 행 간격 10
          ),
          itemCount: buttons.length - 8, // 8개의 상단 버튼을 제외한 나머지 버튼 수 
          itemBuilder: (context, index) { // 각 버튼을 빌드하는 함수
            return _buildButton(buttons[index + 8]); // 상단 8개 버튼을 제외한 나머지 버튼을 순서대로 빌드
          },
        ),
      ),
    );
  }

  Widget _buildDisplayArea() { // 계산기 상단의 수식과 결과를 표시하는 영역
    return Container(   // 수식과 결과를 감싸는 컨테이너
      padding: const EdgeInsets.all(20),  // 컨테이너 내부 패딩
      alignment: Alignment.bottomRight,   // 텍스트를 오른쪽 아래로 정렬
      constraints: BoxConstraints(        // 컨테이너의 최소 높이 설정 (화면 높이의 30%)
        minHeight: MediaQuery.of(context).size.height * 0.3,  // 화면 높이의 30%를 최소 높이로 설정
      ),
      child: Column( // 수식과 결과를 수직으로 배치하는 Column
        mainAxisAlignment: MainAxisAlignment.end, // 수직 방향으로 아래쪽 정렬
        crossAxisAlignment: CrossAxisAlignment.end, // 수평 방향으로 오른쪽 정렬
        mainAxisSize: MainAxisSize.min, // Column이 자식 위젯 크기에 맞게 최소한으로 공간 차지
        children: [ // 수식과 결과를 표시하는 TextField 위젯

          TextField( // 수식 입력용 TextField
            controller: exp, // 수식 TextField 제어용 컨트롤러
            enabled: false, // 사용자가 직접 입력할 수 없도록 설정
            textAlign: TextAlign.right, //  텍스트를 오른쪽으로 정렬
            style: const TextStyle( // 수식 텍스트 스타일
              color: Colors.grey,
              fontSize: 24,
            ),
            decoration: const InputDecoration(border: InputBorder.none), // TextField의 기본 테두리 제거
          ),

          TextField(  // 결과 표시용 TextField
            controller: res,  // 결과 TextField 제어용 컨트롤러
            enabled: false,   // 사용자가 직접 입력할 수 없도록 설정
            textAlign: TextAlign.right,  // 텍스트를 오른쪽으로 정렬
            style: const TextStyle(      // 결과 텍스트 스타일
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(border: InputBorder.none), // TextField의 기본 테두리 제거
          ),
        ],
      ),
    );
  }

  Widget _buildTopButtonRow() {  // 상단 기능 버튼이 배치되는 영역
    return Padding(  // 버튼 영역 전체에 패딩 추가
      padding: const EdgeInsets.all(10), // 버튼 영역 전체에 패딩 추가
      child: GridView.builder( // 버튼 영역을 GridView로 구성
        shrinkWrap: true, //  GridView가 자식 위젯 크기에 맞게 최소한으로 공간 차지
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // 그리드의 열 수와 간격 설정
          crossAxisCount: 4,      // 4열로 구성
          crossAxisSpacing: 10,   // 열 간격 10
          mainAxisSpacing: 10,    // 행 간격 10
        ),
        itemCount: 4,              // 상단 기능 버튼 4개
        itemBuilder: (context, index) {         // 각 버튼을 빌드하는 함수
          return _buildButton(buttons[index]);  // 상단 4개 버튼을 순서대로 빌드
        },
      ),
    );
  }

  Widget _buildSecondButtonRow() { // AC, (), %, ÷ 버튼이 배치되는 영역
    return Padding( // 버튼 영역 전체에 패딩 추가
      padding: const EdgeInsets.symmetric(horizontal: 10), // 좌우에만 패딩 추가
      child: GridView.builder( // 버튼 영역을 GridView로 구성
        shrinkWrap: true, // GridView가 자식 위젯 크기에 맞게 최소한으로 공간 차지
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // 그리드의 열 수와 간격 설정
          crossAxisCount: 4, // 4열로 구성
          crossAxisSpacing: 10, // 열 간격 10
          mainAxisSpacing: 10,  // 행 간격 10
        ),
        itemCount: 4,  // AC, (), %, ÷ 버튼 4개
        itemBuilder: (context, index) { // 각 버튼을 빌드하는 함수
          return _buildButton(buttons[index + 4]); // 상단 4개 버튼을 제외한 다음 4개 버튼을 순서대로 빌드
        },
      ),
    );
  }

  // Widget _buildDigitButtonGrid() { // 숫자 버튼과 일부 기능 버튼이 배치되는 영역 (GridView로 구성)
  //   return Padding( // 버튼 영역 전체에 패딩 추가 
  //     padding: const EdgeInsets.all(10), // 버튼 영역 전체에 패딩 추가
  //     child: GridView.builder( // 버튼 영역을 GridView로 구성 
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // 그리드의 열 수와 간격 설정
  //         crossAxisCount: 4,     // 4열로 구성
  //         crossAxisSpacing: 10,  // 열 간격 10
  //         mainAxisSpacing: 10,   // 행 간격 10
  //       ),
  //       itemCount: buttons.length - 8,    // 8개의 상단 버튼을 제외한 나머지 버튼 수
  //       itemBuilder: (context, index) {   // 각 버튼을 빌드하는 함수
  //         return _buildButton(buttons[index + 8]); // 상단 8개 버튼을 제외한 나머지 버튼을 순서대로 빌드
  //       },
  //     ),
  //   );
  // }

  Widget _buildButton(CalcButton button) {  // 개별 버튼을 빌드하는 함수
    Color bgColor = Colors.grey[800]!; // 기본 배경색 설정 (스타일에 따라 변경될 수 있음)
    Color textColor = Colors.white;    // 기본 텍스트 색상 설정 (스타일에 따라 변경될 수 있음)

    if (button.style == ButtonStyle.styleA) { // 상단 기능 버튼 스타일
      bgColor = Colors.grey[700]!;            // 스타일 A: 짙은 회색 배경, 흰색 텍스트
    } else if (button.style == ButtonStyle.styleB) { // 연산자 버튼 스타일: 주황색 배경, 흰색 텍스트
      bgColor = Colors.orange; 
      textColor = Colors.white; 
    } else if (button.style == ButtonStyle.styleC) { // 숫자 및 일부 기능 버튼 스타일
      if (button.value == '=') { // '=' 버튼은 스타일 C 중에서도 특별히 주황색 배경과 흰색 텍스트로 설정
        bgColor = Colors.orange;
        textColor = Colors.white;
      } else if (button.type != ButtonType.digit) { // 숫자 버튼이 아닌 스타일 C 버튼은 짙은 회색 배경과 흰색 텍스트로 설정
        bgColor = const Color.fromARGB(255, 32, 32, 32);
      } else { // 숫자 버튼은 스타일 C 중에서도 짙은 회색 배경과 흰색 텍스트로 설정
        bgColor = const Color.fromARGB(255, 92, 92, 92)!;
      }
    }

    return GestureDetector( // 버튼을 터치할 수 있도록 GestureDetector로 감싸기
      onTap: () => onButtonPressed(button.type, button.value), // 버튼 클릭 시 onButtonPressed 함수 호출
      child: Container( // 버튼의 시각적 표현을 담당하는 Container
        decoration: BoxDecoration( // 버튼의 배경색과 모서리 둥글게 설정
          color: bgColor, // 버튼의 배경색 설정
          borderRadius: BorderRadius.circular(12), // 버튼의 모서리를 둥글게 설정 (반지름 12)
        ),
        child: Center( // 버튼의 내용(아이콘 또는 텍스트)을 중앙에 배치
          child: button.icon != null // 버튼에 아이콘이 있는 경우 아이콘을 표시, 그렇지 않으면 텍스트를 표시
              ? Icon(button.icon, color: textColor, size: 24) // 아이콘이 있는 경우 아이콘을 표시 (아이콘 색상과 크기 설정)
              : Text( // 아이콘이 없는 경우 텍스트를 표시
                  button.text ?? button.value, // 버튼에 표시할 텍스트 (text가 null인 경우 value 사용)
                  style: TextStyle( // 텍스트 스타일 설정
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  } // _buildButton 함수 끝
} // _HomePageState 클래스 끝

