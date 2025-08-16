import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booster_container extends StatefulWidget {
  final name;
  final option;

  const Booster_container(
      {super.key, required this.name, required this.option});

  @override
  State<Booster_container> createState() => _Booster_containerState();
}

class _Booster_containerState extends State<Booster_container> {
  TextEditingController _bonus_controller = TextEditingController(text: "1");
  late int _try_again_lifeline;
  late int _addtime_lifeline;
  late int _skip_quesion_lifeline;
  late int _freeze_time_lifeline;
  late SharedPreferences prefs;
  final List<String> _option_details = [
    "This add 10 more seconds to the timer. ",
    "It Freezes the timer for 5 seconds",
    "It skips the question to the next one",
    "This Booster Options gives a "
        "second chance to give answer to the same question",
    ""
  ];

  // NOT in USE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOptioncount();
  }

  @override
  Widget build(BuildContext context) {
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
          Text(widget.name),
          Text("Total Owned: " + _try_again_lifeline!.toString()),
          Text(_option_details[widget.option],
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {

              }, icon: Icon(Icons.exposure_minus_1)),
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
              IconButton(onPressed: () {}, icon: Icon(Icons.exposure_plus_1)),
            ],
          ),
          FilledButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrange)),
              onPressed: () {
                // setOptioncount(widget.name);
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

  void getOptioncount() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _try_again_lifeline = prefs.getInt('tryagainlifeline')!;
      _addtime_lifeline = prefs.getInt('addtimelifeline')!;
      _skip_quesion_lifeline = prefs.getInt('freezetime')!;
      _freeze_time_lifeline = prefs.getInt('skipquestion')!;
    });

  }
  // void setOptioncount(String _option_name)async
  // {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     prefs.setInt(_option_name, )
  //   });
  //
  //
  // }
}
