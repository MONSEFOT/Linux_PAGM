import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/fetching_anime.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  AnimeBloc() : super(AnimeInitial());

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeFetching) {
      var bloc = FetchingAnime(event.currentState)
        ..add(AnimeFetching())
        ..close();
      await for (AnimeState animeState in bloc) {
        yield animeState;
      }
    } else if (event is AnimeFetchingByFiltering) {}

    _fetchingAnime(AnimeState animeState) async* {
      yield animeState;
      return;
    }

    Stream<AnimeState> _fetchingListOfAnimesWithPagennitionProccess() async* {}
  }
}
