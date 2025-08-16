import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quizbuz/Bouns_packages/BounsNotifier.dart';
import 'package:quizbuz/Bouns_packages/booster_page.dart';
import 'package:quizbuz/Buy%20coins/buy_coins_main_page.dart';
import 'package:quizbuz/CoinsHandle.dart';
import 'package:quizbuz/RiverPod.dart';
import 'package:quizbuz/Settings/Setting_page.dart';
import 'package:quizbuz/gesture_buttons/gest_rapidround.dart';
import 'package:quizbuz/servies/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SoundEffect/ClickSounds.dart';
import 'gesture_buttons/gest_quiz.dart';
import 'gesture_buttons/gest_timebuzz.dart';

class Main_Page extends ConsumerStatefulWidget {
  const Main_Page({super.key});

  @override
  ConsumerState<Main_Page> createState() => Main_PageState();
}

class Main_PageState extends ConsumerState<Main_Page> {
  final _page_controller = PageController();
  double _total_coins = 0;
  late BannerAd _bannerAd;
  bool isAdloaded = false;

  initBannerAds() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/9214589741',
        listener: BannerAdListener(onAdLoaded: (ads) {
          setState(() {
            isAdloaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        }),
        request: const AdRequest());
    _bannerAd.load();
    Firestore_Database();
  }

  @override
  void initState() {
    super.initState();
    initBannerAds();
    CoinsNotifier();
    Bounsnotifier();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: FittedBox(
            child: const Text(
              "QuizBuzz",
              style:
                  TextStyle(fontFamily: 'RubikDoodleTriangles', fontSize: 40),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 253, 237, 167),
          centerTitle: true),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/backgrounds/main_page_backgound_normal.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            isAdloaded
                ? SizedBox(
                    height: _bannerAd.size.height.toDouble(),
                    width: _bannerAd.size.width.toDouble(),
                    child: AdWidget(
                      ad: _bannerAd,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: ListView(children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Kids Mode",
                                      style: TextStyle(
                                          fontFamily: 'RubikDoodleShadow',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        SoundEffect().playSound();
                                        Navigator.popAndPushNamed(
                                            context, '/Kids_Main_Page');
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/backgrounds/kids_mode_logo.png'),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.white),
                                    child: IconButton(
                                        onPressed: () async {
                                          SoundEffect().playSound();
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return const Setting_Page();
                                          }));
                                        },
                                        icon: const Icon(Icons.settings))),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              width: 150,
                              height: 35,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),
                                    child: const Image(
                                      image: AssetImage(
                                          "assets/backgrounds/coins.png"),
                                      width: 30,
                                      height: 20,
                                    ),
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final _totalCoins = ref.watch(TotalCoins);
                                      return Text(
                                        _totalCoins.toString(),
                                        textAlign: TextAlign.center,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    alignment: Alignment.center,
                                    color: Colors.grey,
                                    onPressed: () {
                                      SoundEffect().playSound();
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
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 13, bottom: 30),
                        width: 150,
                        height: 35,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: const Icon(
                                Icons.electric_bolt,
                                color: Colors.yellowAccent,
                                size: 20,
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                "Boosters",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            IconButton(
                              alignment: Alignment.center,
                              color: Colors.grey,
                              onPressed: () {
                                SoundEffect().playSound();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BoosterPage()));
                              },
                              icon: const Icon(Icons.add_box),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          const Text("Did You Know",
                              textAlign: TextAlign.center),
                          const Text(
                            "......Did You Know Text......",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 250,
                          child: const Gest_rapid_round(),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 250,
                          child: const Gest_timebuzz(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 250,
                          child: const Gest_quiz(),
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width / 2,
                        //   height: 250,
                        //   child: Gest_coming_soon(),
                        // ),
                      ],
                    ),

                    // Container(
                    //   margin: const EdgeInsets.all(10),
                    //   width: MediaQuery.of(context).size.width - 50,
                    //   height: 250,
                    //   child:

                    // For Time Buzz
                    //
                    // // For Quiz
                    //
                    // //For Coming soon
                    //

                    // ),
                    // SizedBox(
                    //   child: SmoothPageIndicator(
                    //     controller: _page_controller,
                    //     count: 4,
                    //     onDotClicked: (index) {
                    //       _page_controller.animateToPage(
                    //         index,
                    //         duration: const Duration(milliseconds: 200),
                    //         curve: Curves.easeInOut,
                    //       );
                    //     },
                    //     effect: const ExpandingDotsEffect(
                    //         dotHeight: 10, dotWidth: 15, spacing: 15),
                    //   ),
                    // ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getcoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? _totalcoins = prefs.getDouble('coins');
    print(_totalcoins);
    setState(() {
      _total_coins = _totalcoins!;
      if (_total_coins < 0) {
        _total_coins = 0;
      }
    });
  }
}
