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

class AnimeFetchingByFiltering extends AnimeEvent{
  AnimeFetchingByFiltering({t});
}
