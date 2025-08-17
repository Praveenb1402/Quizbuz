import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundEffectState {
  final bool isClickSound;
  final bool isBackgroundSound;
  final bool isAllMute;

  SoundEffectState({
    required this.isClickSound,
    required this.isBackgroundSound,
    required this.isAllMute,
  });

  SoundEffectState copyWith(
      {bool? isClickSound, bool? isBackgroundSound, bool? isAllMute}) {
    return SoundEffectState(
        isClickSound: isClickSound ?? this.isClickSound,
        isBackgroundSound: isBackgroundSound ?? this.isBackgroundSound,
        isAllMute: isAllMute ?? this.isAllMute);
  }
}

class SoundStateNotifier extends StateNotifier<SoundEffectState> {
  SoundStateNotifier()
      : super(SoundEffectState(
            isClickSound: true, isBackgroundSound: true, isAllMute: true)) {
    _loadSoundState();
  }

  Future<void> _loadSoundState() async {
    final prefs = await SharedPreferences.getInstance();

    state = SoundEffectState(
        isClickSound: prefs.getBool('isclickSound') ?? true,
        isBackgroundSound: prefs.getBool('backgroundSound') ?? true,
        isAllMute: prefs.getBool('allmute') ?? false);
  }

  Future<bool> isClickSoundAllowed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isclickSound') ?? true;
  }

  Future<void> setClickedSoundAllowed(bool getValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isclickSound', getValue);
    state = state.copyWith(isClickSound: getValue);
  }

  Future<bool> isBackgroundSoundAllowed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('backgroundSound') ?? true;
  }

  Future<void> setBackgroundSoundAllowed(bool getValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('backgroundSound', getValue);
    state = state.copyWith(isBackgroundSound: getValue);
  }

  Future<bool> isAllMuted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('allmute') ?? false;
  }

  Future<void> setAllMute(bool getValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('allmute', getValue);
    prefs.setBool('backgroundSound', !getValue);
    prefs.setBool('isclickSound', !getValue);
    state = state.copyWith(
        isAllMute: getValue,
        isClickSound: !getValue,
        isBackgroundSound: !getValue);
  }
}
