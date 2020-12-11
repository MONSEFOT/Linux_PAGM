class ApiURLs{
  String auth0_url = "https://kitsu.io/api/oauth/token";

  Map<String , String> auth0_body = {
    "grant_type": "password",
    "username": "<email|slug>",
    "password": "<password>" ,// RFC3986 URl encoded string
  };
  

}

