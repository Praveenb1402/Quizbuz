import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizbuz/RiverPod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NoCoinsDialogBox.dart';

class Skipper extends StatefulWidget {
  Skipper({super.key});

  @override
  State<Skipper> createState() => _SkipperState();
}

class _SkipperState extends State<Skipper> {
  TextEditingController _bonus_controller = TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 10),
      padding: const EdgeInsets.all(10),
      width: (MediaQuery.of(context).size.width / 2) - 15,
      height: 300,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Skipper"),
          Consumer(builder: (context, ref, child) {
            final _bonusCount = ref.watch(BonusRiverpod).skipper;
            return Text("Total Owned: $_bonusCount");
          }),
          const Text(
            "It skips the question to the next one",
            textAlign: TextAlign.center,
          ),
          Text(
            "Cost: 5 Coins",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    if (int.parse(_bonus_controller.text) > 0) {
                      _bonus_controller.text =
                          (int.parse(_bonus_controller.text) - 1).toString();
                    }
                  },
                  icon: const Icon(Icons.exposure_minus_1)),
              Container(
                width: 55,
                height: 70,
                child: TextFormField(
                  controller: _bonus_controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.solid))),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _bonus_controller.text =
                        (int.parse(_bonus_controller.text) + 1).toString();
                  },
                  icon: const Icon(Icons.exposure_plus_1)),
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              return FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange)),
                  onPressed: () {
                    updateCoins(ref);
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                        fontFamily: 'RubikDoodleShadow',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ));
            },
          ),
        ],
      ),
    );
  }

  void updateCoins(WidgetRef ref) async {
    final _totalCoins = ref.watch(TotalCoins);
    int _buycount = int.parse(_bonus_controller.text);
    if (_totalCoins >= (_buycount * 10)) {
      ref.read(TotalCoins.notifier).updateCoins(_totalCoins - _buycount * 10);
      ref.read(BonusRiverpod.notifier).updateSkipBonus(_buycount);
    } else {
      NoCoinsDialogBox().showNoCoinsDialogBox(context);
    }
  }
}
