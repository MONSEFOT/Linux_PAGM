class User {
  User(this._token_type, this._token, this._refresh_token);
  String _token_type = null;
  String _token = null;
  String _refresh_token = null;

  String get token_type => this._token_type;
  String get token => this._token;
  String get refresh_token => this._refresh_token;

  String setTokenType(String token_type) {
    this._token_type = token_type;
  }

  String setToken(String token) {
    this._token = token;
  }

  String setTokenRefresh(String refresh_token) {
    this._refresh_token = refresh_token;
  }

  User fromJson(Map<String, dynamic> json) {
    return User(
      json["token_type"],
      json["token"],
      json["refresh_token"],
    );
  }
}
