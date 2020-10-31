import 'package:flutter_app/pages/front.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ResultPage extends StatefulWidget {
  int marks;
  ResultPage({Key key,@required this.marks}) :super(key :key);
  @override
  _ResultPageState createState() => _ResultPageState(marks);
}

class _ResultPageState extends State<ResultPage> {
  int marks;
  _ResultPageState(this.marks);
  List<String> images = [
    'images/mux.png',
    'images/mux.png',
    'images/mux.png',
  ];

  String message;
  String image;

  @override
  void initState() {
    if (marks < 5) {
      image = images[2];
      message = "You Should Try Hard..\n" + "You Scored $marks" ?? 'null';
    } else if (marks < 10) {
      image = images[1];
      message = "You Can Do Better..\n" + "You Scored $marks" ?? 'null';
    } else {
      image = images[0];
      message = "You Did Very Well..\n" + "You Scored $marks";
    }
    super.initState();
  }

  Widget resultWindow(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                    height: 270.0,
                    width: 270.0,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage(image),
                      ),
                    ),
                  ),
                ),
              ),
              Container(margin: EdgeInsets.all(50.0),
                child: Text(message,
                  style: TextStyle(
                    fontFamily: 'Chilanka-Regular',
                    fontSize: 27.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(

                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>(FrontPage())));
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontFamily: 'Chilanka-Regular',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 25.0,
                      ),
                      borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                      splashColor: Colors.indigoAccent,
                    )
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result',
        style: TextStyle(
          fontFamily: 'Alike',
          fontSize: 30,
          fontWeight:FontWeight.w900,
        ),),
        centerTitle: true,),
      body: Center(
        child: Container(
          child: resultWindow(),
        ),
      ),
    );
  }
}


