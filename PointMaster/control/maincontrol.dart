import 'package:flutter/material.dart';
import 'data.dart';
import 'memberlist.dart';

class control extends StatefulWidget {
  @override
  _controlState createState() => _controlState();
}

class _controlState extends State<control> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스


  // 탭에 따라 표시할 화면
  final List<Widget> _screens = [
    MemberList(), // 첫 번째 화면
    Data(), // 두 번째 화면
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 탭 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // 선택된 화면 표시
      bottomNavigationBar: Container(
        height: 100, // 원하는 높이 설정
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '구성원 목록',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: '통계',
            ),
          ],
          currentIndex: _selectedIndex, // 현재 선택된 인덱스
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped, // 탭 클릭 시 호출되는 함수
        ),
      ),
    );
  }
}
