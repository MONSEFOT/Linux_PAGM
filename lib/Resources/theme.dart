import 'package:flutter/material.dart';

const Color blueNight = Color(0xff161a1d);
const Color white = Colors.white;
const Color black = Colors.black54;
const Color red = Color(0xffa4161a);
const Color green = Colors.green;
const Color amber = Colors.amber;

const TextStyle itemOfAnimeListTitle = TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.bold);
const TextStyle shortDescription = TextStyle(color: white, fontSize: 15);
const TextStyle errorText = TextStyle(color: red, fontSize: 15);
const TextStyle longDescription = TextStyle(color: white, fontSize: 14);
const TextStyle appTitle = TextStyle(
  color: white,
  fontSize: 60,
  fontFamily: "BungeeOutline",
);
const TextStyle appDeveloper = TextStyle(
    color: Colors.redAccent, fontSize: 30, fontFamily: "BungeeOutline");
const TextStyle episodeCounterStyle = TextStyle(color: amber, fontSize: 15);

const AppBarTheme appBarTheme = AppBarTheme(
  color: black,
);
RoundedRectangleBorder appBarShape() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(20.0),
      bottomLeft: Radius.circular(20.0),
    ),
  );
}
