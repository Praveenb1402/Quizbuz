import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NoCoinsDialogBox.dart';

class Skipper extends StatefulWidget {
  int owned;

  Skipper({super.key, required this.owned});

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
          Text("Total Owned: " + widget.owned.toString()),
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
          FilledButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrange)),
              onPressed: () async {
                late SharedPreferences prefs;
                prefs = await SharedPreferences.getInstance();

                setState(() {
                  double? _totalcoins = prefs.getDouble('coins');
                  int _owneditemcount = int.parse(widget.owned.toString());
                  int _buycount = int.parse(_bonus_controller.text);
                  if (_totalcoins! >= (_buycount * 10)) {
                    prefs.setDouble(
                        "coins", _totalcoins - (_buycount) * 10.0);
                    prefs.setInt(
                        'skipquestion',
                        int.parse(_bonus_controller.text) +
                            int.parse(widget.owned.toString()));
                    widget.owned = prefs.getInt('skipquestion')!;
                  } else {
                    NoCoinsDialogBox().showNoCoinsDialogBox(context);

                  }
                });
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
}
