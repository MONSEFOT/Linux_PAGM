import 'package:equatable/equatable.dart';

abstract class AnimeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AnimeFetched extends AnimeEvent {}