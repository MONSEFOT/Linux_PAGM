import 'package:equatable/equatable.dart';
import 'package:linux_pagm/Models/anime.dart';

abstract class AnimeState extends Equatable {
  final List<AnimeForList> animes;
  final bool hasReachedMax;

  const AnimeState({
    this.animes,
    this.hasReachedMax,
  });

  @override
  List<Object> get props => [];
}

class AnimeInitial extends AnimeState {}

class AnimeFailure extends AnimeState {}

class AnimeSuccess extends AnimeState {
  final List<AnimeForList> animes;
  final bool hasReachedMax;

  const AnimeSuccess({
    this.animes,
    this.hasReachedMax,
  });

  AnimeSuccess copyWith({
    List<AnimeForList> animes,
    bool hasReachedMax,
  }) {
    return AnimeSuccess(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [animes, hasReachedMax];

  @override
  String toString() => 'AnimeSuccess { animes: ${animes.length}, hasReachedMax: $hasReachedMax }';
}

class AnimeFilteredSuccess extends AnimeState {
  final List<AnimeForList> animes;
  final bool hasReachedMax;

  const AnimeFilteredSuccess({
    this.animes,
    this.hasReachedMax,
  });

  AnimeFilteredSuccess copyWith({
    List<AnimeForList> animes,
    bool hasReachedMax,
  }) {
    return AnimeFilteredSuccess(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [animes, hasReachedMax];

  @override
  String toString() => 'AnimeFilteredSuccess { animes: ${animes.length}, hasReachedMax: $hasReachedMax }';
}

class AnimeFilteredSuccessToDisplaying extends AnimeState{
  final AnimeForDisplaying anime;
  const AnimeFilteredSuccessToDisplaying({this.anime});

  @override
  List<Object> get props => [anime];

  @override
  String toString() => 'AnimeFilteredSuccessToDisplaying { anime: ${anime.id}'; 
}