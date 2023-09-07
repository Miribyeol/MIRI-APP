# MIRI_APP

펫로스 증후군 극복 서비스 [미리별](https://github.com/Miribyeol)의 **Front-End Repository** 입니다.

---

## 사용 기술

![Flutter Version](https://img.shields.io/badge/flutter-%2302569B.svg?style=flat-square&logo=flutter&logoColor=white)
![Flutter App](https://img.shields.io/badge/flutter-app-%2302569B.svg?style=flat-square&logo=flutter&logoColor=white)
![Flutter iOS](https://img.shields.io/badge/flutter-iOS-%2302569B.svg?style=flat-square&logo=flutter&logoColor=white)
![Flutter Plugin](https://img.shields.io/badge/flutter-plugin-%2302569B.svg?style=flat-square&logo=flutter&logoColor=white)
![Dart Version](https://img.shields.io/badge/dart-%230175C2.svg?style=flat-square&logo=dart&logoColor=white)
![Dart Channel](https://img.shields.io/badge/dart-stable-%230175C2.svg?style=flat-square&logo=dart&logoColor=white)
![Dart VM](https://img.shields.io/badge/dart-VM-%230175C2.svg?style=flat-square&logo=dart&logoColor=white)
![Dart Native](https://img.shields.io/badge/dart-native-%230175C2.svg?style=flat-square&logo=dart&logoColor=white)
![MVVM](https://img.shields.io/badge/architecture-MVVM-blue.svg)

## 프로젝트 설계

- MVVM
- 폴더 구조

  ```
  MIRI-APP
  │
  ├── assets
  │   ├── icon
  │   └── image
  └──lib
      ├── models
      ├── screens
      ├── services
      ├── widgets
      ├── main.dart
      └── routes.dart

  ```

## 주요 기능

- 로그인
  - 카카오 로그인을 통한 사용자 회원가입 및 로그인 구현
  - 카카로 로그인을 통한 자동 로그인
- 반려동물 정보 작성 및 수정
  - 반려동물 이름, 종류, 태어난 날짜, 죽은 날짜, 사진 업로드 및 수정 기능 구현
- 14일 챌린지
  - 14일 챌린지 기능 구현
  - 완료 시 감정 상태 기록 기능 구현
- 편지 보내기 기능
  - 편지 작성 기능 구현
  - 편지 보내기 기능 구현
- 반려동물 사진 보기
  - 반려동물 사진 확인 기능 구현
  - 다른 반려동물 사진 확인

## 주요 기능 이미지

- 메인화면

<div>
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/fbcdf0e7-8778-4587-a9b0-b460c49dd225" width="300" height="600" alt="메인화면">
</div>

- 14일 챌린지 화면

<div>
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/4377ae04-901a-462e-b5a0-f76268405268" width="300" height="600" alt="챌린지리스트화면">
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/c020371b-2adb-47a4-822c-82a7aa3cfa7b" width="300" height="600" alt="챌린지화면">
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/b474a0ff-dd04-4086-8811-9dd1c3b31b0b" width="300" height="600" alt="챌린지완료화면">
</div>

- 영원한 발자국 화면

<div>
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/e2c1a173-55a1-4a72-8aca-abd3b7ba0bb2" width="300" height="600" alt="반려동물납골당">
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/67e6a9b2-8d2b-4ec7-9b6d-0112ee970648" width="300" height="600" alt="반려동물납골당">
</div>

- 미리별 정거장 화면

<div>
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/584837ce-bcbf-43ea-ad5a-adc0c629a4aa" width="300" height="600" alt="반려동물납골당">
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/a1c93918-ded5-4423-8be0-18ae7f50ac4e" width="300" height="600" alt="미리별 정거장">
<img src="https://github.com/Miribyeol/MIRI-APP/assets/92287948/1676d348-b8b5-4162-8cec-135a748875dc" width="300" height="600" alt="미리별 정거장 보내기">
</div>

---

## 프로젝트 설치 및 실행 방법

### 전제조건

1. Flutter, Dart 버전 확인 후 알맞게 설치해 주세요.

   ```
   $ Flutter 3.13.1
   $ Dart 3.1.0
   ```

### 세팅 및 실행

1. GitHub 저장소를 클론합니다.

   ```
   $ git clone https://github.com/Miribyeol/MIRI-APP.git
   ```

2. 프로젝트 루트 경로에 .env 파일 생성 후 아래 예시를 참고하여 내용을 작성해 주세요.

   ```
   # .env 예시
    KAKAO_APP_KEY=
    API_URL = http://서버 주소
   ```

3. Flutter 패키지를 설치합니다.

   ```
   $ flutter pub get
   ```

4. Android 키 해시 생성 및 등록

   ```
   터미널에 키 코드 입력
   < 디버그 키 해시 >
   Mac - keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64
   Windows - keytool -exportcert -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64

   < 릴리즈 키 해시 >
   Mac - keytool -exportcert -alias <RELEASE_KEY_ALIAS> -keystore <RELEASE_KEY_PATH> | openssl sha1 -binary | openssl base64
   Windows - keytool -exportcert -alias <RELEASE_KEY_ALIAS> -keystore <RELEASE_KEY_PATH> | openssl sha1 -binary | PATH_TO_OPENSSL_LIBRARY\bin\openssl base64

   <KAKAO DEVELOPERS에 접속>
   내 애플리케이션 > 앱 설정 > 플랫폼 > Android 플랫폼 수정 > 키해시 등록
   ```

5. APP KEY 등록.

   ```
   Andriod -> local.properties에 kakao.api.key=${API KEY} 등록 > MIRI-APP/android/app/build.gradle에 def kakaoApiKey = localProperties.getProperty('kakao.api.key') 작성 > AndroidManifest에서 manifestPlaceholders["kakaoApiKey"] = kakaoApiKey 작성

   ios -> MIRI-APP/ios/Runner/Config.xcconfig 파일 생성 후 KAKAO_API_KEY=${API KEY} 작성 > MIRI-APP/ios/Runner/Info.plist에  API Key를 적용
   ```

6. 앱을 실행합니다.

   ```
   $ flutter run
   ```

## 개발자

- 황서이 - [Seoi-Hwang](https://github.com/Hwang-seo-i) - hnvvely@gmail.com
- 정재욱 - [jjy0921](https://github.com/jjy0921) - jssj0921@naver.com
- 이현우 - [Lehyunwoo](https://github.com/Hyu-noo) - lehw20@naver.com
