import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/anime_bloc.dart';
import 'package:linux_pagm/Models/anime.dart';
import 'package:linux_pagm/Resources/string.dart';
import 'package:linux_pagm/Resources/theme.dart';
import 'package:linux_pagm/Screens/Anime/anime_displaying.dart';

Widget animeForListBuilder(BuildContext context, AnimeForList anime) {
  return FlatButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => AnimeBloc()
            ..add(
              AnimeFetchingToDisplay(animeId: anime.id),
            ),
          child: AnimeDisplaying(),
        ),
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
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
      child: Container(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  anime.posterImage,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: red,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              //Anime's Info
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (anime.title != null) ? anime.title : "",
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
                          (anime.averageRating != null)
                              ? anime.averageRating
                              : "",
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
    ),
  );
}

Widget animeForDisplayingBuilder(AnimeForDisplaying anime) {
  return ListView(
    children: [
      Container(
        margin: EdgeInsets.all(10.0),
        color: black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 500.0,
              width: 300.0,
              padding: EdgeInsets.all(10.0),
              child: Image.network(
                anime.posterImage,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: red,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Table(
                  border: TableBorder.all(width: 3.0, color: blueNight),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                title,
                                style: itemOfAnimeListTitle,
                              )),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              anime.title,
                              style: TextStyle(
                                color: white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                ageRatingGuide,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                anime.ageRatingGuide,
                                style: TextStyle(
                                  color: red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              anime.status,
                              style: TextStyle(
                                color: (anime.status == "finished")
                                    ? red
                                    : green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                episodeCount,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              (anime.episodeCount == null)
                                  ? "Unfound"
                                  : "${anime.episodeCount}",
                              style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                story,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              anime.description,
                              style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
