import 'package:repo/sentAnalysis.dart';
import 'package:repo/data_fetch.dart';
import 'package:flutter/material.dart';


class Article extends StatelessWidget {
  final String content;
  final String dateTime;
  final String snippet;
  final dynamic source;
  final String title;
  final String author;
  EmotionSet analysis = null;

  Article(this.content, this.dateTime, this.snippet, this.source, this.title,
      this.author);

  static Article articleFromJson(Map<String, dynamic> articleData) {
    String content = articleData['content'];
    String date = articleData['publishedAt'];
    String snippet = articleData['description'];
    dynamic source = articleData['source'];
    String title = articleData['title'];
    String author = articleData['author'];
    return new Article(content, date, snippet, source, title, author);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(padding:
        const EdgeInsets.all(16.0),
            child: Text(title, style: TextStyle(fontSize: 22.0))
        )
    );
  }


}


