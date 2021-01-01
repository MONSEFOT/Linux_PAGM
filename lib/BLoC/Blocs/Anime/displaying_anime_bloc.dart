import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/APi/api_request.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/Models/anime.dart';
import 'package:linux_pagm/Resources/api_urls.dart';

class DisplayingAnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  DisplayingAnimeBloc(AnimeState initialState) : super(initialState);

  Future<List<AnimeForList>> _fetchingAnimes(int animeId) async {
    List<AnimeForDisplaying> animes = [];

    //getting animes data from the api you have to select the starting index of the proccess in api
    final response =
        await ApiRequest().get(ApiURLs().get_anime_url + '/$animeId');

    //when the proccess is done you will get an api response with the data list
    if (response != null) {
      //transforming the json data to and a list of animes and returning it
      for (Map<String, dynamic> anime in response['data']) {
        animes.add(
          AnimeForDisplaying(
            id: int.parse(anime['id']),
            title: anime['attributes']['titles']['en_jp'],
            description: anime['attributes']['description'],
            coverImage: (anime['attributes']['coverImage'] != null)
                ? anime['attributes']['coverImage']['large']
                : null,
            posterImage: (anime['attributes']['posterImage'] != null)
                ? anime['attributes']['posterImage']['tiny']
                : null,
            status: anime['attributes']['status'],
            episodeCount: anime['attributes']['episodeCount'],
            averageRating: anime['attributes']['averageRating'],
            trailerID: anime['attributes']['youtubeVideoId'],
            ageRatingGuide: anime['attributes']['ageRatingGuide'],
          ),
        );
      }
      return animes;
    } else {
      throw Exception('error fetching posts');
    }
  }

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeFetchingToDisplay && event.animeId != null) {
      yield AnimeInitial();
      try {
        yield AnimeInitial();
        final animes = await _fetchingAnimes(event.animeId);
        yield AnimeFilteredSuccess(animes: animes, hasReachedMax: false);
        return;
      } catch (_) {
        yield AnimeFailure();
      }
    }
  }
}
