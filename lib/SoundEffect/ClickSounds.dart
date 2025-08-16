import 'package:just_audio/just_audio.dart';

class SoundEffect {
  static final player = AudioPlayer();

  void loadClickSound() async {
    player.setAudioSource(AudioSource.asset("assets/sounds/click_1.mp3"));
  }

  void playSound() {
    player.seek(Duration.zero);
    player.play();
  }

  void loadtimerSound() async {
    player.setAudioSource(AudioSource.asset("assets/sounds/time1.mp3"));
    player.seek(Duration.zero);
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  void cancelTimerSound() async {
    if (player.playing) {
      player.stop();
    }
  }
}
