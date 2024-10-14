import 'package:flutter/material.dart';
import 'package:pointmaster/control/reason.dart';
import '../const/appbar.dart';

class Addpoint extends StatelessWidget {
  final String memberName; // 선택된 구성원 이름을 저장할 변수

  const Addpoint({Key? key, required this.memberName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context), // 동일한 AppBar 사용
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$memberName 님에게 상벌점을 주기', // 선택된 구성원 이름 표시
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 30), // 버튼 간의 간격
                // 가로로 정렬된 버튼
                Container(
                  width: MediaQuery.of(context).size.width / 1.3, // 원하는 너비로 설정
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFAD89E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 둥글게 설정
                        side: BorderSide(color: Colors.grey, width: 1), // 테두리 색상과 두께 설정
                      ),
                    ),
                    onPressed: () {
                      // 상점주기 버튼 클릭 시 AddScreen으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Reason(
                            memberName: memberName,
                            scoreType: '상점',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      '상점주기',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30), // 버튼 간의 간격
                Container(
                  width: MediaQuery.of(context).size.width / 1.3, // 원하는 너비로 설정
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFBBBB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 둥글게 설정
                        side: BorderSide(color: Colors.grey, width: 1), // 테두리 색상과 두께 설정
                      ),
                    ),
                    onPressed: () {
                      // 벌점주기 버튼 클릭 시 AddScreen으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Reason(
                            memberName: memberName,
                            scoreType: '벌점',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      '벌점주기',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
