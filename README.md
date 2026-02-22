"This repository is a record of my personal learning journey. In line with 42's academic integrity policy, please use this for inspiration rather than direct submission. Let's learn and grow together!"

# Mobile Module 00 - Flutter 기초

## 📚 목차

- [한국어](#한국어)
- [日本語](#日本語)
- [English](#English)

---

## 한국어

### 📖 개요

Mobile Module 00은 Flutter를 사용한 모바일 앱 개발의 기초를 학습하는 모듈입니다. 각 exercise는 점진적으로 복잡도가 증가하며, Flutter의 핵심 개념들을 실습합니다.

### 📁 Exercise 구성

#### **ex00: 기본 Flutter 앱**
- **주제**: Flutter 프로젝트 생성 및 기본 구조 이해
- **학습 내용**:
  - MaterialApp 및 Scaffold 위젯의 기본 사용법
  - StatelessWidget 구현
  - FloatingActionButton과 ElevatedButton 클릭 이벤트
  - 기본 레이아웃 구성 (AppBar, Body, Center, Column)

#### **ex01: 상태 관리 (State Management)**
- **주제**: StatefulWidget을 사용한 동적 UI 업데이트
- **학습 내용**:
  - StatefulWidget과 State 클래스 이해
  - setState() 함수를 통한 상태 업데이트
  - 삼항 연산자를 활용한 조건부 렌더링
  - Widget 클릭 이벤트에 따른 UI 변경

#### **ex02: 계산기 UI 레이아웃**
- **주제**: 복잡한 레이아웃 설계 및 구현
- **학습 내용**:
  - GridView를 사용한 다중 버튼 배치
  - 다양한 스타일의 버튼 설계
  - TextEditingController를 사용한 입력 필드 관리
  - 계산기 버튼 모델 설계 (ButtonType, ButtonStyle Enum)

#### **ex03: 계산기 기능 구현**
- **주제**: math_expressions 라이브러리를 사용한 실제 계산 구현
- **학습 내용**:
  - 외부 라이브러리 의존성 관리
  - 문자열 표현식 파싱 및 계산
  - 계산 이력 저장 및 표시
  - 과학 계산기 모드 추가 기능

### 🚀 시작하기

#### 요구사항
- Flutter 3.10.8 이상
- Dart 3.10.8 이상
- iOS, Android, Web, Linux, macOS, Windows 플랫폼 지원

#### 각 Exercise 실행 방법

```bash
cd ex00    # 원하는 exercise 폴더로 이동
flutter pub get    # 의존성 설치
flutter run    # 앱 실행
```

### 📚 학습 목표

1. **ex00**: Flutter 앱의 기본 구조와 생명주기 이해
2. **ex01**: 상태 관리의 중요성 학습
3. **ex02**: 복잡한 UI 레이아웃 구성 능력 습득
4. **ex03**: 실무 프로젝트의 기능 구현 능력 개발

---

## 日本語

### 📖 概要

Mobile Module 00は、Flutterを使用したモバイルアプリ開発の基礎を学ぶモジュールです。各exerciseは段階的に複雑性が増し、Flutterの重要な概念を実践します。

### 📁 Exercise構成

#### **ex00: 基本的なFlutterアプリ**
- **テーマ**: Flutterプロジェクト作成と基本構造の理解
- **学習内容**:
  - MaterialAppとScaffoldウィジェットの基本的な使用方法
  - StatelessWidgetの実装
  - FloatingActionButtonとElevatedButtonのクリックイベント
  - 基本的なレイアウト構成（AppBar、Body、Center、Column）

#### **ex01: 状態管理（State Management）**
- **テーマ**: StatefulWidgetを使用した動的UI更新
- **学習内容**:
  - StatefulWidgetとStateクラスの理解
  - setState()関数による状態更新
  - 三項演算子を使用した条件付きレンダリング
  - ウィジェットクリックイベントに応じたUI変更

#### **ex02: 電卓UIレイアウト**
- **テーマ**: 複雑なレイアウト設計と実装
- **学習内容**:
  - GridViewを使用した複数ボタンの配置
  - さまざまなスタイルのボタン設計
  - TextEditingControllerを使用した入力フィールド管理
  - 電卓ボタンモデル設計（ButtonType、ButtonStyle Enum）

#### **ex03: 電卓機能の実装**
- **テーマ**: math_expressionsライブラリを使用した実際の計算実装
- **学習内容**:
  - 外部ライブラリの依存性管理
  - 文字列式のパースと計算
  - 計算履歴の保存と表示
  - 科学計算機モード追加機能

### 🚀 はじめに

#### 要件
- Flutter 3.10.8以上
- Dart 3.10.8以上
- iOS、Android、Web、Linux、macOS、Windows プラットフォーム対応

#### 各Exerciseの実行方法

```bash
cd ex00    # 希望するexerciseフォルダに移動
flutter pub get    # 依存性をインストール
flutter run    # アプリを実行
```

### 📚 学習目標

1. **ex00**: Flutterアプリの基本構造とライフサイクルの理解
2. **ex01**: 状態管理の重要性を学習
3. **ex02**: 複雑なUIレイアウト構成能力の習得
4. **ex03**: 実務プロジェクトの機能実装能力の開発

---

## English

### 📖 Overview

Mobile Module 00 is a module for learning the fundamentals of mobile app development using Flutter. Each exercise progressively increases in complexity, covering essential Flutter concepts through hands-on practice.

### 📁 Exercise Structure

#### **ex00: Basic Flutter App**
- **Topic**: Creating a Flutter project and understanding basic structure
- **Learning Objectives**:
  - Basic usage of MaterialApp and Scaffold widgets
  - Implementation of StatelessWidget
  - Handling FloatingActionButton and ElevatedButton click events
  - Basic layout composition (AppBar, Body, Center, Column)

#### **ex01: State Management**
- **Topic**: Dynamic UI updates using StatefulWidget
- **Learning Objectives**:
  - Understanding StatefulWidget and State classes
  - State updates using setState() function
  - Conditional rendering with ternary operators
  - UI changes based on widget click events

#### **ex02: Calculator UI Layout**
- **Topic**: Complex layout design and implementation
- **Learning Objectives**:
  - Multiple button arrangement using GridView
  - Various button style designs
  - Input field management using TextEditingController
  - Calculator button model design (ButtonType, ButtonStyle Enum)

#### **ex03: Calculator Functionality**
- **Topic**: Actual calculation implementation using math_expressions library
- **Learning Objectives**:
  - External library dependency management
  - String expression parsing and evaluation
  - Storing and displaying calculation history
  - Scientific calculator mode features

### 🚀 Getting Started

#### Requirements
- Flutter 3.10.8 or later
- Dart 3.10.8 or later
- Support for iOS, Android, Web, Linux, macOS, Windows platforms

#### Running Each Exercise

```bash
cd ex00    # Navigate to desired exercise folder
flutter pub get    # Install dependencies
flutter run    # Run the app
```

### 📚 Learning Goals

1. **ex00**: Understand Flutter app structure and lifecycle
2. **ex01**: Learn the importance of state management
3. **ex02**: Develop complex UI layout composition skills
4. **ex03**: Build practical project implementation capabilities

---

## 📝 라이센스 | ライセンス | License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.
