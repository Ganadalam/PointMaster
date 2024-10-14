import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) { // context를 매개변수로 추가
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      'Point Master',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop(); // context 사용 가능
      },
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10.0), // 이미지 오른쪽 여백
        child: Image.asset(
          'asset/img/mainimg.jpg', // 캐릭터 이미지 추가
          width: 50,
          height: 50,
        ),
      ),
    ],
  );
}
