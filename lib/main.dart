// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:flutter/services.dart';
import 'dart:math';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'flutter_tags - Test'),
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
  double _fontSize = 14;

  String _selectableOnPressed = '';
  String _inputOnPressed = '';

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

    _scrollViewController = ScrollController();
    _inputTags.addAll(
        [
          'exampleTag'
        ]
    );

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
                title: Text("flutter_tags - Test"),
                centerTitle: true,
                pinned: true,
                expandedHeight: 110.0,
                floating: true,
                forceElevated: boxIsScrolled,
              )
            ];
          },
          body:
          ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                                value: _symmetry,
                                onChanged: (a){
                                  setState(() {
                                    _symmetry = !_symmetry;
                                  });
                                }
                            ),
                            Text('Symmetry')
                          ],
                        ),
                        onTap: (){
                          setState(() {
                            _symmetry = !_symmetry;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      DropdownButton(
                        hint: Text(_column.toString()),
                        items: _buildItems(),
                        onChanged: (a) {
                          setState(() {
                            _column = a;
                          });
                        },
                      ),
                      Text("Columns")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                                value: _withSuggesttions,
                                onChanged: (a){
                                  setState(() {
                                    _withSuggesttions = !_withSuggesttions;
                                  });
                                }
                            ),
                            Text('With suggestions')
                          ],
                        ),
                        onTap: (){
                          setState(() {
                            _withSuggesttions = !_withSuggesttions;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Font Size'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Slider(
                            value: _fontSize,
                            min: 6,
                            max: 30,
                            onChanged: (a){
                              setState(() {
                                _fontSize = (a.round()).toDouble();
                              });
                            },
                          ),
                          Text(_fontSize.toString()),
                        ],
                      ),
                    ],
                  ),
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
                      iconBackground: Colors.green[800],
                      lowerCase: true,
                      autofocus: false,
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
                                  color: Colors.black87,fontWeight: FontWeight.w800
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
                        child: Text('Print all Tags'),
                        onPressed: (){
                          _inputOnPressed ='';
                          _inputTags.forEach((tag) =>
                              setState(() {
                                _inputOnPressed+='${tag},\n';
                              })
                          );
                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(_inputOnPressed),
                  ),
                ],
              ),
          )
    );
  }

  ///Random Colors
  Color _color = Color(0xFFFFFFFF);
  final Random _random = Random();

  void _randomColors()
  {
    setState(() {
      _color = Color.fromARGB(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
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