import 'package:http/http.dart' as https;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

Future getNews() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("here");
  try{
    var response = await https.get(
        Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2ab0aa83716547e2b98c53f768f0e98c")
    );
    if(response.body.isNotEmpty) {
      prefs.setString('/News', response.body);
      print("saved");
      return response.body;
    }
  } on SocketException catch (_) {
    print("eeor");
    return prefs.getString("/News");
  }
}