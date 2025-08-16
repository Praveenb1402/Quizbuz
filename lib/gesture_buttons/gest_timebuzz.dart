import 'package:flutter/material.dart';
import 'package:quizbuz/Difficulty_Level_page.dart';
import 'package:quizbuz/SoundEffect/ClickSounds.dart';

class Gest_timebuzz extends StatefulWidget {
  const Gest_timebuzz({super.key});

  @override
  State<Gest_timebuzz> createState() => _Gest_timebuzzState();
}

class _Gest_timebuzzState extends State<Gest_timebuzz> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SoundEffect().playSound();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Rapid_Round_main_page(
                      round_name: "Time Buzz",
                    )));
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.lightBlue,
            // image: DecorationImage(
            //     image: AssetImage("assets/backgrounds/rapid_background.png"),
            //     fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 40,
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text("Time Buzz",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'RubikDoodleShadow',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Expanded(
                child: Text(
                    "You will get 30 seconds at start, correct answer will give +2"
                    " seconds and wrong answer will deduct -1 seconds. For wrong answer -0.5. When timer hits 0, Game Over."
                        "Play smartly, points can go into negative.",
                    textAlign: TextAlign.center,
                    
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
