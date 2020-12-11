import 'package:linux_pagm/Model/User.dart';

import 'api_request.dart';
import 'package:linux_pagm/Resources/api_urls.dart';


class Authentication{

  //the sign in methode here is just with email and password
  Future<User> signIn(String email , String password)async{
    var body = ApiURLs().auth0_body;
    
    body["username"] = email;
    body["password"] = password;

    var response = await ApiRequest().post(ApiURLs().auth0_url, body);

     if(response != null){
       return new User(response["token_type"],response["access_token"] , response["refresh_token"]);
    }
  }
}