import 'package:flutter/material.dart';
import '../const/appbar.dart';
import '../control/maincontrol.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> _items = []; // 항목 리스트

  void _addItem(String item) {
    setState(() {
      _items.add(item); // 리스트에 새 항목 추가
    });
  }

  Future<void> _showAddItemDialog() async {
    String? newItem;
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // Focus on the TextField when the dialog is displayed
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).requestFocus(focusNode);
        });

        return AlertDialog(
          title: Text('새 항목 추가'),
          content: TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (value) {
              newItem = value; // 입력된 값 저장
            },
            decoration: InputDecoration(hintText: "항목 이름"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('추가'),
              onPressed: () {
                if (newItem != null && newItem!.isNotEmpty) {
                  _addItem(newItem!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10), // 위아래 공간 추가
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFF5D1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 1), // 테두리 색상 및 두께
                          borderRadius: BorderRadius.circular(10), // 모서리 둥글기
                        ),
                      ),
                      onPressed: () {
                        // 버튼 클릭 시 SubPage로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => control(),
                          ),
                        );
                      },
                      child: Text(item,
                      style: TextStyle(
                        color: Colors.black
                      ),),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: _showAddItemDialog, // 항목 추가를 위한 다이얼로그 호출
          backgroundColor: Color(0xFFFAD89E),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // 버튼 중앙에 위치
    );
  }
}
