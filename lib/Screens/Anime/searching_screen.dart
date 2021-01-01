import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/anime_bloc.dart';
import 'package:linux_pagm/Resources/theme.dart';
import 'package:linux_pagm/Screens/Errors/error.dart';
import 'package:linux_pagm/Utils/Widgets/anime_builder.dart';

class SearchingScreen extends StatefulWidget {
  @override
  _SearchingScreenState createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  TextEditingController _textSearchingController = new TextEditingController();
  AnimeEvent _fetchingAnimeEvent;
  AnimeBloc _animeBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();

    //this is the listener of cheking the mac scroll in the list view of animes
    _scrollController.addListener(_onScroll);

    _animeBloc = BlocProvider.of<AnimeBloc>(context);

    _animeBloc..add(AnimeFetching(currentState: AnimeInitial()));
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
        actions: [
          Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              width: 300.0,
              child: TextField(
                controller: _textSearchingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  filled: true,
                  fillColor: white,
                  hoverColor: white,
                  hintText: "Search",
                ),
                cursorColor: black,
                onSubmitted: (text) {
                  _fetchingAnimeEvent = AnimeFetchingBySearching(
                    currentState: AnimeInitial(),
                    searchingText: text,
                  );
                  _animeBloc..add(_fetchingAnimeEvent);
                },
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<AnimeBloc, AnimeState>(
                  builder: (context, state) {
                    if (state is AnimeInitial) {
                      return SpinKitRotatingCircle(
                        color: red,
                        size: 50.0,
                      );
                    } else if (state is AnimeFilteredSuccess) {
                      if (state.animes != null) {
                        _fetchingAnimeEvent =
                            AnimeFetchingBySearching(currentState: state);
                        return ListView.builder(
                          controller: _scrollController,
                          //here when the index will be the last the length of the list will be incremented with 1
                          //the incremented index will be the circular progress indicator like in the code bellow
                          itemCount: (state.hasReachedMax)
                              ? state.animes.length
                              : state.animes.length + 1,
                          itemBuilder: (context, index) {
                            return (index >= state.animes.length)
                                ? Column(
                                    children: [
                                      CircularProgressIndicator(
                                        backgroundColor: red,
                                      ),
                                    ],
                                  )
                                : animeForListBuilder(context , state.animes[index]);
                          },
                        );
                      } else {
                        return errorDisplaying(
                          "That is no anime with this name '${_textSearchingController.text}'",
                        );
                      }
                    } else {
                      return errorDisplaying(
                        "Please write the name of anime wich you want to search fo it",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //when the user will be in the last index from the animes list the app automaticlly will get more animes from the api
  //the code bellow is for chcking if the user is in the last index of the animes list
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _animeBloc..add(_fetchingAnimeEvent);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
