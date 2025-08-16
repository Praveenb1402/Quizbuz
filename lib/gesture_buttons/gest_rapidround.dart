import 'package:flutter/material.dart';
import 'package:quizbuz/Difficulty_Level_page.dart';

import '../SoundEffect/ClickSounds.dart';

class Gest_rapid_round extends StatefulWidget {
  const Gest_rapid_round({super.key});

  @override
  State<Gest_rapid_round> createState() => _Gest_rapid_roundState();
}

class _Gest_rapid_roundState extends State<Gest_rapid_round> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SoundEffect().playSound();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Rapid_Round_main_page(
                      round_name: "Rapid Round",
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
        width: MediaQuery.of(context).size.width - 100,
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text("Rapid Round",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'RubikDoodleShadow',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Expanded(
                child: Text(
                    "You will be given 30 Seconds in total to answer as much as possible. One wrong answer Game Over",
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
