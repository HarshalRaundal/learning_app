import 'package:flutter_app/pages/quiz/questions.dart';
import 'package:flutter/material.dart';



class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => new _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  Widget quizcards(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>QuizCard()));
        },
        child: Material(
          color: Colors.indigoAccent,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Material(
                    color: Colors.blueAccent,
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          image:AssetImage('images/mux.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text('multiplexer',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'A quiz on multiplexer to build up concepts.',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,

                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QUIZ',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
        centerTitle: true,

      ),
      body:
      ListView(
        children: <Widget>[
          quizcards(),
        ],
      ),
    );
  }
}
