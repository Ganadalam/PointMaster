import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/member_provider.dart';
import '../const/appbar.dart';

class History extends StatelessWidget {
  final String member;

  const History({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    final historyList = memberProvider.getHistory(member);

    // 상점 내역과 벌점 내역 분리
    final rewardHistory = historyList.where((entry) => entry.startsWith('상점:')).toList();
    final penaltyHistory = historyList.where((entry) => entry.startsWith('벌점:')).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 50),
              child: Text(
                '$member 님의 상벌점 내역',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // 중앙 정렬
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  // 상점 내역 리스트
                  Expanded(
                    child: ListView.builder(
                      itemCount: rewardHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(rewardHistory[index]), // 상점 내역 표시
                        );
                      },
                    ),
                  ),
                  VerticalDivider(width: 1), // 리스트 구분선
                  // 벌점 내역 리스트
                  Expanded(
                    child: ListView.builder(
                      itemCount: penaltyHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(penaltyHistory[index]), // 벌점 내역 표시
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
