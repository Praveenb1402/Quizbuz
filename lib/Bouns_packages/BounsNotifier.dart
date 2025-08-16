import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BounsesState {
  final int tryAgain;
  final int addTime;
  final int freezeBite;
  final int skipper;

  BounsesState({
    required this.tryAgain,
    required this.addTime,
    required this.freezeBite,
    required this.skipper,
  });

  BounsesState copyWith({
    int? tryAgain,
    int? addTime,
    int? freezeBite,
    int? skipper,
  }) {
    return BounsesState(
      tryAgain: tryAgain ?? this.tryAgain,
      addTime: addTime ?? this.addTime,
      freezeBite: freezeBite ?? this.freezeBite,
      skipper: skipper ?? this.skipper,
    );
  }
}

class Bounsnotifier extends StateNotifier<BounsesState> {
  Bounsnotifier()
      : super(
            BounsesState(tryAgain: 0, addTime: 0, freezeBite: 0, skipper: 0)) {
    _loadBounses();
  }

  /// Load coins from SharedPreferences
  Future<void> _loadBounses() async {
    final prefs = await SharedPreferences.getInstance();
    state = BounsesState(
        tryAgain: prefs.getInt('tryagainlifeline') ?? 0,
        addTime: prefs.getInt('addtimelifeline') ?? 0,
        freezeBite: prefs.getInt('freezetime') ?? 0,
        skipper: prefs.getInt('skipquestion') ?? 0);
  }

  /// Update coins and save in SharedPreferences
  Future<void> updateTryAgainBonus(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('tryagainlifeline', state.tryAgain + count);
    state = state.copyWith(tryAgain: (state.tryAgain + count));
  }

  Future<void> updateAddTimeBonus(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('addtimelifeline', state.addTime + count);
    state = state.copyWith(addTime: (state.addTime + count));
  }

  Future<void> updateFreezeBite(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('freezetime', state.freezeBite + count);
    state = state.copyWith(freezeBite: (state.freezeBite + count));
  }

  Future<void> updateSkipBonus(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('skipquestion', state.skipper + count);
    state = state.copyWith(skipper: (state.skipper + count));
  }

  Future<void> resetBonus() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('tryagainlifeline', 0);
    prefs.setInt('addtimelifeline', 0);
    prefs.setInt('freezetime', 0);
    prefs.setInt('skipquestion', 0);
    state = state.copyWith(tryAgain: 0, addTime: 0, freezeBite: 0, skipper: 0);
  }
}
