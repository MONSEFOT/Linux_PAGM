import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/BLoC/Blocs/anime_bloc.dart';
import 'package:linux_pagm/Models/anime.dart';
import 'package:linux_pagm/Resources/string.dart';
import 'package:linux_pagm/Resources/theme.dart';
import 'package:linux_pagm/Screens/error.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  AnimeBloc _animeBloc;

  @override
  void initState() {
    super.initState();

    //this is the listener of cheking the mac scroll in the list view of animes
    _scrollController.addListener(_onScroll);
    _animeBloc = BlocProvider.of<AnimeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueNight,
      appBar: appBar(),
      body: Center(
        child: BlocBuilder<AnimeBloc, AnimeState>(
          builder: (context, state) {
            if (state is AnimeInitial) {
              return CircularProgressIndicator(
                backgroundColor: red,
              );
            } else if (state is AnimeSuccess) {
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
                      : animeForListBuilder(state.animes[index]);
                },
              );
            } else {
              return errorDisplaying("That is a problem in your progress");
            }
          },
        ),
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

  Widget animeForListBuilder(AnimeForList anime) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),

        //anime covert image
        image: (anime.coverImage != null)
            ? DecorationImage(
                image: Image.network(anime.coverImage).image,
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
              )
            : null,
      ),
      child:
          //poster image
          Container(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: anime.posterImage,
                  placeholder: (context, url) => CircularProgressIndicator(
                    backgroundColor: red,
                  ),
                ),
              ),
            ),
            Container(

              //Anime's Info
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: itemOfAnimeListTitle,
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    anime.status,
                    style: TextStyle(
                      color: (anime.status == animeIsFinished) ? red : green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.star_border,
                          color: amber,
                        ),
                        Text(
                          anime.averageRating,
                          style: longDescription,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Episodes: ",
                        style: longDescription,
                      ),
                      Text(
                        (anime.episodeCount != null)
                            ? '${anime.episodeCount}'
                            : unknown,
                        style: episodeCounterStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
      _animeBloc..add(AnimeFetched());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
