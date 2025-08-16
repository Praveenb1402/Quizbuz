import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsNotifier extends StateNotifier<int> {
  CoinsNotifier() : super(0) {
    _loadCoins();
  }

  /// Load coins from SharedPreferences
  Future<void> _loadCoins() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt('coins') ?? 0;
  }

  /// Update coins and save in SharedPreferences
  Future<void> updateCoins(int newCoins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('coins', newCoins);
    state = newCoins;
  }

  /// Add coins
  Future<void> addCoins(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final updated = state + amount;
    await prefs.setInt('coins', updated);
    state = updated;
  }

  /// Reset coins
  Future<void> resetCoins() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('coins', 0);
    state = 0;
  }

}
