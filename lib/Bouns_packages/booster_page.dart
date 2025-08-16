import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizbuz/Bouns_packages/bouns_card/Bouns_attempts.dart';
import 'package:quizbuz/Bouns_packages/bouns_card/Skipper.dart';
import 'package:quizbuz/Bouns_packages/bouns_card/add_timer_container.dart';
import 'package:quizbuz/Bouns_packages/bouns_card/freeze_bites.dart';
import 'package:quizbuz/RiverPod.dart';
import '../Buy coins/buy_coins_main_page.dart';

class BoosterPage extends StatefulWidget {
  const BoosterPage({super.key});

  @override
  State<BoosterPage> createState() => _BoostersPageState();
}

class _BoostersPageState extends State<BoosterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 253, 237, 167),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/backgrounds/main_page_backgound_normal.png"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Booster Packages",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'RubikDoodleTriangles', fontSize: 30),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width - 175),
                    width: 150,
                    height: 35,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          child: const Image(
                            image: AssetImage("assets/backgrounds/coins.png"),
                            width: 45,
                            height: 35,
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final totalCoins = ref.watch(TotalCoins);
                            return Text(
                              totalCoins.toString(),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                        IconButton(
                          alignment: Alignment.center,
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const buy_coins_main_page();
                            }));
                          },
                          icon: const Icon(Icons.add_box),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Add_time_container(),
                      FreezeState(),
                    ],
                  ),
                  Row(
                    children: [
                      Skipper(),
                      BonusAttempts(),
                      // Booster_container(name: "Skipper", option: 2),
                      // Booster_container(name: "Bonus Attempts", option: 3),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: FilledButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.deepOrange)),
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
          ),
        ),
      ),
    );
  }
}
