import 'package:equatable/equatable.dart';
import 'package:linux_pagm/Anime/anime_state.dart';

abstract class AnimeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AnimeFetching extends AnimeEvent {
  final AnimeState currentState;

  AnimeFetching({this.currentState});
}

class AnimeFetchingBySearching extends AnimeEvent{
  final AnimeState currentState;
  String searchingText;
  
  AnimeFetchingBySearching({this.currentState , this.searchingText});
}

class AnimeFetchingToDisplay extends AnimeEvent{
  final int animeId;

  AnimeFetchingToDisplay({this.animeId});
}
