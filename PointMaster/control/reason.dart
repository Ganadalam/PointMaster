import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/member_provider.dart';
import '../const/appbar.dart';
import 'maincontrol.dart';

class Reason extends StatefulWidget {
  final String memberName;
  final String scoreType; // '상점' 또는 '벌점'

  const Reason({
    Key? key,
    required this.memberName,
    required this.scoreType,
  }) : super(key: key);

  @override
  _ReasonState createState() => _ReasonState();
}

class _ReasonState extends State<Reason> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                '구성원: ${widget.memberName}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  '추가 유형: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.scoreType, // 상점 또는 벌점
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: widget.scoreType == '상점' ? Color(0xFFFAD89E) : Colors.red, // 색상 변경
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '사유를 입력해 주세요.',
              ),
            ),
            const SizedBox(height: 30),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFAD89E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                onPressed: () {
                  if (_reasonController.text.isNotEmpty) {
                    if (widget.scoreType == '상점') {
                      Provider.of<MemberProvider>(context, listen: false)
                          .addReward(widget.memberName, _reasonController.text);
                    } else {
                      Provider.of<MemberProvider>(context, listen: false)
                          .addPenalty(widget.memberName, _reasonController.text);
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => control()), // 구성원 목록 화면으로 이동
                          (Route<dynamic> route) => false, // 이전 모든 화면 스택을 지움
                    );
                  } else {
                    // 사유가 비어있을 경우 알림
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('사유를 입력해 주세요.')),
                    );
                  }
                },
                child: const Text(
                  '추가하기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
