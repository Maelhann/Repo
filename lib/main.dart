// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:flutter/services.dart';
import 'package:repo/data_fetch.dart';
import 'package:repo/newsJson.dart';
import 'dart:math';
import 'package:pie_chart/pie_chart.dart';
import 'package:repo/sentAnalysis.dart';
import 'package:like_button/like_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Welcome to Repo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  bool toggle = false;



  List<Color> colorList = [
    Colors.yellowAccent,
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.blueAccent,
    Colors.deepOrangeAccent,
    Colors.greenAccent
  ];

  Map<String, double> dataMap = new Map();

  final List<String> _list = [
    '0',
    'SDk',
    'plugin updates',
    'Facebook',
    '哔了狗了QP又不够了',
    'Kirchhoff',
    'Italy',
    'France',
    'Spain',
    '美',
    'Dart',
    'Foo',
    'Select',
    'lorem ip',
    '9',
    'Star',
    'Flutter Selectable Tags',
    '1',
    'Hubble',
    '2',
    'Input flutter tags',
    'A B C',
    '8',
    'Android Studio developer',
    'welcome to the jungle',
    'Gauss',
    '美术',
    '互联网',
    '炫舞时代',
    '篝火营地',
  ];

  // TAG VARIABLES
  bool _symmetry = false;
  bool _singleItem = false;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 8;
  double _fontSize = 9;

  String _selectableOnPressed = '';
  String _inputOnPressed = '';
  List<Tag> _selectableTags = [];
  List<String> _inputTags = [];

  // NUMBER OF RESULTS
  Animation<double> animation;
  AnimationController _controller;
  String numRes;

  List _icon = [Icons.home, Icons.language, Icons.headset];

  void initCounter(num totalNumber) {
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: totalNumber.toDouble())
        .animate(_controller)
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation objects value
              numRes = animation.value.toStringAsFixed(0);
            });
          });
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();

    _scrollViewController = ScrollController();

    int cnt = 0;
    _list.forEach((item) {
      _selectableTags.add(Tag(
          id: cnt.toString(),
          title: item,
          active: (_singleItem) ? (cnt == 3 ? true : false) : true,
          icon: (item == '0' || item == '1' || item == '2')
              ? _icon[int.parse(item)]
              : null));
      cnt++;
    });

    _inputTags.addAll(['first tag']);
  }

  void togglePieChart(List<Article> articles) async {
    dataMap = new Map();
    String _corpus = "";

    for (Article a in articles) {
      _corpus += "${a.snippet}";
    }

    final emotional_anal = await DataSearch.analyse(_corpus);
    final analysis = EmotionSet.fromAnalysis(emotional_anal);

    dataMap.putIfAbsent('joy', () => analysis.joy.intensity);
    dataMap.putIfAbsent('anger', () => analysis.anger.intensity);
    dataMap.putIfAbsent('tentativeness', () => analysis.tentative.intensity);
    dataMap.putIfAbsent('sadness', () => analysis.sadness.intensity);
    dataMap.putIfAbsent('confidence', () => analysis.confident.intensity);
    dataMap.putIfAbsent('fear', () => analysis.fear.intensity);

    setState(() {
      if (!toggle) {
        toggle = !toggle;
      }
    });

    initCounter(DataSearch.numRes);
  }

  void processEmotions(var key, var value) {
    print("$value" + '$key');
    dataMap.putIfAbsent(key, () => value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: InputTags(
              tags: _inputTags,
              columns: _column,
              fontSize: _fontSize,
              symmetry: _symmetry,
              color: Colors.blueGrey,
              iconBackground: Colors.blueGrey,
              lowerCase: false,
              autofocus: false,
              placeholder: "Add tags",

              suggestionsList: !_withSuggesttions
                  ? null
                  : [
                      "One",
                      "two",
                      "android",
                      "Dart",
                      "flutter",
                      "test",
                      "tests",
                      "androids",
                      "androidsaaa",
                      "Test",
                      "suggest",
                      "suggestions",
                      "last",
                      "lest"
                    ],

              popupMenuBuilder: (String tag) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text(
                      tag,
                      style: TextStyle(
                          color: _randomColor(), fontWeight: FontWeight.w800),
                    ),
                    enabled: false,
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.content_copy,
                          size: 18,
                        ),
                        Text(" Copy text"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.delete, size: 18),
                        Text(" Remove"),
                      ],
                    ),
                  )
                ];
              },
              popupMenuOnSelected: (int id, String tag) {
                switch (id) {
                  case 1:
                    Clipboard.setData(ClipboardData(text: tag));
                    break;
                  case 2:
                    setState(() {
                      _inputTags.remove(tag);
                    });
                }
              },
              //textFieldHidden: true,
              //boxShadow: [],
              //offset: -2,
              //padding: EdgeInsets.only(left: 11),
              //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              //iconPadding: EdgeInsets.all(5),
              //iconMargin: EdgeInsets.only(right:5,left: 2),
              //borderRadius: BorderRadius.all(Radius.elliptical(50, 5)),
              //onDelete: (tag) => print(tag),
              //onInsert: (tag) => print(tag),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
                child: Text('Analyse'),
                onPressed: () async {
                  final data = await DataSearch.getNewsData(_inputTags);
                  print('${data.length}');
                  togglePieChart(data);
                }),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(_inputOnPressed),
          ),
          Container(
              child: Center(
            child: toggle
                ? PieChart(
                    dataMap: dataMap,
                    legendFontColor: Colors.blueGrey[900],
                    legendFontSize: 14.0,
                    legendFontWeight: FontWeight.w500,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: true,
                    chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
                    colorList: colorList,
                    showLegends: true,
                  )
                : Text(
                    "Repo checks thousands of news outlets and analyzes what"
                    "the public opinion of your tags.",
                    textAlign: TextAlign.center),
          )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'number of sources analyzed : $numRes',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  ///Random Colors
  Color _color = Color(0xFFFFFFFF);
  final Random _random = Random();

//  List<Widget> getArticlesWidgets(List<Article> articles){
//      List<Widget> widgs = new List<Widget>();
//      for(Article a in articles){
//        print("ahahahahah");
//        widgs.add(new ListTile(
//          title: Text(a.title),
//          subtitle: Text(a.author),
//        ));
//      }
//
//      articleWidgets = widgs;
//
//  }

  Color _randomColor() {
    _color = Color.fromARGB(_random.nextInt(256), _random.nextInt(256),
        _random.nextInt(256), _random.nextInt(256));
    return _color;
  }
}
