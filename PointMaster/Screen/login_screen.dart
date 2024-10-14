import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../provider/login_provider.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginProvider _loginProvider = LoginProvider(); // 인스턴스 생성

  Future<void> _login() async {
    try {
      await _loginProvider.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      // 로그인 성공 시 원하는 화면으로 이동
      Navigator.pushNamed(context, '/success');
    } catch (e) {
      // 예외가 발생한 경우 UI에 경고 메시지를 보여줌
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, // 로그인 함수 실행
              child: Text("로그인"),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/signup');
              }, // 로그인 함수 실행
              child: Text("회원가입"),
            ),
          ],
        ),
      ),
    );
  }
}