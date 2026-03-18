FLUTTER = flutter

# Install dependencies (download packages from pubspec.yaml)
# 의존성 설치 (pubspec.yaml에 정의된 라이브러리 다운로드)
get:
	$(FLUTTER) pub get

# Run app in development (build + launch on device) 
# 개발 실행 (빌드 후 디바이스에서 실행)
run:
	$(FLUTTER) run

# Build APK file for Android (distributable app file)
# APK 빌드 (배포 가능한 안드로이드 앱 파일 생성)
build:
	$(FLUTTER) build apk

# Clean build cache and artifacts
# 빌드 캐시 및 생성 파일 정리
clean:
	$(FLUTTER) clean

.PHONY: get run build clean