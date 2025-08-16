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
}
