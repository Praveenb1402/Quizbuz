import 'dart:async';
import 'dart:convert';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizbuz/SoundEffect/ClickSounds.dart';
import 'package:quizbuz/menu_page.dart';
import 'package:quizbuz/servies/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question_Page extends StatefulWidget {
  final mode;
  final round_name;

  const Question_Page(
      {super.key, required this.mode, required this.round_name});

  @override
  State<Question_Page> createState() => _Question_PageState();
}

class _Question_PageState extends State<Question_Page>
    with TickerProviderStateMixin {
  int _countdown = 60;
  int _freezetime = 5;
  int _points = 0;
  late SharedPreferences prefs;
  double _btn_margin1 = 0;
  double _btn_margin2 = 0;
  double _btn_margin3 = 0;

  bool _disable_btn = false;
  List questions_items = [];
  late Timer _timer;
  late Timer _freezetimer;
  late int _try_again_lifeline;
  int _addtime_lifeline = 0;
  int _skip_quesion_lifeline = 0;
  int _freeze_time_lifeline = 0;
  late Timer _timerchanger;
  int _question_index = 0;
  int? _max_question;
  List<int> uniqueNumbers = [];

  Color _btn1_bg_color = Colors.blue;
  Color _btn2_bg_color = Colors.blue;
  Color _btn3_bg_color = Colors.blue;
  Color _btn4_bg_color = Colors.blue;
  Color _timer_background_color = Colors.greenAccent;
  bool _lines_visible = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  void checkAnswerD(String _round_name) {
    if (questions_items[uniqueNumbers[_question_index]]["D"].toString() ==
        questions_items[uniqueNumbers[_question_index]]["Ans"]) {
      _btn4_bg_color = Colors.green;
      _timerchanger =
          Timer.periodic(const Duration(milliseconds: 500), (timer) {
        setState(() {
          _points = _points + 1;
          if (_question_index == (_max_question! - 1)) {
            _Game_finsih_Dialogbox(context);
            _timerchanger.cancel();
          } else {
            _question_index++;
            _btn4_bg_color = Colors.blue;
            _timerchanger.cancel();
            _disable_btn = false;
            if (_round_name == "Time Buzz") {
              _points = _points + 1;
              _countdown = _countdown + 3;
            }
            if (_round_name == "Quiz") {
              _countdown = 30;
            }
          }
          // _timer.cancel();
        });
      });
    } else {
      if (_round_name == "Time Buzz") {
        _btn4_bg_color = Colors.red;
        _timerchanger =
            Timer.periodic(const Duration(milliseconds: 500), (timer) {
          setState(() {
            _points = _points - 1;
            if (_question_index == (_max_question! - 1)) {
              _Game_finsih_Dialogbox(context);
              _timerchanger.cancel();
            } else {
              _question_index++;
              _btn4_bg_color = Colors.blue;
              _timerchanger.cancel();
              _disable_btn = false;
              _countdown = _countdown - 1;
              // _timer.cancel();
            }
          });
        });
      } else {
        _btn4_bg_color = Colors.red;
        _timer.cancel();

        if (_try_again_lifeline != 0) {
          _Try_AgainDialogBox(context);
        } else {
          _Game_finsih_Dialogbox(context);
        }
        // _Game_finsih_Dialogbox(context);
      }
    }
  }

  void checkAnswerB(String _round_name) {
    if (questions_items[uniqueNumbers[_question_index]]["B"].toString() ==
        questions_items[uniqueNumbers[_question_index]]["Ans"]) {
      _btn2_bg_color = Colors.green;
      _timerchanger =
          Timer.periodic(const Duration(milliseconds: 500), (timer) {
        setState(() {
          _points = _points + 1;
          if (_question_index == (_max_question! - 1)) {
            _Game_finsih_Dialogbox(context);
            _timerchanger.cancel();
          } else {
            _question_index++;
            _btn2_bg_color = Colors.blue;
            _timerchanger.cancel();
            _disable_btn = false;
            if (_round_name == "Time Buzz") {
              _points = _points + 1;
              _countdown = _countdown + 3;
            }
            if (_round_name == "Quiz") {
              _countdown = 30;
            }
          }
          // _timer.cancel();
        });
      });
    } else {
      if (_round_name == "Time Buzz") {
        _btn2_bg_color = Colors.red;
        _timerchanger =
            Timer.periodic(const Duration(milliseconds: 500), (timer) {
          setState(() {
            _points = _points - 1;
            if (_question_index == (_max_question! - 1)) {
              _Game_finsih_Dialogbox(context);
              _timerchanger.cancel();
            } else {
              _question_index++;
              _btn2_bg_color = Colors.blue;
              _timerchanger.cancel();
              _disable_btn = false;
              _countdown = _countdown - 1;
              // _timer.cancel();
            }
          });
        });
      } else {
        _btn2_bg_color = Colors.red;
        _timer.cancel();
        if (_try_again_lifeline != 0) {
          _Try_AgainDialogBox(context);
        } else {
          _Game_finsih_Dialogbox(context);
        }
      }
    }
  }

  void checkAnswerc(String _round_name) {
    if (questions_items[uniqueNumbers[_question_index]]["C"].toString() ==
        questions_items[uniqueNumbers[_question_index]]["Ans"]) {
      _btn3_bg_color = Colors.green;
      _timerchanger =
          Timer.periodic(const Duration(milliseconds: 500), (timer) {
        setState(() {
          _points = _points + 1;
          if (_question_index == (_max_question! - 1)) {
            _Game_finsih_Dialogbox(context);
            _timerchanger.cancel();
          } else {
            _question_index++;
            _btn3_bg_color = Colors.blue;
            _timerchanger.cancel();
            _disable_btn = false;
            if (_round_name == "Time Buzz") {
              _points = _points + 1;
              _countdown = _countdown + 3;
            }
            if (_round_name == "Quiz") {
              _countdown = 30;
            }
          }
          // _timer.cancel();
        });
      });
    } else {
      if (_round_name == "Time Buzz") {
        _btn3_bg_color = Colors.red;
        _timerchanger =
            Timer.periodic(const Duration(milliseconds: 500), (timer) {
          setState(() {
            _points = _points - 1;
            if (_question_index == (_max_question! - 1)) {
              _Game_finsih_Dialogbox(context);
              _timerchanger.cancel();
            } else {
              _question_index++;
              _btn3_bg_color = Colors.blue;
              _timerchanger.cancel();
              _disable_btn = false;
              _countdown = _countdown - 1;
              // _timer.cancel();
            }
          });
        });
      } else {
        _btn3_bg_color = Colors.red;
        _timer.cancel();
        if (_try_again_lifeline != 0) {
          _Try_AgainDialogBox(context);
        } else {
          _Game_finsih_Dialogbox(context);
        }
      }
    }
  }

  void checkAnswerA(String _round_name) {
    setState(() {
      if (questions_items[uniqueNumbers[_question_index]]["A"] ==
          questions_items[uniqueNumbers[_question_index]]["Ans"]) {
        _btn1_bg_color = Colors.green;
        _points = _points + 1;
        _timerchanger =
            Timer.periodic(const Duration(milliseconds: 500), (timer) {
          setState(() {
            if (_question_index == (_max_question! - 1)) {
              _Game_finsih_Dialogbox(context);
              _timerchanger.cancel();
            } else {
              _question_index++;
              _btn1_bg_color = Colors.blue;
              _timerchanger.cancel();
              _disable_btn = false;
              if (_round_name == "Time Buzz") {
                _countdown = _countdown + 3;
              }
              if (_round_name == "Quiz") {
                _countdown = 30;
              }
            }
            // _timer.cancel();
          });
        });
      } else {
        if (_round_name == "Time Buzz") {
          _btn1_bg_color = Colors.red;
          _timerchanger =
              Timer.periodic(const Duration(milliseconds: 500), (timer) {
            setState(() {
              _points = _points - 1;
              if (_question_index == (_max_question! - 1)) {
                _Game_finsih_Dialogbox(context);
                _timerchanger.cancel();
              } else {
                _question_index++;
                _btn1_bg_color = Colors.blue;
                _timerchanger.cancel();
                _disable_btn = false;
                _countdown = _countdown - 1;
                // _timer.cancel();
              }
            });
          });
        } else {
          _btn1_bg_color = Colors.red;
          _timer.cancel();
          if (_try_again_lifeline != 0) {
            _Try_AgainDialogBox(context);
          } else {
            _Game_finsih_Dialogbox(context);
          }
        }
      }
    });
  }

  void startTimer() {
    SoundEffect().loadtimerSound();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // Timer will be canceled once it reached 0
          _timer.cancel();
          SoundEffect().cancelTimerSound();
          _Game_finsih_Dialogbox(context);
        }
        if (_countdown <= 10) {
          _timer_background_color = Colors.redAccent;
        }
      });
    });
  }

  void generateUniqueRandomNumbers(int n) {
    Set<int> numbersSet = Set<int>();

    while (numbersSet.length < n) {
      numbersSet.add(Random().nextInt(n));

      // Generate a random number between 0 and 100
    }
    setState(() {
      uniqueNumbers = numbersSet.toList(); // Convert set to list
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SoundEffect().cancelTimerSound();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    Firestore_Database questionclass = Firestore_Database();
    questionclass.getquestion(widget.mode);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    setState(() {
      getQuestions();
      if (widget.mode == "Quiz") {
        _countdown = 30;
      }
      if (widget.mode == "Time Buzz") {
        _countdown = 50;
      }
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      if (questions_items.isNotEmpty) {
        _showchoiceDialog(context);
      } else {
        // print("object");
        // Center(child: const CircularProgressIndicator());
      }
    });
  }

  _toggleContainer() {
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
      setState(() {
        _disable_btn = true;
        // _timer.cancel();
      });
    } else {
      _controller.animateBack(0, duration: const Duration(seconds: 1));
      setState(() {
        _disable_btn = false;
        // startTimer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String _round_name = widget.round_name;
    return Scaffold(
        body: questions_items.isNotEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/backgrounds/question_page.png'),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            '$_round_name',
                            style: TextStyle(
                                fontFamily: 'RubikDoodleTriangles',
                                fontSize: 50,
                                color: Colors.white),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_skip_quesion_lifeline != 0 &&
                                        _freeze_time_lifeline != 0 &&
                                        _addtime_lifeline != 0) {
                                      _toggleContainer();
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    margin: const EdgeInsets.only(
                                        right: 30, top: 30),
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                        "assets/backgrounds/LifelLines.png",
                                      ),
                                    ),
                                  ),
                                ),
                                SizeTransition(
                                  sizeFactor: _animation,
                                  axis: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      //Skip question
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (_skip_quesion_lifeline != 0) {
                                                _toggleContainer();
                                                setState(() {
                                                  _skip_quesion_lifeline--;
                                                  _question_index++;
                                                  prefs.setInt("skipquestion",
                                                      _skip_quesion_lifeline);
                                                });
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage:
                                                  _skip_quesion_lifeline != 0
                                                      ? AssetImage(
                                                          "assets/backgrounds/skip.png")
                                                      : AssetImage(
                                                          "assets/backgrounds/no_skip.png"),
                                            ),
                                          ),
                                          Text(
                                            "Skip\nQuestion",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (!_freezetimer.isActive) {
                                                if (_freeze_time_lifeline !=
                                                    0) {
                                                  _toggleContainer();
                                                  setState(() {
                                                    _freeze_time_lifeline--;
                                                    _timer.cancel();
                                                    _freezetimer =
                                                        Timer.periodic(
                                                            const Duration(
                                                                seconds: 1),
                                                            (timer) {
                                                      setState(() {
                                                        _timer.cancel();
                                                        if (_freezetime > 0) {
                                                          _freezetime--;
                                                        } else {
                                                          // Timer will be canceled once it reached 0
                                                          _freezetimer.cancel();
                                                          startTimer();
                                                        }
                                                      });
                                                    });
                                                    prefs.setInt("freezetime",
                                                        _freeze_time_lifeline);
                                                  });
                                                }
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: _freeze_time_lifeline !=
                                                      0
                                                  ? AssetImage(
                                                      "assets/backgrounds/freeze.png")
                                                  : AssetImage(
                                                      "assets/backgrounds/no_freeze.png"),
                                            ),
                                          ),
                                          Text(
                                            "Freeze\nTime",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (_addtime_lifeline != 0) {
                                                _toggleContainer();
                                                _addtime_lifeline--;
                                                setState(() {
                                                  _countdown = _countdown + 10;
                                                  prefs.setInt(
                                                      "addtimelifeline",
                                                      _addtime_lifeline);
                                                });
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: _addtime_lifeline !=
                                                      0
                                                  ? AssetImage(
                                                      "assets/backgrounds/addtimer.png")
                                                  : AssetImage(
                                                      "assets/backgrounds/no_addtimer.png"),
                                            ),
                                          ),
                                          Text(
                                            "Add\nTime",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                              color: _timer_background_color,
                              shape: BoxShape.circle),
                          child: Center(
                              child: Text(
                            "$_countdown",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 30),
                          )),
                        ),
                        FittedBox(
                          child: Container(
                            margin: const EdgeInsets.all(27),
                            width: MediaQuery.of(context).size.width - 50,
                            height: 100,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              questions_items[uniqueNumbers[_question_index]]
                                  ["Question"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15),
                            )),
                          ),
                        ),

                        // Options Button with checking the answers in onTap
                        // and updates it to the next questions.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                // OPTION NUMBER 4(A)
                                GestureDetector(
                                  onTap: _disable_btn
                                      ? null
                                      : () {
                                          setState(() {
                                            _disable_btn = true;
                                            checkAnswerA(_round_name);
                                          });
                                        },
                                  child: FittedBox(
                                    child: Container(
                                      margin: const EdgeInsets.all(27),
                                      width: 130,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: _btn1_bg_color,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                        child: Text(
                                          questions_items[uniqueNumbers[
                                              _question_index]]["A"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // OPTION NUMBER 4(C)
                                GestureDetector(
                                  onTap: _disable_btn
                                      ? null
                                      : () {
                                          setState(() {
                                            _disable_btn = true;
                                            checkAnswerc(_round_name);
                                          });
                                        },
                                  child: FittedBox(
                                    child: Container(
                                      margin: const EdgeInsets.all(27),
                                      width: 130,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: _btn3_bg_color,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                        child: Text(
                                          questions_items[uniqueNumbers[
                                              _question_index]]["C"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                // OPTION NUMBER 4(B)
                                GestureDetector(
                                  onTap: _disable_btn
                                      ? null
                                      : () {
                                          setState(() {
                                            _disable_btn = true;
                                            checkAnswerB(_round_name);
                                          });
                                        },
                                  child: FittedBox(
                                    child: Container(
                                      margin: const EdgeInsets.all(27),
                                      width: 130,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: _btn2_bg_color,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                        child: Text(
                                          questions_items[uniqueNumbers[
                                              _question_index]]["B"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // OPTION NUMBER 4(D)
                                FittedBox(
                                  child: Container(
                                    margin: const EdgeInsets.all(27),
                                    width: 130,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: _btn4_bg_color,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: GestureDetector(
                                      onTap: _disable_btn
                                          ? null
                                          : () {
                                              setState(() {
                                                _disable_btn = true;
                                                checkAnswerD(_round_name);
                                              });
                                            },
                                      child: Center(
                                        child: Text(
                                          questions_items[uniqueNumbers[
                                              _question_index]]["D"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 100),
                          child: FilledButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepOrange)),
                              onPressed: () {
                                // _timer.cancel();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Quit",
                                style: TextStyle(
                                    fontFamily: 'RubikDoodleShadow',
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/backgrounds/question_page.png'),
                        fit: BoxFit.cover)),
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.orange,
                )),
              ));
  }

  Future<void> getQuestions() async {
    prefs = await SharedPreferences.getInstance();

    final String response = await rootBundle
        .loadString('assets/questions/easy-level-questions.json');
    final bank = await json.decode(response);
    setState(() {
      questions_items = bank[widget.mode];
      _max_question = questions_items.length;
      generateUniqueRandomNumbers(questions_items.length);
      _try_again_lifeline = prefs.getInt('tryagainlifeline')!;
      _addtime_lifeline = prefs.getInt('addtimelifeline')!;
      _skip_quesion_lifeline = prefs.getInt('skipquestion')!;
      _freeze_time_lifeline = prefs.getInt('freezetime')!;
      // print(_try_again_lifeline.toString()+"sdfsdfdsfsdfsdf");
    });
  }

  Future<void> _Game_finsih_Dialogbox(BuildContext context) async {
    prefs.setInt('coins', prefs.getInt('coins')! + _points);
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.popUntil(context, ModalRoute.withName('/Main_Page'));
              // Navigator.popAndPushNamed(context, '/Main_Page');

              return true;
            },
            child: AlertDialog(
              title: const Text("Game Over!!!!"),
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Correct Answer " + _points.toString()),
                    Text("Coins  Earned " + _points.toString()),
                    Column(
                      spacing: 10,
                      children: [
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange)),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Play Again",
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Main_Page()),
                                (route) => false,
                              );
                              // Navigator.pop(context);
                              // Navigator.popUntil(context,ModalRoute.withName('/Main_Page'));

                              // Navigator.popAndPushNamed(context, '/Main_Page');
                            },
                            child: const Text(
                              "Exit",
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

  Future<void> _Try_AgainDialogBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return WillPopScope(
            child: AlertDialog(
              title: const Text("Try Again?"),
              content: Container(
                height: 300,
                width: 390,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You have " +
                          _try_again_lifeline.toString() +
                          " Bonus Attempt left. Want to use",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.deepOrange)),
                            onPressed: () {
                              _try_again_lifeline = _try_again_lifeline - 1;
                              prefs.setInt(
                                  "tryagainlifeline", _try_again_lifeline);
                              _btn1_bg_color = Colors.blue;
                              _btn2_bg_color = Colors.blue;
                              _btn3_bg_color = Colors.blue;
                              _btn4_bg_color = Colors.blue;
                              Navigator.of(context).pop();
                              _disable_btn = false;
                              startTimer();
                            },
                            child: const Text(
                              "Use it",
                              style: TextStyle(
                                  fontFamily: 'RubikDoodleShadow',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.deepOrange)),
                            onPressed: () {
                              Navigator.pop(context);
                              _Game_finsih_Dialogbox(context);
                            },
                            child: const Text(
                              "Back",
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
            onWillPop: () async {
              Navigator.pop(context);
              Navigator.pop(context);

              return true;
            },
          );
        });
  }

  Future<void> _showchoiceDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext contexts) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              Navigator.pop(context);
              return true;
            },
            child: AlertDialog(
              title: const Text('Ready!'),
              content: Container(
                height: 300,
                width: 390,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Whenever you are Ready, hit the button the Timer will start.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              startTimer();
                            },
                            child: const Text(
                              "Ready",
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
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
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
