import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/BLoC/Blocs/anime_bloc.dart';
import 'package:linux_pagm/Screens/home.dart';
import 'package:window_size/window_size.dart';
import 'Resources/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('PAGM');
    setWindowMinSize(const Size(1000, 800));
    setWindowMaxSize(const Size(1000, 800));
  }
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
        create: (context) => AnimeBloc()..add(AnimeFetched()),
        child: Home(),
      ),
    );
  }
}
