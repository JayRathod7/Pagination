import 'dart:convert';

import 'package:api_testing/model.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiWrapper {
  static String url = "https://jsonplaceholder.typicode.com";

  static Future<List<Model>?> getTodoList(int limit, int page) async {
    String endPoint = "/posts?_page=$page&_limit=$limit";
    Response response = await http.get(Uri.parse(url + endPoint));
    if(response.statusCode == 200  || response.statusCode == 201){
     var json = jsonDecode(response.body);
     List<Model> model = [];
     for (var i in json) {
             model.add(Model.fromJson(i));
           }
     return model;
    }else{
      print("sorry for null value");
      return null;
    }
  }
}
