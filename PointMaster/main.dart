import 'package:pointmaster/Screen/mainscreen.dart';
import 'package:pointmaster/provider/member_provider.dart';
import 'package:provider/provider.dart';
import 'const/splashscreen.dart';
import 'provider/login_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screen/login_screen.dart';
import 'Screen/signup_screen.dart';
import 'Screen/success_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemberProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()), // loginProvider 추가
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) =>  SplashScreen(),
        '/login': (context) =>  LoginScreen(),
        '/signup': (context) =>  SignupScreen(),
        '/success': (context) =>  MainScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text("채팅 앱"),
        ),
      ),
    );
  }
}
