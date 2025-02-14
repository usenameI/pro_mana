

import 'package:flutter/material.dart';

class ExtensionComponent extends StatefulWidget{
  const ExtensionComponent({super.key});

  @override
  State<ExtensionComponent> createState() {
    // TODO: implement createState
    return _ExtensionComponent();
  }
  
}

class _ExtensionComponent extends State<ExtensionComponent> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('隐藏展开选择组件'),centerTitle: true,),
      body: Column(
        children: [
          
        ],
      ),
    );
  }

}