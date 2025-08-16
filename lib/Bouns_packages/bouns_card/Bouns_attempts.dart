import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizbuz/RiverPod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NoCoinsDialogBox.dart';

class BonusAttempts extends StatefulWidget {
  BonusAttempts({super.key});

  @override
  State<BonusAttempts> createState() => _BonusAttemptsState();
}

class _BonusAttemptsState extends State<BonusAttempts> {
  late TextEditingController _bonusController;

  @override
  void initState() {
    super.initState();
    _bonusController = TextEditingController(text: "1");
  }

  @override
  void dispose() {
    _bonusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 10),
      padding: const EdgeInsets.all(10),
      width: (MediaQuery.of(context).size.width / 2) - 15,
      height: 300,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Flexible(child: Text("Bonus Attempts")),
          Consumer(builder: (context, ref, child) {
            final bonusCount = ref.watch(BonusRiverpod).tryAgain;
            return Text("Total Owned: $bonusCount");
          }),
          const Expanded(
            child: Text(
              "Answer again to the same question",
              textAlign: TextAlign.center,
            ),
          ),
          const Text("Cost: 10 Coins"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  int current = int.tryParse(_bonusController.text) ?? 0;
                  if (current > 0) {
                    _bonusController.text = (current - 1).toString();
                  }
                },
                icon: const Icon(Icons.exposure_minus_1),
              ),
              SizedBox(
                width: 55,
                height: 70,
                child: TextFormField(
                  controller: _bonusController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  int current = int.tryParse(_bonusController.text) ?? 0;
                  _bonusController.text = (current + 1).toString();
                },
                icon: const Icon(Icons.exposure_plus_1),
              ),
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              return FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.deepOrange),
                ),
                onPressed: () async {
                  updateCoins(ref);
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: 'RubikDoodleShadow',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void updateCoins(WidgetRef ref) async {
    final _totalCoins = ref.watch(TotalCoins);
    int buyCount = int.tryParse(_bonusController.text) ?? 0;
    if (_totalCoins >= (buyCount * 10)) {
      ref.read(TotalCoins.notifier).updateCoins(_totalCoins - buyCount * 10);
      ref.read(BonusRiverpod.notifier).updateTryAgainBonus(buyCount);
    } else {
      NoCoinsDialogBox().showNoCoinsDialogBox(context);
    }
  }
}
