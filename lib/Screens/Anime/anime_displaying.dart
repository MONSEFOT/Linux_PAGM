import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/anime_bloc.dart';
import 'package:linux_pagm/Resources/theme.dart';
import 'package:linux_pagm/Screens/Errors/error.dart';
import 'package:linux_pagm/Utils/Widgets/anime_builder.dart';

class AnimeDisplaying extends StatefulWidget {
  @override
  _AnimeDisplayingState createState() => _AnimeDisplayingState();
}

class _AnimeDisplayingState extends State<AnimeDisplaying> {
  AnimeBloc _animeBloc;

  @override
  void initState() {
    super.initState();

    _animeBloc = BlocProvider.of<AnimeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        shape: appBarShape(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sear',
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            Text(
              'ching',
              style: TextStyle(
                  color: red, fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          if (state is AnimeInitial) {
            return SpinKitRotatingCircle(
              color: red,
              size: 50.0,
            );
          } else if (state is AnimeFilteredSuccessToDisplaying) {
            return animeForDisplayingBuilder(state.anime);
          } else {
            return errorDisplaying("Anime Not found !!");
          }
        },
      ),
    );
  }
}
