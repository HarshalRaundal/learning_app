import 'package:flutter/material.dart';
import 'package:flutter_app/pages/discuss.dart';
import 'package:flutter_app/pages/profile.dart';
import 'package:flutter_app/pages/quiz/quiz_home.dart';
import 'package:flutter_app/pages/videoPlayer/home.dart';

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  int page = 0;

  List pageOptions = [
    Home(),
    DiscussPage(),
    QuizHome(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageOptions[page],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            page = index;
          });
        },

        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        currentIndex: page,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
              size: 32,),
            label:"Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment,
              size: 32,),
            label:"Discuss",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer,
            size: 32,),
            label:"Quiz",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
              size: 32,),
            label:"Profile",
          ),
        ],

      ),
    );
  }
}
