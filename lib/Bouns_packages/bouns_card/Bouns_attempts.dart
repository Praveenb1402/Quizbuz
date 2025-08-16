import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizbuz/RiverPod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NoCoinsDialogBox.dart';

class BonusAttempts extends StatefulWidget {
  int owned; // make immutable

  BonusAttempts({super.key, required this.owned});

  @override
  State<BonusAttempts> createState() => _BonusAttemptsState();
}

class _BonusAttemptsState extends State<BonusAttempts> {
  late TextEditingController _bonusController;
  late int _owned;

  @override
  void initState() {
    super.initState();
    _bonusController = TextEditingController(text: "1");
    _owned = widget.owned;
  }

  @override
  void dispose() {
    _bonusController.dispose();
    super.dispose();
  }

  Future<void> _loadOwned() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _owned = prefs.getInt('tryagainlifeline') ?? widget.owned;
    });
  }

  void _buyBonus() {
    try {} catch (e) {
      print("Error: $e");
    }
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
          Text("Total Owned: " + widget.owned.toString()),
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
                  late SharedPreferences prefs;
                  prefs = await SharedPreferences.getInstance();
                  setState(() {
                    final _totalCoins = ref.watch(TotalCoins);
                    int ownedItemCount = prefs.getInt('tryagainlifeline') ?? 0;
                    int buyCount = int.tryParse(_bonusController.text) ?? 0;
                    if (_totalCoins >= (buyCount * 10)) {
                      int newOwned = ownedItemCount + buyCount;
                      int newCoins = _totalCoins - (buyCount * 10);
                      prefs.setInt("tryagainlifeline", newOwned);
                      ref
                          .read(TotalCoins.notifier)
                          .updateCoins(_totalCoins - buyCount * 10);
                      widget.owned = newOwned;

                      print("Bonus purchased ✅");
                    } else {
                      NoCoinsDialogBox().showNoCoinsDialogBox(context);
                      print("Not enough coins ❌");
                    }
                  });
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
}
