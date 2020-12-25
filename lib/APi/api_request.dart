import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRequest {

  //POST resuest will return a Map<String , String> response body 
Future<Map<String , dynamic>> post(String url , Map<String , dynamic> body , [bool authorization = false, String token]) async{
    final response = await http.post(
      Uri.encodeFull(url),
      headers : (authorization)? <String , String>{
        "Accept": "application/vnd.api+json",
        "Content-Type" : "application/vnd.api+json",
        //The account's access token
        "Authorization": "Bearer $token",
      } : null ,
      body: (authorization) ? jsonEncode(body) : body,
    );

    if(response.statusCode == 200){
      Map<String , dynamic> result = jsonDecode(response.body);
      return result;
    }
  } 

  //The same of Post method with get  mesthod
 get(String url ,[bool authorization = false, String token]) async{
    final response = await http.get(
      Uri.encodeFull(url),
      headers : (authorization)? <String , String>{
        "Accept": "application/vnd.api+json",
        "Content-Type" : "application/vnd.api+json",
        //The account's access token
        "Authorization": "Bearer $token",
      } : null ,
    );

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      return result;
    }
  }
}