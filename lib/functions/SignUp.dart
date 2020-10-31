import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/functions/navigation.dart';
import 'package:flutter_app/utils/variables.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();


  signUp(){
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((signedUser) => {
      usercollection.doc(signedUser.user.uid).set({

        'username':usernameController.text,
        'password':passwordController.text,
        'email':emailController.text,
        'uid':signedUser.user.uid,
        'profilePic':'images/profile.png'
    })
    });

    Navigator.pop(context);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.cyan[200],
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
              Text("SignUp",
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
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Username',
                    labelStyle: myStyle(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              InkWell(
                onTap: ()=>signUp(),
                child: Container(
                  width: MediaQuery.of(context).size.width /2,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text('Register',
                      style: myStyle(20,Colors.black,FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
