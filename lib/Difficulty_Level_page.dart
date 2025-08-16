import 'package:flutter/material.dart';
import 'package:quizbuz/question_page.dart';

class Rapid_Round_main_page extends StatefulWidget {
  final round_name;

  const Rapid_Round_main_page({super.key, required this.round_name});

  @override
  State<Rapid_Round_main_page> createState() => _Rapid_Round_main_pageState();
}

class _Rapid_Round_main_pageState extends State<Rapid_Round_main_page> {
  @override
  Widget build(BuildContext context) {
    String? _round_name = widget.round_name;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 170, 220, 220),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("assets/backgrounds/main_page_backgound_normal.png"),
                  fit: BoxFit.cover),
            ),
            height: 250,
            child: Center(
              child: Text(
                "$_round_name",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'RubikDoodleShadow',
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                top: 180, bottom: 100, left: 20, right: 20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                const Text(
                  "Difficulty\n Level",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'RubikDoodleShadow',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(height: 30,),
                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Question_Page(mode: "easy", round_name: _round_name.toString())));
                    },
                    child: const Text(
                      "Easy",
                      style: TextStyle(
                          fontFamily: 'RubikDoodleShadow',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                SizedBox(height: 10,),
                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Question_Page(mode: "medium", round_name: _round_name.toString())));
                    },
                    child: const Text(
                      "Medium",
                      style: TextStyle(
                          fontFamily: 'RubikDoodleShadow',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                SizedBox(height: 10,),
                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Question_Page(mode: "hard", round_name: _round_name.toString())));
                    },
                    child: const Text(
                      "Hard",
                      style: TextStyle(
                          fontFamily: 'RubikDoodleShadow',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                SizedBox(height: 60,),
                Container(

                  child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepOrange)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                            fontFamily: 'RubikDoodleShadow',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
