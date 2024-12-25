

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_mana_example/Sample.dart';
// import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:pro_mana_example/pageSample.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      home: list(),
    );
  }
  
}


class list extends StatefulWidget{
  const list({super.key});
  @override
  State<list> createState() {
    // TODO: implement createState
    return _list();
  }
  
}

class _list extends State<list>{

  List<Sample> items=[];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
    final jsonString = await rootBundle.loadString('assets/appJson.json');
    final sampleData = jsonDecode(jsonString);
        for (final s in sampleData.entries) {
      items.add(Sample.fromJson(s.value));
    }
    setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('sample'),),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
        return 
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageSample(sample: items[index]),
                ),
              );
          },
          child: Container(
          padding:const EdgeInsets.all(10),
          child: Center(child: Text(items[index].title),),
        ),
        )
        
        
         ;
      },),
    );
  }
  
}
