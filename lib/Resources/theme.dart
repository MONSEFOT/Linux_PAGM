import 'package:flutter/material.dart';

const Color blueNight = Color(0xff161a1d);
const Color white = Colors.white;
const Color black = Colors.black54;
const Color red = Color(0xffa4161a);

const TextStyle itemOfAnimeListTitle =TextStyle(color: white, fontSize: 15);
const TextStyle shortDescription = TextStyle(color: white, fontSize: 12);
const TextStyle errorText = TextStyle(color: red  , fontSize: 15);
const TextStyle longDescription = TextStyle(color: white, fontSize: 13);
const TextStyle appTitle = TextStyle(color: white, fontSize: 60 , fontFamily: "BungeeOutline");
const TextStyle appDeveloper = TextStyle(color: Colors.redAccent, fontSize: 30 , fontFamily: "BungeeOutline");


const AppBarTheme appBarTheme = AppBarTheme(
  color: black,
);

Widget appBar() {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
      ),
    ),
  );
}
