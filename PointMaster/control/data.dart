import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const/appbar.dart';
import '../../provider/member_provider.dart';
import 'history.dart'; // 히스토리 화면 가져오기

class Data extends StatelessWidget {
  const Data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Column(
          children: [
            _ScoreSummary(), // 점수 요약 추가
            Expanded(child: _ScoreList()), // 리스트 표시
          ],
        ),
      ),
    );
  }
}

class _ScoreSummary extends StatelessWidget {
  const _ScoreSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    List<String> topMembers = [];
    List<String> bottomMembers = [];
    int highestScore = 0;
    int lowestScore = 0;

    if (memberProvider.members.isNotEmpty) {
      for (var member in memberProvider.members) {
        final rewardPoints = memberProvider.getRewardPoints(member);
        final penaltyPoints = memberProvider.getPenaltyPoints(member);
        final totalPoints = rewardPoints - penaltyPoints;

        // 가장 높은 점수 찾기
        if (totalPoints > highestScore) {
          highestScore = totalPoints;
          topMembers = [member]; // 새로운 최고 점수를 가진 구성원 초기화
        } else if (totalPoints == highestScore) {
          topMembers.add(member); // 동점자 추가
        }

        // 가장 낮은 점수 찾기
        if (lowestScore == 0 || totalPoints < lowestScore) {
          lowestScore = totalPoints;
          bottomMembers = [member]; // 새로운 최저 점수를 가진 구성원 초기화
        } else if (totalPoints == lowestScore) {
          bottomMembers.add(member); // 동점자 추가
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "BEST!",
                style: TextStyle(fontSize: 30.0, color: Colors.red),
              ),
              const SizedBox(height: 10),
              Text(
                topMembers.isNotEmpty ? topMembers.join(', ') : '', // 동점자 표시
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Worst..",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blue
                ),
              ),
              const SizedBox(height: 10),
              Text(
                bottomMembers.isNotEmpty
                    ? bottomMembers.join(', ')
                    : '', // 동점자 표시
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreList extends StatelessWidget {
  const _ScoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context);
    return ListView.builder(
      itemCount: memberProvider.members.length,
      itemBuilder: (context, index) {
        final member = memberProvider.members[index];
        final rewardPoints = memberProvider.getRewardPoints(member);
        final penaltyPoints = memberProvider.getPenaltyPoints(member);
        final totalPoints = rewardPoints - penaltyPoints;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Container(
            color: Color(0xFFFAD89E),
            child: ListTile(
              title: Text(
                member,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Row(
                children: [
                  Text('상점: $rewardPoints'), // 상점
                  const SizedBox(width: 10), // 상점과 벌점 간의 간격
                  Text('벌점: $penaltyPoints'), // 벌점
                ],
              ),
              trailing: Text(
                'Total: $totalPoints',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // 구성원을 누르면 History 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(member: member),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
