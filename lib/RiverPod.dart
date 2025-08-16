import 'package:quizbuz/Bouns_packages/BounsNotifier.dart';
import 'package:quizbuz/CoinsHandle.dart';
import 'package:riverpod/riverpod.dart';

final TotalCoins = StateNotifierProvider<CoinsNotifier, int>((ref) {
  return CoinsNotifier();
});

final BonusRiverpod = StateNotifierProvider<Bounsnotifier, BounsesState>((ref) {
  return Bounsnotifier();
});
