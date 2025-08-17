import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizbuz/SoundEffect/ClickSounds.dart';
import '../../NoCoinsDialogBox.dart';
import '../../RiverPod.dart';

class FreezeState extends StatefulWidget {
  FreezeState({super.key});

  @override
  State<FreezeState> createState() => _FreezeStateState();
}

class _FreezeStateState extends State<FreezeState> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _bonus_controller = TextEditingController(text: "1");
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
          const Text("Freeze Bites"),
          Consumer(builder: (context, ref, child) {
            int _bonusCount = ref.watch(BonusRiverpod).freezeBite;
            print(ref.watch(BonusRiverpod).freezeBite);
            return Text("Total Owned: $_bonusCount ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
          }),
          const Text(
            "It Freezes the timer for 5 seconds",
            textAlign: TextAlign.center,
          ),
          Text(
            "Cost: 10 Coins",
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
                          WidgetStateProperty.all(Colors.deepOrange)),
                  onPressed: () {
                    updateCoins(ref, _bonus_controller.text);
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

  void updateCoins(WidgetRef ref, String _bonus_controller) async {
    final _totalCoins = ref.watch(TotalCoins);
    int _buycount = int.parse(_bonus_controller);
    if (_totalCoins >= (_buycount * 10)) {
      ref.read(TotalCoins.notifier).updateCoins(_totalCoins - _buycount * 10);
      ref.read(BonusRiverpod.notifier).updateFreezeBite(_buycount);
      SoundEffect().bonusBoughtSound();
    } else {
      NoCoinsDialogBox().showNoCoinsDialogBox(context);
    }
  }
}
