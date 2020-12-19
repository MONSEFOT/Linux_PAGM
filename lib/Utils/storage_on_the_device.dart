import 'package:shared_preferences/shared_preferences.dart';

class StorageOnTheDevice{
  SharedPreferences _shared_preferences ;

  Future<bool> saveRefreshToken(String key, String value) async{
    bool token_is_saved = false;
    _shared_preferences = await SharedPreferences.getInstance();
    await _shared_preferences.setString(key, value).then((isSaved) =>  token_is_saved = isSaved);
    return token_is_saved;
  }

  Future<String> getToken(String key) async {
    _shared_preferences = await SharedPreferences.getInstance();
    String token = _shared_preferences.getString(key);
    return (token != null)? token : "";
  }

  Future<bool> removeToken(String key) async{
    bool token_is_deleted = false;
    _shared_preferences = await SharedPreferences.getInstance();
    await _shared_preferences.remove(key).then((isDeleted) => token_is_deleted = isDeleted);
    return token_is_deleted;
  }
}