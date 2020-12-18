import 'package:flutter/material.dart';
import 'package:linux_pagm/Models/user.dart';
import 'package:linux_pagm/Resources/theme.dart';

class Home extends StatefulWidget {
  User _user;
  Home(this._user);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueNight,
      appBar: appBar(),
      body: Center(
        child: Text(widget._user.toString() , style: shortDescription,),
      ),
    );
  }
}
