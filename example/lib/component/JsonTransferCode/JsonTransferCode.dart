import 'package:flutter/material.dart';

class JsonTransferCode extends StatefulWidget{
 const JsonTransferCode({super.key});
  @override
  State<JsonTransferCode> createState() {
    // TODO: implement createState
    return _JsonTransferCode();
  }


  
}
class _JsonTransferCode extends State<JsonTransferCode>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: 
      
      
      Column(children: [
        
      ],),
    );
  }
  String jsonData = '''{
  "type": "_JsonColumnBuilder",
  "args": {
    "children": [
      {
        "type": "Text",
        "args": {
          "text": "Hello, World!",
          "style": {
            "fontSize": 24.0,
            "fontWeight": "bold",
            "color": "#FF0000"
          }
        }
      },
      {
        "type": "Text",
        "args": {
          "text": "This is a dynamic demo.",
          "style": {
            "fontSize": 18.0,
            "color": "#00FF00"
          }
        }
      }
    ]
  }
}''';
}