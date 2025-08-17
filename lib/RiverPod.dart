import 'package:quizbuz/Bouns_packages/BounsNotifier.dart';
import 'package:quizbuz/CoinsHandle.dart';
import 'package:quizbuz/SoundEffect/SoundEffectNotifier.dart';
import 'package:riverpod/riverpod.dart';

final TotalCoins = StateNotifierProvider<CoinsNotifier, int>((ref) {
  return CoinsNotifier();
});

final BonusRiverpod = StateNotifierProvider<Bounsnotifier, BounsesState>((ref) {
  return Bounsnotifier();
});

final SoundEffectRiverPod =
    StateNotifierProvider<SoundStateNotifier, SoundEffectState>((ref) {
  return SoundStateNotifier();
});

final didYouKnowProvider = StateProvider<List<dynamic>>((ref) => []);
final didYouKnowFact = StateProvider<String>((ref) => "");
