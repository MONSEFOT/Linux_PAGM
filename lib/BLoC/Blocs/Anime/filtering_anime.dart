import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/APi/api_request.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/Models/anime.dart';
import 'package:linux_pagm/Resources/api_urls.dart';

class FilteringAnime extends Bloc<AnimeEvent , AnimeState>{
  FilteringAnime(AnimeState initialState) : super(initialState);
  //this function with return if the anime list has reached max or not
  bool _hasReachedMax(AnimeState state) =>state is AnimeSuccess && state.hasReachedMax;    

  //in this function the app wil connect to the api and get animes data from it
  //finally you will get an object list of animes
  Future<List<AnimeForList>> _fetchingAnimes(int startIndex ,String text) async {
    List<AnimeForList> newAnimes = [];

    //getting animes data from the api you have to select the starting index of the proccess in api
    final response = await ApiRequest().get( ApiURLs().get_anime_url + '?page[offset]=$startIndex&filter[text]=$text');

    //when the proccess is done you will get an api response with the data list
    if (response != null) {
      //transforming the json data to and a list of animes and returning it
      for (Map<String, dynamic> anime in response['data']) {
        newAnimes.add(
          AnimeForList(
            id: int.parse(anime['id']),
            title: anime['attributes']['titles']['en_jp'],
            coverImage: (anime['attributes']['coverImage'] != null)
                ? anime['attributes']['coverImage']['large']
                : null,
            posterImage: (anime['attributes']['posterImage'] != null)
                ? anime['attributes']['posterImage']['tiny']
                : null,
            status: anime['attributes']['status'],
            episodeCount: anime['attributes']['episodeCount'],
            averageRating: anime['attributes']['averageRating'],
          ),
        );
      }
      return newAnimes;
    } else {
      throw Exception('error fetching posts');
    }
  }

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async*{
    
    //getting the state of the last stream from the bloc
    final currentState = state;

    if (event is AnimeFetchingBySearching && !_hasReachedMax(currentState)) {
      if(event.currentState is AnimeInitial){
        yield AnimeInitial();
      }
      try {
        if (currentState is AnimeInitial) {
          yield AnimeInitial();
          //here the app will get the animes from the first one in the database
          final animes = await _fetchingAnimes(0  ,  event.searchingText);
          yield AnimeFilteredSuccess(animes: animes, hasReachedMax: false);
          return;
        }
        if (currentState is AnimeFilteredSuccess) {
          final animes = await _fetchingAnimes(currentState.animes.length  , event.searchingText);
          yield (animes.isEmpty)
              ? currentState.copyWith(hasReachedMax: true)
              : AnimeFilteredSuccess(
                  animes: currentState.animes + animes,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield AnimeFailure();
      }
    }
  } 
}