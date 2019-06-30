
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




class DataSearch {

  static Future<String> getTweeterData(List<String> keywords) async{

    //environemnt token
    String env = "Prod";


    final TwitterLogin twitterLogin
    = new TwitterLogin(consumerKey: '0pR95zNMmWqUqttDPFLtThqsY'
        , consumerSecret: 'X35wuI0KYFoaMxl6opXrqc68NBKQ8eZjzVEyFANWbvTG1EdwoI');


    final twitterResponse = await twitterLogin.authorize();

    final session =  await twitterLogin.currentSession;

    var token = session.token;
    var bytes = utf8.encode(token);
    var base64token = base64.encode(bytes);


    final url = "https://api.twitter.com/1.1/tweets/search/30day/$env.json";
    final auth = {
      HttpHeaders.authorizationHeader : 'Bearer $base64token',
     HttpHeaders.contentTypeHeader : 'application/json'
    };

    final data = {
      "query":"from:TwitterDev lang:en",
      "maxResults": "100",
      "fromDate":"<YYYYMMDDHHmm>",
      "toDate":"<YYYYMMDDHHmm>"
    };

    var jsonBody  = json.encode(data);
    print( "Le retour :" +  auth['authorization']);




    final request = await http.post(url,headers : auth, body:jsonBody);
    print(request.body);
    return session.token;

  }

  static Future<List<Article>> getNewsData(List<String> keywords) async{
      final String key = 'c83a25050dc54eada0e9c6fff9f2ff44'; 
      final String url = 'https://newsapi.org/v2/everything';

      final headers = {
        "x-api-key": '$key'
      };

      final request = await http.post(url,headers: headers,body: 'apiKey=c83a25050dc54eada0e9c6fff9f2ff44');
      final jsonQuery = request.body ;
      final articles = json.decode(jsonQuery);

      List<Article> articleList = new List<Article>();
      for(dynamic article in articles['articles']){
       Article curr = Article.articleFromJson(article);
       articleList.add(curr);
       }

      return articleList;
  }

}