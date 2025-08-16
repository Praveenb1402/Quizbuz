import 'package:flutter/material.dart';

import '../Difficulty_Level_page.dart';
import '../SoundEffect/ClickSounds.dart';

class Gest_quiz extends StatefulWidget {
  const Gest_quiz({super.key});

  @override
  State<Gest_quiz> createState() => _Gest_quizState();
}

class _Gest_quizState extends State<Gest_quiz> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SoundEffect().playSound();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Rapid_Round_main_page(
                      round_name: "Quiz",
                    )));
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.lightBlue,
          // image: DecorationImage(
          //     image: AssetImage("assets/backgrounds/rapid_background.png"),
          //     fit: BoxFit.cover),
        ),
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 40,
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text("Quiz",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'RubikDoodleShadow',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Expanded(
                child: Text(
                    "Normal Quiz Game where you will get 15 seconds to answer each question. One wrong answer Game Over",
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
