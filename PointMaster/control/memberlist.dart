import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/member_provider.dart';
import '../control/addpoint.dart';
import '../const/appbar.dart';

class MemberList extends StatefulWidget {
  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  final TextEditingController _controller = TextEditingController();
 // TextEditingController 생성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: const Text(
                '구성원 목록',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Consumer<MemberProvider>(
                builder: (context, memberProvider, child) {
                  return GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    children: List.generate(memberProvider.members.length, (index) {
                      return Card(
                        color: Color(0xFFFAD89E),
                        margin: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                _navigateToMainControl(memberProvider.members[index]);
                              },
                              child: Center(
                                child: Text(
                                  memberProvider.members[index],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 4,
                              child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.grey, size: 15),
                                onPressed: () {
                                  memberProvider.removeMember(memberProvider.members[index]); // 이름 삭제
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: '구성원 추가',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 모서리 둥글게 설정
                    side: BorderSide(color: Colors.grey, width: 1), // 테두리 색상과 두께 설정
                  ),
                ),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Provider.of<MemberProvider>(context, listen: false).addMember(_controller.text); // 이름 추가
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                child: const Text('추가하기',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMainControl(String memberName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Addpoint(memberName: memberName),
      ),
    );
  }
}
