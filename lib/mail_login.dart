import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:textrecognition/first_screen.dart';
import 'first_screen.dart';

class MailLogin extends StatefulWidget {
  @override
  MailLoginState createState() {
    return MailLoginState();
  }
}

class MailLoginState extends State<MailLogin> {
  final _auth = FirebaseAuth.instance;
  bool _isHidden = true;
  String email;
  String password;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Sign in with Email"),
        elevation: debugDefaultTargetPlatformOverride == TargetPlatform.android
            ? 5.0
            : 0.0,
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Image(
                image: AssetImage("assets/images/mail.png"),
                height: 150,
              ),
              SizedBox(
                height: 80.0,
              ),
              buildTextField("Email"),
              SizedBox(
                height: 20.0,
              ),
              buildPassTextField("Password"),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {},
                      child: Text('Forgot Password?',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              buildButtonContainer(),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 10.0,
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text("SIGN UP",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextField(
      onChanged: (value) {
        email = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: hintText == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
      ),
    );
  }

  Widget buildPassTextField(String hintText) {
    return TextField(
      onChanged: (value) {
        password = value;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: hintText == "Password"
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : Icon(Icons.lock),
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }

  Widget buildButtonContainer() {
    return RaisedButton(
      onPressed: () async {
//        print(email);
//        print(password);

         final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
         if(newUser != null){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
             return FirstScreen();
           }));}
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          gradient: LinearGradient(
              colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
              letterSpacing: 1.0,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
