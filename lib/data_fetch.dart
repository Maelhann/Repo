import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:repo/newsJson.dart';
import 'package:repo/sentAnalysis.dart';


class DataSearch {
  static num numRes = 0;

  static Future<EmotionalAnalysis> analyse(String body) async {
    final String userPass =
        "apikey:X0CnXwe429eh-ZgHkiduRutrd3DjP3x0kFH9qVovE4ze";
    final String args = '/v3/tone?version=2017-09-21&text=';
    final String bodyUri = Uri.encodeFull(body);
    final String url =
        'https://$userPass@gateway-lon.watsonplatform.net/tone-analyzer/api$args$bodyUri';

    final response = await http.get(url);
    final responseJson = json.decode(response.body); // different body

    print('\n\n');

    EmotionalAnalysis analysis = EmotionalAnalysis.fromJson(responseJson);
    return analysis;
  }



//  static Future<String> getTweeterData(List<String> keywords) async {
//    //environemnt token
//    String env = "Prod";
//
//    final TwitterLogin twitterLogin = new TwitterLogin(
//        consumerKey: '0pR95zNMmWqUqttDPFLtThqsY',
//        consumerSecret: 'X35wuI0KYFoaMxl6opXrqc68NBKQ8eZjzVEyFANWbvTG1EdwoI');
//
//    final twitterResponse = await twitterLogin.authorize();
//
//    final session = await twitterLogin.currentSession;
//
//    var token = session.token;
//    var bytes = utf8.encode(token);
//    var base64token = base64.encode(bytes);
//
//    final url = "https://api.twitter.com/1.1/tweets/search/30day/$env.json";
//    final auth = {
//      HttpHeaders.authorizationHeader: 'Bearer $base64token',
//      HttpHeaders.contentTypeHeader: 'application/json'
//    };
//
//    final data = {
//      "query": "from:TwitterDev lang:en",
//      "maxResults": "100",
//      "fromDate": "<YYYYMMDDHHmm>",
//      "toDate": "<YYYYMMDDHHmm>"
//    };
//
//    var jsonBody = json.encode(data);
//    print("Le retour :" + auth['authorization']);
//
//    final request = await http.post(url, headers: auth, body: jsonBody);
//    print(request.body);
//    return session.token;
//  }


  static Future<List<Article>> getNewsData(List<String> keywords) async {
    final String key = 'c83a25050dc54eada0e9c6fff9f2ff44';
    String bodyUri = '${keywords[0]}';

    for(String s in keywords){
      bodyUri += "+$s";
    }
    final String url = ('https://newsapi.org/v2/everything?q=$bodyUri');

    final headers = {"x-api-key": '$key'};



    final request = await http.get(url, headers: headers);
    final jsonQuery = request.body;
    print(request.body);
    final Map<String, dynamic> articles = json.decode(jsonQuery);


    List<Article> articleList = new List<Article>();


    final allArticlesJson = articles['articles'] as List;
    numRes = articles['totalResults'];

    for (dynamic article in allArticlesJson) {
      Article curr = Article.articleFromJson(article);
      articleList.add(curr);
    }


    return articleList;
  }


  // we now have articles as a list of objects
  // each with their own emotional analysis. La chance !!


}
