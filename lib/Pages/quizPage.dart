// ignore_for_file: prefer_const_constructors

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quizme/Services/Preferences.dart';
import 'package:quizme/Services/RemoteAPI.dart';
import 'package:quizme/main.dart';
import 'package:quizme/models/Question.dart';

class quizPage extends StatefulWidget {
  const quizPage({super.key});

  @override
  State<quizPage> createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  bool? isClicked;
  int score = 0;
  int index = 0;
  late RemoteAPI _remoteAPI;
  final CountDownController _controller = CountDownController();

  List<Question> qestions = [];

  @override
  void initState() {
    _remoteAPI = RemoteAPI();
    getQuestions();
    index = 0;
    isClicked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (qestions.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF4C6793),
          ),
        ),
      );
    } else {
      return Scaffold(
          body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircularCountDownTimer(
                    controller: _controller,
                    width: 50,
                    height: 50,
                    duration: 120,
                    fillColor: Color(0xFF4C6793),
                    ringColor: Colors.grey,
                    strokeWidth: 5,
                    isReverse: true,
                    isReverseAnimation: true,
                    onComplete: () => {showFinishAlert()}),
              ),
              Card(
                elevation: 4,
                color: Color.fromARGB(255, 187, 202, 207),
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: Column(
                    children: [
                      Text(
                        qestions[index].question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Expanded(
                              child: MaterialButton(
                                color: Color(0xFF4C6793),
                                textColor: Colors.white,
                                onPressed: () {
                                  if (qestions[index].correct == 'a') {
                                    setState(() {
                                      score++;
                                      index++;
                                      if (index == 30) {
                                        showFinishAlert();
                                      }
                                    });
                                  } else {
                                    showWrongAlert();
                                  }
                                },
                                child: Text(qestions[index].a),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: MaterialButton(
                                  color: Color(0xFF4C6793),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (qestions[index].correct == 'b') {
                                      setState(() {
                                        score++;
                                        index++;
                                        if (index == 30) {
                                          showFinishAlert();
                                        }
                                      });
                                    } else {
                                      showWrongAlert();
                                    }
                                  },
                                  child: Text(qestions[index].b)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Expanded(
                              child: MaterialButton(
                                  color: Color(0xFF4C6793),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (qestions[index].correct == 'c') {
                                      setState(() {
                                        score++;
                                        index++;
                                        if (index == 30) {
                                          showFinishAlert();
                                        }
                                      });
                                    } else {
                                      showWrongAlert();
                                    }
                                  },
                                  child: Text(qestions[index].c)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: MaterialButton(
                                  color: Color(0xFF4C6793),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (qestions[index].correct == 'd') {
                                      setState(() {
                                        score++;
                                        index++;
                                        if (index == 30) {
                                          showFinishAlert();
                                        }
                                      });
                                    } else {
                                      showWrongAlert();
                                    }
                                  },
                                  child: Text(qestions[index].d)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MaterialButton(
                color: Color(0xFF5C2E7E),
                textColor: isClicked! ? Colors.black : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Skip'),
                onPressed: isClicked!
                    ? null
                    : () {
                        setState(() {
                          index++;
                          isClicked = true;
                        });
                      },
              )
            ],
          ),
        ),
      ));
    }
  }

  Future<void> showFinishAlert() {
    _remoteAPI.postScore(score);
    Preferences.saveScore(score.toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        ModalRoute.withName('home'));
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text('congratulations'),
        content: Text('You have scored $score questions'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () {}, child: Text('Share')),
          TextButton(
              onPressed: () {
                Navigator.pop(ctx, 'close');
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ))
        ],
      ),
    );
  }

  Future<void> showWrongAlert() {
    _remoteAPI.postScore(score);
    Preferences.saveScore(score.toString());

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        ModalRoute.withName('home'));
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text('Wrong Answer'),
        content: Text('You have scored $score questions'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx, 'close');
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ))
        ],
      ),
    );
  }

  void getQuestions() async {
    qestions = await _remoteAPI.fetchQuestions();
    setState(() {
      qestions.shuffle();
    });
  }
}
