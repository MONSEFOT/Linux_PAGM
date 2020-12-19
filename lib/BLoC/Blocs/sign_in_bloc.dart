import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linux_pagm/APi/api_request.dart';
import 'package:linux_pagm/BLoC/Enums/error_type.dart';
import 'package:linux_pagm/Models/user.dart';
import 'package:linux_pagm/Resources/api_urls.dart';
import 'package:linux_pagm/Resources/string.dart';
import 'package:linux_pagm/SingIn/user_event.dart';
import 'package:linux_pagm/SingIn/user_state.dart';
import 'package:linux_pagm/Utils/storage_on_the_device.dart';

class SignInBloc extends Bloc<UserEvent, UserState> {
  SignInBloc() : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    //when the operation is a sign in and the requirements are not null
    //the operation will start afterthat the stream will return a User Object
    if (event is UserSigningIn && event.inputs.isNotEmpty) {
      try {
        //intialization state
        yield UserInitial();

        //sing in proccess
        User user = await _signingIn(event.inputs["username"], event.inputs["password"]);

        //yield UserSuccess(user: user, userNotFound: false);
        //this function will run before the returning for passing data to Home screen
        if (user != null) {
          //saving the access token refresh
          StorageOnTheDevice()
              .saveRefreshToken(refreshingAccessTokenKey, user.refresh_token);
          //saving the access token
          StorageOnTheDevice().saveRefreshToken(accessTokenKey, user.token);
          yield UserSuccess(user: user);
          return;
        } else {
          yield UserFailure(error: ErrorType.userInformations);
          return;
        }
      } on ConnectionState {
        yield UserFailure(error: ErrorType.connection);
        return;
      } catch (error) {
        //if that is a problem in the operation the stream witl return a UserFailure as an error
        yield UserFailure(error: ErrorType.otherProblem);
        return;
      }
    } 
  }
}

//the sign in methode here is just with email and password
Future<User> _signingIn(String email, String password) async {
  var body = ApiURLs().auth0_body;

  body["username"] = email;
  body["password"] = password;

  var response = await ApiRequest().post(ApiURLs().auth0_url, body);

  if (response != null) {
    return User(
        token_type: response[tokenTypeKey],
        token: response[accessTokenKey],
        refresh_token: response[refreshingAccessTokenKey]);
  }
}


