import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linux_pagm/BLoC/Cubits/password_obscure_text.dart';
import 'package:linux_pagm/Resources/theme.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final passwordObscureText = PasswordObscureText(true);
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueNight,
      body: Center(
        child: Container(
          height: 500.0,
          width: 500.0,
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: black,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              SizedBox(
                height: 30.0,
              ),
              _passwordField(_obscureText),
              SizedBox(
                height: 30.0,
              ),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      width: 300.0,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.yellowAccent),
          ),
          labelText: "Email",
          labelStyle: TextStyle(color: white),
        ),
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: white),
      ),
    );
  }

  Widget _passwordField(bool obscureText) {
    return Container(
      width: 300.0,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 3, color: Colors.yellowAccent),
          ),
          labelText: "Password",
          labelStyle: TextStyle(color: white),
          suffixIcon: IconButton(
            icon: Icon(
              (_obscureText)
                  ? CupertinoIcons.eye_slash
                  : CupertinoIcons.eye_fill,
              color: white,
            ),
            onPressed: () {
              setState(() {
                var cubit = PasswordObscureText(_obscureText)..changeObscureStatus()..close();
                _obscureText = cubit.state;
              });
            },
          ),
        ),
        obscureText: obscureText,
        controller: _password,
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(color: white),
      ),
    );
  }

  Widget _signInButton() {
    return Container(
      width: 250.0,
      child: FlatButton(
        color: blueNight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign",
                style: TextStyle(
                    color: white, fontSize: 18, fontStyle: FontStyle.italic),
              ),
              Text(
                "In",
                style: TextStyle(
                    color: red, fontSize: 18, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
