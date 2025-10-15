📱 PointMaster

Flutter + Firebase 기반 포인트 관리 앱

사용자 로그인, 멤버 관리, 포인트 지급 및 히스토리 관리 기능을 제공합니다.  
동아리/스터디/조직 단위의 운영 및 공간 우선 할당을 위한 간단한 포인트 제도 시행을 위해 제작되었습니다.


 🚀 주요 기능

🔐 로그인 / 회원가입 : Firebase Authentication을 이용한 이메일 로그인
🧑‍🤝‍🧑 멤버 관리 : 멤버 추가 및 목록 관리 
💰 포인트 관리 : 포인트 추가 및 내역 확인 
🎨 UI 구성 : Material Design 기반 인터페이스

🧩 기술 스택

- Frontend: Flutter (Dart)
- State Management: Provider
- Authentication: Firebase Authentication
- UI Framework: Material Design
- Routing: Navigator (Named Routes)


 🧠 주요 코드 예시
 
### 로그인 로직
```dart
await _loginProvider.signInWithEmailAndPassword(
  _emailController.text,
  _passwordController.text,
);
Navigator.pushNamed(context, '/success');
```

Firebase Authentication을 이용해 이메일 로그인 후, 성공 시 다음 화면으로 이동합니다.
