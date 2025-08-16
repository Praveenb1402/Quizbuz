import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Coins_card extends StatefulWidget {
  final index;

  const Coins_card({this.index, super.key});

  @override
  State<Coins_card> createState() => _Coins_cardState();
}

class _Coins_cardState extends State<Coins_card> {
  final _coins = ["", "10", "20", "50", "100", "150", "200", "300", "500"];
  final _amount = ["", "9", "19", "49", "99", "139", "159", "249", "449"];

  RewardedAd? _rewardedAd;

  loadRewardAs() {
    RewardedAd.load(
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError) {
          _rewardedAd = null;
        }));
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {},
          onAdDismissedFullScreenContent: (RewardedAd ad) {
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError) {
            ad.dispose();
            loadRewardAs();
          });
      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
        late SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();
        double totalcoins = prefs.getDouble('coins')!;
        setState(() {
          prefs.setDouble('coins', totalcoins + 3);
          print("updated");
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.index == 0
        ? GestureDetector(
            onTap: () {
              loadRewardAs();
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 120,
              child: Stack(
                children: [
                  Row(
                    children: [
                      const Image(
                        image: AssetImage("assets/backgrounds/coins.png"),
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Watch Ads\n to get Coins",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          FittedBox(
                            child: Text(
                              "3 coin from\n watching one ad",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ////////

                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF57952),
                          // Background color
                        ),
                        onPressed: () {
                          loadRewardAs();
                        },
                        child: const Text(
                          "Watch Ads",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          )
        : Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: Stack(
              children: [
                Row(
                  children: [
                    const Image(
                      image: AssetImage("assets/backgrounds/coins.png"),
                      fit: BoxFit.fill,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _coins[widget.index] + " Coins",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "₹ " + _amount[widget.index],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),


                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF57952),
                        // Background color
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Buy",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          );
  }
}
