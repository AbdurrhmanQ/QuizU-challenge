// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizme/Pages/otpPage.dart';
import 'package:quizme/Pages/quizPage.dart';
import 'package:quizme/Services/Preferences.dart';
import 'package:quizme/Services/RemoteAPI.dart';
import 'package:quizme/models/Leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/loginPage.dart';

var token;
var isLogged;
RemoteAPI _remoteAPI = RemoteAPI();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = await Preferences.getToken();
  isLogged = await _remoteAPI.checkToken();

  print("this is main  " + token);
  runApp(quizMe());
}

class quizMe extends StatelessWidget {
  const quizMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isLogged ? 'home' : 'login',
      routes: {
        'login': (context) => loginPage(),
        'home': (context) => Home(),
        'otp': (context) => Otp(),
        'quiz': (context) => quizPage()
      },
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xfff7f6fb),
          textTheme: TextTheme(
            // bodyText1: TextStyle(color: Colors.grey.shade700),
            bodyText2: TextStyle(color: Colors.grey.shade800),
          )),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  late Widget body;
  // late RemoteAPI _remoteAPI;

  @override
  void initState() {
    setState(() {
      home();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff7f6fb),
        centerTitle: true,
        title: Text(
          'QuizU',
          style: TextStyle(fontSize: 36, color: Color(0xFF4C6793)),
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        //TODO:Dabble with it to make it look better
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedFontSize: 16,
        // backgroundColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            backgroundColor: Color(0xFF4C6793),
            activeIcon: Icon(
              Icons.home,
              size: 28,
            ),
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF4C6793),
            label: 'Leaderboard',
            activeIcon: Icon(
              Icons.leaderboard,
              size: 28,
            ),
            icon: Icon(Icons.leaderboard_outlined),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF4C6793),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person,
              size: 28,
            ),
            icon: Icon(Icons.person_outline),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int nIndex) {
          setState(() {
            _currentIndex = nIndex;
            if (nIndex == 0) {
              home();
            } else if (nIndex == 1) {
              leaderBoard();
            } else {
              profile();
            }
          });
        },
      ),
    );
  }

  home() {
    body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 310,
            child: Text(
              'Ready to test your knoweldge and challenge others ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
          ),
          SizedBox(
            width: 310,
            child: Text(
              'Answer as much questions correctly within 2 minutes',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => quizPage(),
                  ));
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Quiz Me!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            color: Color(0xFF4C6793),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }

  leaderBoard() {
    body = FutureBuilder(
        future: _remoteAPI.fetchLeaderboard(),
        builder: (context, snapshot) {
          List<Leaderboard>? top10 = snapshot.data;
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Leaderboard',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      itemCount: top10!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Center(
                                  child: Text(
                                    top10[index].name,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    top10[index].score.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : CircularProgressIndicator(
                      color: Color(0xFF4C6793),
                    )
            ]),
          );
        });
  }

  profile() {
    body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text('dataPF')],
      ),
    );
  }
}
