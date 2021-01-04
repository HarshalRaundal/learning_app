import 'dart:async';
import 'dart:ui';
import 'package:flutter_app/pages/quiz/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';



Color colorToShow = Colors.tealAccent;
Color right =Colors.green;
Color wrong =Colors.red;
Color neutral=Colors.tealAccent;



Map<int,String> que={
  1:"How many select lines would be required for an 8-line-to-1-line multiplexer?",
  2:" The enable input is also known as ___________",
  3: "In a multiplexer, the selection of a particular input line is controlled by ___________",
  4: "If the number of n selected input lines is equal to 2^m then it requires _____ select lines.",
  5: "The multiplexer is also known as ________.",
};
Map<int,String> opt1= {
  1: " 2",
  2: " 4",
  3: " 3",
  4: " 8",
};
Map<int,String> opt2= {
  1: " Select input",
  2: " Decoded input",
  3: " Strobe",
  4: " Sink",
};
Map<int,String> opt3= {
  1: " Data controller",
  2: " Selected lines",
  3: " Logic gates",
  4: " Both data controller and selected lines",
};
Map<int,String> opt4= {
  1: " 2",
  2: " m",
  3: " n",
  4: " 2n",
};
Map<int,String> opt5= {
  1: " Data selector",
  2: " Coder",
  3: " NOR gate",
  4: " Parallel adder",
};
Map<int,String> ans={
  1:" 3",
  2:" Strobe",
  3:" Selected lines",
  4:  " m",
  5: " Data selector",
};

Map<int,Map> opt={
  1:opt1,
  2:opt2,
  3:opt3,
  4:opt4,
  5:opt5,
  6:ans,
  7:btnColor,
};


Map<int,Color> btnColor={
  1:Colors.tealAccent,
  2:Colors.tealAccent,
  3:Colors.tealAccent,
  4:Colors.tealAccent,
  5:Colors.tealAccent,
};

class QuizCard extends StatefulWidget {
  QuizCard({Key key}) : super(key: key);
  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {

  int i=1;
  int j=1;
  int k=1;
  int timer =30;
  int marks=0;

  String timerIs="30";

  bool disableAns = false;
  bool cancelTimer = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  Widget queBlock(int i){
    return Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      child:Column(
        children: <Widget>[
          optionbtn(i,1),
          optionbtn(i,2),
          optionbtn(i,3),
          optionbtn(i,4),
        ],
      ),
    );
  }

  void startTimer()async{
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if(timer<1){
          t.cancel();
          setState(() {
            incCounter();
          });
          startTimer();

        }else if (cancelTimer== true) {
          t.cancel();
        }else{
          timer=timer-1;
        }
        timerIs=timer.toString();
      });
    });


  }


  void goToResult(){

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ResultPage(marks: marks,)));
  }

  void incCounter(){
    if(i<5)
    {
      cancelTimer=false;
      timer=30;
      i++;
      //j=j+4;
      k++;
    }
    else{
      goToResult();
    }

  }

  void checkAns(String click){

    if(click==opt[6][i])
    {
      //colorToShow=right;
      marks=marks+5;
    }
    else{
      //colorToShow=wrong;
    }
    setState(() {
      // applying the changed color to the particular button that was selected
      btnColor[i] = colorToShow;
      incCounter();
      disableAns = true;
    });
    startTimer();


  }

  Widget optionbtn(int i,int j){
    return Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      child: MaterialButton(
          elevation:5.5 ,
          onPressed:() =>checkAns(opt[i][j]),
          child: Text(
            opt[i][j]??'option',
            style: TextStyle(
              fontSize: 30.0,
            ),
            maxLines: 1,
          ),
          color: btnColor[i],
          splashColor: Colors.indigo[900],
          highlightColor: Colors.indigo[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minWidth: 200.0,
          height: 45

      ),

    );
  }

  Widget quizcards(int i){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
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
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    margin: EdgeInsets.all(24.0),
                    height: 120,
                    width: 370,
                    child: Text(
                      que[i]??'error in loading question',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(20.0),
                child:Column(
                  children: <Widget>[
                    queBlock(i),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget showTimer(){
    return Padding(padding: EdgeInsets.symmetric(horizontal:20.0,vertical: 5.0),
      child: Material(
        color: Colors.blueAccent,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          height: 50.0,
          child: Center(
            child: Text(timerIs,
              style: TextStyle(
                fontSize: 30.0,
              ),),
          ),
        ),


      ),);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MULTIPLEXER',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
        centerTitle: true,

      ),
      body:Center(
        child: ListView(
          children: <Widget>[
            quizcards(i),
            showTimer(),

          ],
        ),
      ),


    );
  }
}
