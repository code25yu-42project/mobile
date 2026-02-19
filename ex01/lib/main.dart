import 'package:flutter/material.dart';
// Flutter의 기본 머티리얼 UI 위젯을 사용하기 위해 import

void main() {
  runApp(const MyApp());
  // Flutter 앱 실행, MyApp을 앱의 루트 위젯으로 설정
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // StatelessWidget: 상태가 없는 위젯 (앱 전체 설정용)

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // MaterialApp: Flutter 앱의 전체 설정을 담당하는 위젯
      home: HomePage(),
      // 앱 실행 시 가장 먼저 보여줄 화면
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  // StatefulWidget: 상태(state)가 있어 화면 변경 가능

  @override
  State<HomePage> createState() => _HomePageState();
// HomePage의 상태를 관리하는 State 객체 생성
}

class _HomePageState extends State<HomePage> {
  bool isHello = false;
  // 화면에 표시될 텍스트를 결정하는 상태 변수
  // false = "Hello Flutter", true = "Hello World"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold: 화면의 기본 구조(appBar, body 등 제공)

      body: Center(
        // 화면 중앙에 배치하는 위젯

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // 세로축 기준으로 가운데 정렬

          children: [
            Text(
              isHello ? 'Hello World' : 'Hello Flutter',
              // 삼항 연산자: isHello의 값에 따라 텍스트 변경
              style: const TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 10),
            // 위 텍스트와 버튼 사이 간격

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isHello = !isHello;
                  // 버튼을 누를 때마다 true/false 토글
                  // setState()를 호출해야 화면이 다시 그려짐
                });

                debugPrint('Button pressed');
                // 디버그 콘솔에 로그 출력
              },
              child: const Text('Button'),
              // 버튼에 표시되는 텍스트
            ),
          ],
        ),
      ),
    );
  }
}
