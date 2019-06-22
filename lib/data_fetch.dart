
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


class DataSearch {

  static Future<String> getTweeterData(List<String> keywords) async{
    String apiKey = "IKIIecQL9sr0VUwhMVHE9Db9h ";
    String accessToken = '1142537491192406016-EWGBLYGD6sTf57fNBt984Y1anood0M';
    String env = "Prod";


    final url = "https://api.twitter.com/1.1/tweets/search/30day/$env.json";
    final auth = {
      'authorization' : 'Bearer $accessToken',
      'content-type' : 'application/json'
    };


    final request = await http.post(url,headers : auth);

    return request.body;

  }

  Future<String> getNewsData(List<String> keywords) async{
    //TODO ma bonne race
  }

}