import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/Models/user.dart';
import 'package:linux_pagm/Resources/string.dart';
import 'package:linux_pagm/SingIn/user_state.dart';
import 'package:linux_pagm/Utils/storage_on_the_device.dart';

class TokenCheckingAndRefreshing extends Cubit<UserState> {
  String key;
  TokenCheckingAndRefreshing(this.key) : super(null);

  //this method will get the token from the devise storage if it stored defore
  //And then it will refresh the access token and return it
  Future<void> checkingAndRefreshingToken() async {
    emit(UserInitial());

    Map<String, dynamic> tokens = {
      refreshingAccessTokenKey: null,
      accessTokenKey: null
    };

    //getting the token values stored int the user device 
    for (key in tokens.keys) {
      await StorageOnTheDevice().getToken(key).then((token) async {
        if (token.isNotEmpty) {
          tokens[key] = token;
        }
      });
    }

    //if the values stored in the device are not  equeal to null the cubit will return an instanse od User 
    if (tokens[refreshingAccessTokenKey] != null && tokens[accessTokenKey] != null) {
      emit(
        UserSuccess(
          user: User(
              token_type: tokens[tokenTypeKey],
              token: tokens[accessTokenKey],
              refresh_token: tokens[refreshingAccessTokenKey]),
        ),
      );
    } else {

      //here when the condition is fault
      emit(UserFailure());
    }
  }
}
