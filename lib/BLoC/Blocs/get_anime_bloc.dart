import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:linux_pagm/APi/api_request.dart';
import 'package:linux_pagm/Anime/anime_event.dart';
import 'package:linux_pagm/Anime/anime_state.dart';
import 'package:linux_pagm/Models/user.dart';
import 'package:linux_pagm/Models/anime.dart';
import 'package:linux_pagm/Resources/api_urls.dart';
import 'package:meta/meta.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final User user;

  AnimeBloc({@required this.user}) : super(AnimeInitial());

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    final currentState = state;
    if (event is AnimeFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is AnimeInitial) {
          final animes = await _fetchAnimes(0, 20, user);
          yield AnimeSuccess(animes: animes, hasReachedMax: false);
          return;
        }
        if (currentState is AnimeSuccess) {
          final animes = await _fetchAnimes(currentState.animes.length, 20, user);
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

  bool _hasReachedMax(AnimeState state) => state is AnimeSuccess && state.hasReachedMax;

  Future<List<Anime>> _fetchAnimes(int startIndex, int limit, User user) async {
    final response =
        await ApiRequest().get(ApiURLs().get_anime_url, true, user.token);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Anime(
          id: rawPost['id'],
          title: rawPost['title'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
