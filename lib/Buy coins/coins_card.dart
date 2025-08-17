import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quizbuz/RiverPod.dart';
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

  loadRewardAs(WidgetRef ref) {
    showLoadingDialog(context);
    RewardedAd.load(
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          Navigator.of(context, rootNavigator: true).pop();
          _rewardedAd = ad;
          showAd(ref);
        }, onAdFailedToLoad: (LoadAdError) {
          _rewardedAd = null;
          loadRewardAs(ref);
        }));
  }

  showAd(WidgetRef ref) {
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {},
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError) {
          ad.dispose();
          loadRewardAs(ref);
        });
    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
      final totalCoins = ref.watch(TotalCoins);
      ref.read(TotalCoins.notifier).updateCoins(totalCoins + 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.index == 0
        ? Consumer(builder: (context, ref, child) {
            return GestureDetector(
              onTap: () {
                loadRewardAs(ref);
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
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
                            loadRewardAs(ref);
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
            );
          })
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
                  child: FittedBox(
                    child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF57952),
                          // Background color
                        ),
                        onPressed: () {
                          showBottomSheetToast(context);
                        },
                        child: Row(
                          spacing: 2,
                          children: [
                            const Text(
                              "Buy",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.lock)
                          ],
                        )),
                  ),
                )
              ],
            ),
          );
  }

  void showLoadingDialog(BuildContext context,
      {String message = "Loading..."}) {
    showDialog(
      context: context,
      barrierDismissible: false, // user cannot close by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetToast(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar(); // dismiss old one before showing new
    messenger.showSnackBar(
      SnackBar(
        content: Text("Coming Soon"),
        duration: Duration(seconds: 3),
        // how long it shows
        behavior: SnackBarBehavior.floating,
        // makes it float like a toast
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        // adjust position
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
