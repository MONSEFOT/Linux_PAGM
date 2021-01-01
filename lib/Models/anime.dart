import 'package:flutter/material.dart';

class AnimeForList{
  int id;
  String title;
  String coverImage;
  String posterImage;
  int episodeCount;
  String status;
  String averageRating;

  AnimeForList({@required this.id , this.title , this.coverImage , this.posterImage , this.episodeCount , this.status , this.averageRating});
}

class AnimeForDisplaying extends AnimeForList{
  String description;
  String trailerID;
  String ageRatingGuide;
  AnimeForDisplaying({@required int id , String title , String coverImage , String  posterImage , int episodeCount , String status , String averageRating , this.description , this.trailerID , this.ageRatingGuide}){
    this.id = id;
    this.title = title;
    this.coverImage = coverImage;
    this.posterImage = posterImage;
    this.averageRating = averageRating;
    this.episodeCount = episodeCount;
    this.status = status;
  }
}