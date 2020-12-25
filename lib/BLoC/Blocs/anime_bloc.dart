import 'package:bloc/bloc.dart';
import 'package:linux_pagm/APi/api_request.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/Models/anime.dart';
import 'package:linux_pagm/Resources/api_urls.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  AnimeBloc() : super(AnimeInitial());

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    final currentState = state;
    if (event is AnimeFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is AnimeInitial) {

          //here the app will get the animes from the first one in the database
          final animes = await _fetchAnimes(0);
          yield AnimeSuccess(animes: animes, hasReachedMax: false);
          return;
        }
        if (currentState is AnimeSuccess) {
          final animes = await _fetchAnimes(currentState.animes.length - 1);
          yield animes.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : AnimeSuccess(
                  animes: currentState.animes + animes,
                  hasReachedMax: false,
              );
        }
      } catch (_) {
        yield AnimeFailure();
      }
    }
  }

  //this function with return if the anime list has reached max or not
  bool _hasReachedMax(AnimeState state) => state is AnimeSuccess && state.hasReachedMax;

  //in this function the app wil connect to the api and get animes data from it 
  //finally you will get an object list of animes
  Future<List<AnimeForList>> _fetchAnimes(int startIndex) async {
    List<AnimeForList> animes = [];

    //getting animes data from the api you have to select the starting index of the proccess in api 
    final response = await ApiRequest().get(ApiURLs().get_anime_url + '?page[offset]=$startIndex');

    //when the proccess is done you will get an api response with the data list 
    if (response != null) {

      //transforming the json data to and a list of animes and returning it   
      for (Map<String, dynamic> anime in response['data']) {
        animes.add(
          AnimeForList(
            id: int.parse(anime['id']),
            title: anime['attributes']['titles']['en_jp'],
            coverImage: (anime['attributes']['coverImage'] != null)? anime['attributes']['coverImage']['large'] : null,
            posterImage: (anime['attributes']['posterImage'] != null)? anime['attributes']['posterImage']['tiny'] : null,
            status: anime['attributes']['status'],
            episodeCount: anime['attributes']['episodeCount'],
            averageRating: anime['attributes']['averageRating'],
          ),
        );
      }
      return animes;
    } else {
      throw Exception('error fetching posts');
    }
  }
}
