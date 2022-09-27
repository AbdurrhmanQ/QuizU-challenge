// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(quizMe());
}

class quizMe extends StatelessWidget {
  const quizMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
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
      backgroundColor: Color(0xFF8BBCCC),
      appBar: AppBar(
        backgroundColor: Color(0xFF4C6793),
        centerTitle: true,
        title: Text(
          'QuizMe',
          style: TextStyle(fontSize: 36),
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
          MaterialButton(
            onPressed: () {},
            child: Text(
              'Quiz Me!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            color: Color(0xFF4C6793),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            width: 310,
            child: Text(
              'Answer as much questions correctly within 2 minutes',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  leaderBoard() {
    body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Leaderboard',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            clipBehavior: Clip.none,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text('name'),
                    Text('Score'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
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
