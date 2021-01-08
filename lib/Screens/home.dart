import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/anime_bloc.dart';
import 'package:linux_pagm/Resources/theme.dart';
import 'package:linux_pagm/Screens/Errors/error.dart';
import 'package:linux_pagm/Screens/Anime/searching_screen.dart';
import 'package:linux_pagm/Utils/Widgets/anime_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:linux_pagm/Resources/string.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  AnimeBloc _animeBloc;
  AnimeEvent _fetchingAnimeEvent;
  bool _searchModeStatus = false;

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
      backgroundColor: blueNight,
      appBar: AppBar(
        shape: appBarShape(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ani',
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            Text(
              'mes',
              style: TextStyle(
                  color: red, fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 35.0,
                ),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AnimeBloc(),
                          child: SearchingScreen(),
                        ),
                      ),
                    )),
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
                    } else if (state is AnimeSuccess) {
                      _fetchingAnimeEvent = AnimeFetching(currentState: state);
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
                              : animeForListBuilder(
                                  context, state.animes[index]);
                        },
                      );
                    } else {
                      return errorDisplaying(
                          "That is a problem in your progress");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Icon(MdiIcons.github , color: white,),
        onPressed: () async {
          if (await canLaunch(githubRepositoryUrl)) {
            await launch(githubRepositoryUrl);
          } else {
            throw 'Could not launch $githubRepositoryUrl';
          }
        },
      ),
    );
  }

  Widget bottomLoader() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            backgroundColor: red,
            strokeWidth: 1.5,
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
