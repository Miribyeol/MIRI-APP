# MIRI_APP

펫로스 증후군 극복 서비스 [미리별](https://github.com/Miribyeol)의 **Front-End Repository** 입니다.

---

## 사용 기술

- Flutter
- Dart

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
- 편지 보내기 기능
  - 편지 작성 기능 구현
  - 편지 보내기 기능 구현


## 주요 기능 이미지
- 메인화면
![메인화면](https://github.com/Miribyeol/MIRI-APP/assets/92287948/fbcdf0e7-8778-4587-a9b0-b460c49dd225)

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

4. 앱을 실행합니다.

   ```
   $ flutter run
   ```

## 개발자

- 황서이 - [Seoi-Hwang](https://github.com/Hwang-seo-i) - hnvvely@gmail.com
- 정재욱 - [jjy0921](https://github.com/jjy0921) - jssj0921@naver.com
- 이현우 - [Lehyunwoo](https://github.com/Hyu-noo) - lehw20@naver.com
