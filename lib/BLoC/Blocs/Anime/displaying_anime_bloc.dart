import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/APi/api_request.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/Models/anime.dart';
import 'package:linux_pagm/Resources/api_urls.dart';

class DisplayingAnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  DisplayingAnimeBloc(AnimeState initialState) : super(initialState);

  Future<AnimeForDisplaying> _fetchingAnimes(int animeId) async {
    AnimeForDisplaying anime;

    //getting animes data from the api you have to select the starting index of the proccess in api
    final response = await ApiRequest().get(ApiURLs().get_anime_url + '/$animeId');

    //when the proccess is done you will get an api response with the data list
    if (response != null) {
      //transforming the json data to and an object anime 
      anime = new AnimeForDisplaying(
            id: int.parse(response['data']['id']),
            title: response['data']['attributes']['titles']['en_jp'],
            description: response['data']['attributes']['description'],
            coverImage: (response['data']['attributes']['coverImage'] != null)
                ? response['data']['attributes']['coverImage']['large']
                : null,
            posterImage: (response['data']['attributes']['posterImage'] != null)
                ? response['data']['attributes']['posterImage']['original']
                : null,
            status: response['data']['attributes']['status'],
            episodeCount: response['data']['attributes']['episodeCount'],
            averageRating: response['data']['attributes']['averageRating'],
            trailerID: response['data']['attributes']['youtubeVideoId'],
            ageRatingGuide: response['data']['attributes']['ageRatingGuide'],
        );
      
      return anime;
    } else {
      throw Exception('error fetching posts');
    }
  }

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeFetchingToDisplay && event.animeId != null) {
      yield AnimeInitial();
      try {
        final anime = await _fetchingAnimes(event.animeId);
        yield AnimeFilteredSuccessToDisplaying(anime: anime);
        return;
      } catch (_) {
        yield AnimeFailure();
      }
    }
  }
}
