import 'package:flutter/material.dart';
import 'package:quizbuz/Buy%20coins/buy_coins_main_page.dart';

class NoCoinsDialogBox {
  Future<void> showNoCoinsDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(contexts);
              // Navigator.popUntil(context, ModalRoute.withName('/Main_Page'));
              // Navigator.popAndPushNamed(context, '/Main_Page');

              return true;
            },
            child: AlertDialog(
              title: const Text("No Coins"),
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You have no coins to buy."),
                    Text("Earn more coins are buy coins."),
                    Column(
                      spacing: 10,
                      children: [
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange)),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contexts) =>
                                          const buy_coins_main_page()));
                            },
                            child: const Text(
                              "Buy Coins",
                              style: TextStyle(
                                  fontFamily: 'RubikDoodleShadow',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                  fontFamily: 'RubikDoodleShadow',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
