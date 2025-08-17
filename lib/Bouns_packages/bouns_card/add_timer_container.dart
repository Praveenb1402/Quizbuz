import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizbuz/NoCoinsDialogBox.dart';
import 'package:quizbuz/RiverPod.dart';
import 'package:quizbuz/SoundEffect/ClickSounds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_time_container extends ConsumerStatefulWidget {
  Add_time_container({super.key});

  @override
  ConsumerState<Add_time_container> createState() => _Add_time_containerState();
}

class _Add_time_containerState extends ConsumerState<Add_time_container> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _bonus_controller = TextEditingController(text: "1");
    return Container(
      margin: EdgeInsets.only(top: 30, left: 10),
      padding: EdgeInsets.all(10),
      width: (MediaQuery.of(context).size.width / 2) - 15,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Time Adder"),
          Consumer(builder: (context, ref, child) {
            final _bonusCount = ref.watch(BonusRiverpod).addTime;
            return Text(
              "Total Owned: $_bonusCount",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            );
          }),
          Text(
            "This add 10 more seconds to the timer. ",
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
                  icon: Icon(Icons.exposure_minus_1)),
              Container(
                width: 55,
                height: 70,
                child: TextFormField(
                  controller: _bonus_controller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
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
                  icon: Icon(Icons.exposure_plus_1)),
            ],
          ),
          FilledButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.deepOrange)),
              onPressed: () {
                updateCoins(_bonus_controller.text);
              },
              child: const Text(
                "Add",
                style: TextStyle(
                    fontFamily: 'RubikDoodleShadow',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ],
      ),
    );
  }

  void updateCoins(String _bonus_controller) {
    int _totalcoins = ref.watch(TotalCoins);
    int _buycount = int.parse(_bonus_controller);
    if (_totalcoins >= (_buycount * 5)) {
      ref.read(TotalCoins.notifier).updateCoins(_totalcoins - _buycount * 5);
      ref.read(BonusRiverpod.notifier).updateAddTimeBonus(_buycount);
      if (ref.watch(SoundEffectRiverPod).isClickSound)
        SoundEffect().bonusBoughtSound();
    } else {
      NoCoinsDialogBox().showNoCoinsDialogBox(context);
    }
  }
}
