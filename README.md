"This repository is a record of my personal learning journey. In line with 42's academic integrity policy, please use this for inspiration rather than direct submission. Let's learn and grow together!"

# 모바일
간단한 설명

이 저장소는 42 모바일 과제(Flutter) 모음입니다. 각 서브디렉토리(`ex00`, `ex01`, `ex03` 등)는 독립적인 Flutter 예제/과제 프로젝트이며, 각 프로젝트의 진입점은 보통 `lib/main.dart`입니다.

**프로젝트 목록**
- **ex00**: 기본 Flutter 템플릿 애플리케이션
- **ex01**: 과제 및 실습용 Flutter 앱
- **ex03**: 추가 실습용 Flutter 앱 (일부 파일이 생략되어 있을 수 있음)

각 `exNN` 폴더는 독립적으로 실행할 수 있는 Flutter 프로젝트입니다. 실제 저장소에는 `android/`, `ios/`, `macos/`, `linux/`, `web/`, `windows/` 플랫폼 폴더와 `pubspec.yaml`, `lib/main.dart`, `test/widget_test.dart` 등이 포함되어 있습니다.

**빠른 시작**
- Flutter가 설치되어 있는지 확인: `flutter --version`
- 사용 가능한 기기 확인: `flutter devices`
- 예제 실행 (예: `ex00`):

```
cd ex00
flutter pub get
flutter run -d <device-id>
```

또는 VS Code / Android Studio에서 해당 `exNN` 폴더를 열어 실행하세요.

테스트 실행:

```
cd ex00
flutter test
```

**플랫폼 별 주의사항**
- Android: Android SDK 및 적절한 에뮬레이터/기기 필요
- iOS / macOS: Xcode와 시뮬레이터 필요 (macOS에서만 가능)
- Web: Chrome 등 브라우저에서 실행 가능 (`flutter run -d chrome`)

**기여 및 변경**
- 각 `exNN` 폴더는 독립적이므로 변경 시 해당 폴더만 수정하십시오.

**라이선스**
- 저장소 루트의 `LICENSE` 파일을 확인하세요.

질문이나 추가로 포함했으면 하는 내용(예: 각 과제별 목표, 스크린샷, 요구사항)이 있으면 알려주세요.


# mobile

Short description

This repository contains 42 Mobile assignments and practice projects built with Flutter. Each subdirectory (`ex00`, `ex01`, `ex03`, etc.) is an independent Flutter example/assignment project. The typical entry point for each project is `lib/main.dart`.

**Project list**
- **ex00**: Basic Flutter template application
- **ex01**: Assignment / practice Flutter app
- **ex03**: Additional practice Flutter app (some files may be omitted)

Each `exNN` folder is a standalone Flutter project and usually includes platform folders such as `android/`, `ios/`, `macos/`, `linux/`, `web/`, and `windows/`, as well as `pubspec.yaml`, `lib/main.dart`, and `test/widget_test.dart`.

**Quick start**
- Verify Flutter is installed: `flutter --version`
- List available devices: `flutter devices`
- Run an example (for example `ex00`):

```
cd ex00
flutter pub get
flutter run -d <device-id>
```

Or open the `exNN` folder in VS Code or Android Studio and run from the IDE.

Run tests:

```
cd ex00
flutter test
```

**Platform notes**
- Android: Requires Android SDK and an emulator or device
- iOS / macOS: Requires Xcode and simulator (macOS only)
- Web: Can run in a browser (e.g. `flutter run -d chrome`)

**Contributing / Changes**
- Each `exNN` folder is independent — modify only the relevant folder when making changes.

**License**
- See the `LICENSE` file at the repository root.

If you'd like, I can add per-exercise objectives, screenshots, or specific run instructions for any `exNN` folder — tell me which ones to expand.
