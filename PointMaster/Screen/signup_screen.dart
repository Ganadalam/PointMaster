import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrimPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이름을 입력해주세요!!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이메일을 입력해주세요!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '패스워드를 입력해주세요!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confrimPasswordController,
                decoration: InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '패스워드 확인을 입력해주세요!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    if (_passwordController.text !=
                        _confrimPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("비밀번호가 다릅니다."),
                        ),
                      );
                      return;
                    }
                  }
                  try {
                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    var db = FirebaseFirestore.instance;
                    final user = <String, String>{
                      "name": _nameController.text,
                      "email": _emailController.text,
                    };

                    await FirebaseAuth.instance.setLanguageCode("Kr");
                    credential.user!.sendEmailVerification();

                    await db
                        .collection("users")
                        .doc(credential.user!.uid)
                        .set(user)
                        .onError((e, _) => print("Error writing document: $e"));
                    Navigator.pushNamed(context, '/login');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("회원가입"),
              )
            ],

          ),
        ),
      ),
    );
  }
}
