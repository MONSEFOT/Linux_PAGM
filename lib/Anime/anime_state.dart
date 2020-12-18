import 'package:equatable/equatable.dart';
import 'package:linux_pagm/Models/anime.dart';


abstract class AnimeState extends Equatable {
  const AnimeState();

  @override
  List<Object> get props => [];
}

class AnimeInitial extends AnimeState {}

class AnimeFailure extends AnimeState {}

class AnimeSuccess extends AnimeState {
  final List<Anime> animes;
  final bool hasReachedMax;

  const AnimeSuccess({
    this.animes,
    this.hasReachedMax,
  });

  AnimeSuccess copyWith({
    List<Anime> posts,
    bool hasReachedMax,
  }) {
    return AnimeSuccess(
      animes: posts ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [animes, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${animes.length}, hasReachedMax: $hasReachedMax }';
}