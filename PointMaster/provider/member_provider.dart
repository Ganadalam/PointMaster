import 'package:flutter/material.dart';

class MemberProvider with ChangeNotifier {
  List<String> _members = [];
  Map<String, int> _rewardPoints = {};
  Map<String, int> _penaltyPoints = {};
  Map<String, List<String>> _history = {}; // 구성원별 사유 저장


  List<String> get members => _members;

  int getRewardPoints(String member) => _rewardPoints[member] ?? 0;

  int getPenaltyPoints(String member) => _penaltyPoints[member] ?? 0;

  List<String> getHistory(String member) => _history[member] ?? [];

  void addReward(String member, String reason) {
    _rewardPoints[member] = (_rewardPoints[member] ?? 0) + 1;
    _history[member] = (_history[member] ?? [])..add('상점: $reason');
    notifyListeners();
  }

  void addPenalty(String member, String reason) {
    _penaltyPoints[member] = (_penaltyPoints[member] ?? 0) + 1;
    _history[member] = (_history[member] ?? [])..add('벌점: $reason');
    notifyListeners();
  }

  // 구성원 추가 메서드
  void addMember(String member) {
    if (!_members.contains(member)) {
      _members.add(member);
      notifyListeners();
    }
  }

  // 구성원 제거 메서드
  void removeMember(String member) {
    if (_members.contains(member)) {
      _members.remove(member);
      _rewardPoints.remove(member);
      _penaltyPoints.remove(member);
      _history.remove(member);
      notifyListeners();
    }
  }
}
