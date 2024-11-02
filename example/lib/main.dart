import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pro_mana/pro_mana.dart';
import 'package:pro_mana/simple_text_plugin.dart';

void main() {
  runApp( home());
}

class home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MyApp(),
    );
  }
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

var s;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(SimpleTextPlugin.getText()),
      ),
    );
  }

}
