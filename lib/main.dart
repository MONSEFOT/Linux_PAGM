import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/Screens/sign_in_screen.dart';
import 'BLoC/Blocs/sign_in_bloc.dart';
import 'Resources/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: appBarTheme,
        accentColor: white,
      ),
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => SignInBloc(),
        child: SignInScreen(),
      ),
    );
  }
}
