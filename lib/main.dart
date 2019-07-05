// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:flutter/services.dart';
import 'package:repo/data_fetch.dart';
import 'dart:math';
import 'package:pie_chart/pie_chart.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget
{
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


class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin
{
  TabController _tabController;
  ScrollController _scrollViewController;
  bool toggle = false;

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  Map<String, double> dataMap = new Map();

  final List<String> _list = [
    '0','SDk','plugin updates','Facebook','哔了狗了QP又不够了',
    'Kirchhoff','Italy','France','Spain','美','Dart','Foo','Select','lorem ip','9',
    'Star','Flutter Selectable Tags','1','Hubble','2','Input flutter tags','A B C','8','Android Studio developer','welcome to the jungle','Gauss',
    '美术',
    '互联网',
    '炫舞时代',
    '篝火营地',
  ];

  bool _symmetry = false;
  bool _singleItem = false;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 8;
  double _fontSize = 22;

  String _selectableOnPressed = '';
  String _inputOnPressed = '';

  List<Tag> _selectableTags = [];
  List<String> _inputTags = [];

  List _icon=[
    Icons.home,
    Icons.language,
    Icons.headset
  ];


  @override
  void initState()
  {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _scrollViewController = ScrollController();

    int cnt = 0;
    _list.forEach((item)
    {
      _selectableTags.add (
          Tag (id: cnt.toString(),
              title: item,
              active: (_singleItem) ? ( cnt==3 ? true:false ) : true,
              icon: (item == '0' || item == '1' || item == '2') ?
              _icon[ int.parse (item
              ) ] : null
          )
      );
      cnt++;
    }
    );

    _inputTags.addAll(
        [
          'first tag'
        ]
    );


    dataMap.putIfAbsent("Flutter", () => 5);
    dataMap.putIfAbsent("React", () => 3);
    dataMap.putIfAbsent("Xamarin", () => 2);
    dataMap.putIfAbsent("Ionic", () => 2);
  }


  void togglePieChart() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context,bool boxIsScrolled){
            return <Widget>[
              SliverAppBar(
                title: Text("Repo"),
                centerTitle: true,
                pinned: true,
                backgroundColor: Colors.purple,
                expandedHeight: 110.0,
                floating: true,
                forceElevated: boxIsScrolled,
              )
            ];
          },
          body:
          ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    child:
                    InputTags(
                      tags: _inputTags,
                      columns: _column,
                      fontSize: _fontSize,
                      symmetry: _symmetry,
                      color: Colors.deepPurpleAccent,
                      iconBackground: Colors.deepPurpleAccent,
                      lowerCase: false,
                      autofocus: false,
                      placeholder: "Add tags",

                      suggestionsList: !_withSuggesttions ? null :
                      [
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

                      popupMenuBuilder: (String tag){
                        return <PopupMenuEntry>[
                          PopupMenuItem(
                            child: Text(tag,
                              style: TextStyle(
                                  color: _randomColor(),fontWeight: FontWeight.w800
                              ),
                            ),
                            enabled: false,
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.content_copy,size: 18,),
                                Text(" Copy text"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.delete,size: 18),
                                Text(" Remove"),
                              ],
                            ),
                          )
                        ];
                      },
                      popupMenuOnSelected: (int id,String tag){
                        switch(id){
                          case 1:
                            Clipboard.setData( ClipboardData(text: tag));
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
                        onPressed: (){
                          //DataSearch.analyzeArticles(_inputTags);
                          togglePieChart();
                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(_inputOnPressed),
                  ),
                  Container(
                    child:
                    Center(
                      child : toggle ? PieChart(
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
                        : Text("Show analysis of keywords here"),
                  )
                  )
                ],
              ),

          )
    );
  }




  ///Random Colors
  Color _color = Color(0xFFFFFFFF);
  final Random _random = Random();

  Color _randomColor()
  {

      _color = Color.fromARGB(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256));

    return _color;

  }

  List<DropdownMenuItem> _buildItems()
  {
    List<DropdownMenuItem> list = [];

    int count = 19;

    for(int i = 1; i < count; i++)
      list.add(
        DropdownMenuItem(
          child: Text(i.toString() ),
          value: i,
        ),
      );

    return list;
  }
}