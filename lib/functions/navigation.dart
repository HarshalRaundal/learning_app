
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/functions/SignUp.dart';
import 'package:flutter_app/pages/discuss.dart';
import 'package:flutter_app/pages/front.dart';
import 'package:flutter_app/utils/variables.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  bool isSigned = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((userAccount) {
      if (userAccount != null) {
        setState(() {
          isSigned = true;
        });
      } else {
        setState(() {
          isSigned = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ?   Login() : FrontPage() ,
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  login(){
    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome",

              style:GoogleFonts.roboto(fontSize: 40,fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 10,
              ),
              Text("Login",
              style:GoogleFonts.montserrat(fontSize: 28,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                height: 150,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    labelStyle: myStyle(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  controller: passwordController,
                 obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    labelStyle: myStyle(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              InkWell(
                onTap: ()=>login(),
                child: Container(
                  width: MediaQuery.of(context).size.width /2,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text('Login',
                    style: myStyle(20,Colors.black,FontWeight.w700),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                  style: myStyle(20),
                  ),

                  SizedBox(width: 10,),
                  InkWell(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())),
                    child: Text("Register Now!",
                      style: myStyle(20,Colors.pinkAccent,FontWeight.w700),
                    ),
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
