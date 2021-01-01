import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/displaying_anime_bloc.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/fetching_anime.dart';
import 'package:linux_pagm/BLoC/Blocs/Anime/filtering_anime.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  AnimeBloc() : super(AnimeInitial());

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeFetching) {
      var bloc = FetchingAnime(event.currentState)
        ..add(event)
        ..close();
      await for (AnimeState animeState in bloc) {
        yield animeState;
      }
    } else if (event is AnimeFetchingBySearching) {
        var bloc = FilteringAnime(event.currentState)
          ..add(event)
          ..close();
        await for (AnimeState animeState in bloc) {
          yield animeState;
        }
    }
    else if(event is AnimeFetchingToDisplay){
      var bloc = DisplayingAnimeBloc(state)..add(event)..close();

      await for(AnimeState animeState in bloc){
        yield animeState;
      }
    }
  }
}
