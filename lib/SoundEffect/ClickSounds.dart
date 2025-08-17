import 'package:just_audio/just_audio.dart';
import 'package:quizbuz/SoundEffect/SoundEffectNotifier.dart';

class SoundEffect {
  static final player = AudioPlayer();
  static final playerTime = AudioPlayer();
  static final playerBonus = AudioPlayer();

  void loadClickSound() async {
    if (await SoundStateNotifier().isClickSoundAllowed()) {
      player.setAudioSource(AudioSource.asset("assets/sounds/click_1.mp3"));
      playerBonus
          .setAudioSource(AudioSource.asset("assets/sounds/collect.mp3"));
    }
  }

  Future<void> playSound() async {
    if (await SoundStateNotifier().isClickSoundAllowed()) {
      player.seek(Duration.zero);
      player.play();
    }
  }

  void loadtimerSound() async {
    if (await SoundStateNotifier().isClickSoundAllowed()) {
      playerTime.setAudioSource(AudioSource.asset("assets/sounds/time1.mp3"));
      playerTime.seek(Duration.zero);
      playerTime.setLoopMode(LoopMode.one);
      playerTime.play();
    }
  }

  void pauseTimerSound() async {
    if (playerTime.processingState == ProcessingState.ready &&
        !playerTime.playing) {
      playerTime.pause();
    }
  }

  void cancelTimerSound() async {
    if (playerTime.playing) {
      playerTime.stop();
    }
  }

  void correctAnswerSound() async {
    if (await SoundStateNotifier().isClickSoundAllowed()) {
      final player = AudioPlayer();
      player.setAudioSource(
          AudioSource.asset("assets/sounds/correctAnswer1.mp3"));
      player.seek(Duration.zero);
      player.play();
    }
  }

  void incorrectAcnswerSound() async {
    if (await SoundStateNotifier().isClickSoundAllowed()) {
      final player = AudioPlayer();
      player.setAudioSource(AudioSource.asset("assets/sounds/incorrect1.mp3"));
      player.seek(Duration.zero);
      player.play();
    }
  }

  void bonusBoughtSound() async {
    if (await SoundStateNotifier().isClickSoundAllowed()) {
      playerBonus.seek(Duration.zero);
      playerBonus.play();
    }
  }
}
