import 'package:quizbuz/CoinsHandle.dart';
import 'package:riverpod/riverpod.dart';

final TotalCoins = StateNotifierProvider<CoinsNotifier, int>((ref) {
  return CoinsNotifier();
});



