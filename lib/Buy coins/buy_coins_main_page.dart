import 'package:flutter/material.dart';

import 'coins_card.dart';

class buy_coins_main_page extends StatefulWidget {
  const buy_coins_main_page({super.key});

  @override
  State<buy_coins_main_page> createState() => _buy_coins_main_pageState();
}

class _buy_coins_main_pageState extends State<buy_coins_main_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const FittedBox(
            child: Text(
              "Coins Packs",
              style:
              TextStyle(fontFamily: 'RubikDoodleTriangles', fontSize: 65),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 253, 237, 167),
          centerTitle: true),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgrounds/main_page_backgound_normal.png"),
                fit: BoxFit.cover),
          ),
          width: MediaQuery
              .of(context)
              .size
              .width ,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Coins_card(index: index);
            },
          ),
        ),
    );
  }
}
