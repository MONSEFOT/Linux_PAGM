import 'package:flutter/material.dart';
import 'package:linux_pagm/Resources/theme.dart';

Widget errorDisplaying(String error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning,
          color: red,
          size: 100.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          error,
          style: errorText,
        ),      
      ],
    ),
  );
}
