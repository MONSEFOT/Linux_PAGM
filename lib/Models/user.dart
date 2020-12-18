class User {
  User({this.username , this.password , this.token_type, this.token, this.refresh_token});
  String username;
  String password;
  String token_type;
  String token;
  String refresh_token;

  User.fromJson(Map<String, dynamic> json) {
    User(
      token_type: json["token_type"],
      token : json["token"],
      refresh_token :json["refresh_token"],
    );
  }

  @override
  String toString() {
    return "tokenType: ${this.token_type} , token : ${this.token} , tokenRefresh : ${this.refresh_token}" ;   
  }
}
