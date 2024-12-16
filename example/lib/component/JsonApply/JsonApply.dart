import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_mana/obtainPath/obtainPath.dart';

class Jsonapply extends StatefulWidget{
  const Jsonapply({super.key});
  @override
  State<Jsonapply> createState() {
    // TODO: implement createState
    return _Jsonapply();
  }
  
}
class _Jsonapply extends State<Jsonapply>{
  List AllPage=[];
  var dateFor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       final file = await rootBundle.loadString('assets/appJson.json');
    
       final jsonData = jsonDecode(file);

  final directory = await ObtainPath.getPath();

  print('log__$directory');

  

  // final file = File('${directory.path}/data.json');
  // await file.writeAsString(json.encode(jsonData));

       for(var e in jsonData.entries){
        AllPage.add(e.key);
       }
       setState((){});
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
    Scaffold(
      body:
      Column(children: [
        Expanded(child: 
        Text(dateFor ?? "无")
        ),
      //   Expanded(child: ListView.builder(
      // itemCount: AllPage.length,
      // itemBuilder: (context, index) {
      //   return Text(AllPage[index]);
      // },),),
      Row(children: [
        ElevatedButton(onPressed: () async {
        final directory = await ObtainPath.getPath();
        final file = File('$directory/data.json');
        print('$directory/data.json');
        await file.writeAsString(json.encode(dateFor));
        }, child:const Text('存')),
        ElevatedButton(onPressed: () async {
        final directory = await ObtainPath.getPath();
         final file = File('$directory/data.json');
          dateFor = json.decode(await file.readAsString());
          setState(() {
            
          });
        }, child:const Text('取')),
      ],)
      
      ],)
    
    );
  }
}