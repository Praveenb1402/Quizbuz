import 'package:flutter/material.dart';

class Gest_coming_soon extends StatefulWidget {
  const Gest_coming_soon({super.key});

  @override
  State<Gest_coming_soon> createState() => _Gest_coming_soonState();
}

class _Gest_coming_soonState extends State<Gest_coming_soon> {
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.lightBlue,
          // image: DecorationImage(
          //     image: AssetImage("assets/backgrounds/rapid_background.png"),
          //     fit: BoxFit.cover),
        ),
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 40,
        height: 120,
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Coming Soon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'RubikDoodleShadow',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text("Stay Tuned for more Updates",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
