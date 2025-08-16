// import 'package:flutter/material.dart';
// class Question_page_completed extends StatefulWidget {
//   const Question_page_completed({super.key});
//
//   @override
//   State<Question_page_completed> createState() => _Question_page_completedState();
// }
//
// class _Question_page_completedState extends State<Question_page_completed> {
//   int _question_index = 0;
//   int _presses_btn = 0;
//   Color _btn1_bg_color = Colors.blue;
//   Color _btn2_bg_color = Colors.blue;
//   Color _btn3_bg_color = Colors.blue;
//   Color _btn4_bg_color = Colors.blue;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/backgrounds/question_page.png'),
//               fit: BoxFit.cover)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 100,
//           ),
//           Container(
//             width: 130,
//             height: 100,
//             decoration: const BoxDecoration(
//                 color: Colors.greenAccent, shape: BoxShape.circle),
//             child: Center(
//                 child: Text(
//                   "$_countdown",
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 30),
//                 )),
//           ),
//           Container(
//             margin: const EdgeInsets.all(27),
//             width: MediaQuery.of(context).size.width - 50,
//             height: 100,
//             decoration: const BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.all(Radius.circular(10))),
//             child: Center(
//                 child: Text(
//                   questions_items[_question_index]["Question"],
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 15),
//                 )),
//           ),
//
//
//           // Options Button with checking the answers in onTap and updates it to the next questions.
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (questions_items[_question_index]["A"]
//                             .toString() ==
//                             questions_items[_question_index]["Ans"]) {
//                           _btn1_bg_color = Colors.green;
//                           _timer = Timer.periodic(
//                               const Duration(milliseconds: 500), (timer) {
//                             setState(() {
//                               _question_index++;
//                               _btn1_bg_color = Colors.blue;
//                               _timer.cancel();
//                             });
//                           });
//                           // _question_index++;
//                           // _btn1_bg_color =Colors.blue;
//                         } else {
//                           _btn1_bg_color = Colors.red;
//                         }
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(27),
//                       width: 130,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           color: _btn1_bg_color,
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(10))),
//                       child: Center(
//                         child: Text(
//                           questions_items[_question_index]["A"],
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (questions_items[_question_index]["C"]
//                             .toString() ==
//                             questions_items[_question_index]["Ans"]) {
//                           _btn3_bg_color = Colors.green;
//                           // _question_index++;
//                           // _btn3_bg_color =Colors.blue;
//                         } else {
//                           _btn3_bg_color = Colors.red;
//                         }
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(27),
//                       width: 130,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           color: _btn3_bg_color,
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(10))),
//                       child: Center(
//                         child: Text(
//                           questions_items[_question_index]["C"],
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (questions_items[_question_index]["B"]
//                             .toString() ==
//                             questions_items[_question_index]["Ans"]) {
//                           _btn2_bg_color = Colors.green;
//                           // _question_index++;
//                           // _btn2_bg_color =Colors.blue;
//                         } else {
//                           _btn2_bg_color = Colors.red;
//                         }
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(27),
//                       width: 130,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           color: _btn2_bg_color,
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(10))),
//                       child: Center(
//                         child: Text(
//                           questions_items[_question_index]["B"],
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (questions_items[_question_index]["D"]
//                             .toString() ==
//                             questions_items[_question_index]["Ans"]) {
//                           _btn4_bg_color = Colors.green;
//                           // _question_index++;
//                           // _btn4_bg_color =Colors.blue;
//                         } else {
//                           _btn4_bg_color = Colors.red;
//                         }
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(27),
//                       width: 130,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           color: _btn4_bg_color,
//                           borderRadius:
//                           const BorderRadius.all(Radius.circular(10))),
//                       child: Center(
//                         child: Text(
//                           questions_items[_question_index]["D"],
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 100),
//             child: FilledButton(
//                 style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all(Colors.deepOrange)),
//                 onPressed: () {
//                   _timer.cancel();
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   "Quit",
//                   style: TextStyle(
//                       fontFamily: 'RubikDoodleShadow',
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
