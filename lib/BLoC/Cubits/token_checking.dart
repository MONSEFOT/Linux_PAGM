import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/BLoC/Enums/cheking_token_and_signing_out_operations.dart';
import 'package:linux_pagm/BLoC/Enums/error_type.dart';
import 'package:linux_pagm/Models/user.dart';
import 'package:linux_pagm/Resources/string.dart';
import 'package:linux_pagm/SingIn/user_event.dart';
import 'package:linux_pagm/SingIn/user_state.dart';
import 'package:linux_pagm/Utils/storage_on_the_device.dart';

class TokenCheckingAndSingOut extends Cubit<UserState> {
  TokenCheckingAndSingOut({ChekingTokenAndSigningOutOperations operation , UserEvent event}) : super(null){
    if(operation == ChekingTokenAndSigningOutOperations.chekingToken){
      _checkingToken();
    }
    else{
      _signingOut(event);
    }
  }

  //this method will get the token from the devise storage if it stored defore
  //And then it will refresh the access token and return it
  Future<void> _checkingToken() async {
    try {
      emit(UserInitial());

      Map<String, dynamic> tokens = {
        refreshingAccessTokenKey: null,
        accessTokenKey: null
      };

      //getting the token values stored int the user device
      for (String key in tokens.keys) {
        await StorageOnTheDevice().getToken(key).then((token) async {
          if (token.isNotEmpty) {
            tokens[key] = token;
          }
        });
      }

      //if the values stored in the device are not  equeal to null the cubit will return an instanse od User
      if (tokens[refreshingAccessTokenKey] != null &&
          tokens[accessTokenKey] != null) {
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
    } on ConnectionState {
      emit(UserFailure(error: ErrorType.connection));
    } catch (error) {
      //if that is a problem in the operation the stream witl return a UserFailure as an error
      emit(UserFailure(error: ErrorType.otherProblem));
    }
  }

  //signin out methode will remove the tokens witch are stored in the user device 
  // and return a sign out error for changing to the signing in screen 
  Future<void> _signingOut(UserEvent event) async {
    if (event is UserSigningOut && event.keys != null && event.user != null) {
      try {
        //intialization state
        emit(UserInitial());

        //removing tokens from the device 
        bool is_signed_out = await _removingDataFromTheDevice(event.keys);

        if (is_signed_out) {
          emit(UserFailure(error: ErrorType.userSigningOut));
        } else {
          emit(UserSuccess(user: event.user));
        }
      } on ConnectionState {
        emit(UserFailure(error: ErrorType.connection));
      } catch (error) {
        //if that is a problem in the operation the stream witl return a UserFailure as an error
        emit(UserFailure(error: ErrorType.otherProblem));
      }
    }
  }

  Future<bool> _removingDataFromTheDevice(List<String> keys) async {
    bool is_signed_out;
    for (String key in keys) {
      await StorageOnTheDevice()
          .removeToken(key)
          .then((isDeleted) => is_signed_out = is_signed_out && isDeleted);
    }

    return is_signed_out;
  }
}
