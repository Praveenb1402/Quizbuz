import 'package:flutter/material.dart';
class Gesture_Who_am_i_ extends StatefulWidget {
  const Gesture_Who_am_i_({super.key});

  @override
  State<Gesture_Who_am_i_> createState() => _Gesture_Who_am_i_State();
}

class _Gesture_Who_am_i_State extends State<Gesture_Who_am_i_> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //         const Rapid_Round_main_page()));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 40,
        child: const Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text("Who Am I ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'RubikDoodleShadow',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo)),
                Text(
                  "Details of the Round with some extras.",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

