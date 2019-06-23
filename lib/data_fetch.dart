
import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_twitter_login/flutter_twitter_login.dart';




class DataSearch {

  static Future<String> getTweeterData(List<String> keywords) async{
    String apiKey = "IKIIecQL9sr0VUwhMVHE9Db9h";
    String secApiKey = "l2EwmYc79GRXInONYN3papcykFLLMHwiQCLNDekeOa22V6QksJ";

    String accessToken = '1142537491192406016-EWGBLYGD6sTf57fNBt984Y1anood0M';
    String env = "Prod";
    
    final TwitterLogin twitterLogin
    = new TwitterLogin(consumerKey: 'IKIIecQL9sr0VUwhMVHE9Db9h'
        , consumerSecret: 'l2EwmYc79GRXInONYN3papcykFLLMHwiQCLNDekeOa22V6QksJ');

    final twitterResponse = await twitterLogin.authorize();

    final session =  await twitterLogin.currentSession;
    print(session.token);


    final url = "https://api.twitter.com/1.1/tweets/search/30day/$env.json";
    final auth = {
      'authorization' : 'Bearer ${session.token}',
      'content-type' : 'application/json'
    };

    final data = {
      "query":"from:TwitterDev lang:en",
      "maxResults": "100",
      "fromDate":"<YYYYMMDDHHmm>",
      "toDate":"<YYYYMMDDHHmm>"
    };


    print( "Le retour :" +  auth['authorization']);




    final request = await http.post(url,headers : auth, body:data);
    print(request.body);
    return session.token;

  }

  Future<String> getNewsData(List<String> keywords) async{
    // api key c83a25050dc54eada0e9c6fff9f2ff44
    // use curl as always.
  }

}