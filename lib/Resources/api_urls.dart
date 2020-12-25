class ApiURLs{
  String auth0_url = "https://kitsu.io/api/oauth/token";

  Map<String , String> auth0_body = {
    "grant_type": "password",
    "username": "<email|slug>",
    "password": "<password>" ,// RFC3986 URl encoded string
  };

  Map<String , String> auth0_refreshing_body = {
    "grant_type" : "refresh_token",
    "refresh_token" : "<refresh_token>",
  };

  String get_anime_url= "https://kitsu.io/api/edge/anime";
  

}

