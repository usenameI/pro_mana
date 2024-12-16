


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CarouseViewTest extends StatefulWidget{
  const CarouseViewTest({super.key});
  @override
  State<CarouseViewTest> createState() {
    // TODO: implement createState
    return _CarouseViewTest();
  }
  
}

class _CarouseViewTest extends State<CarouseViewTest>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CarouselView(
        // flexWeights: [1, 7, 1],
        itemSnapping:true,
        itemExtent: 100,
        shrinkExtent: 100, // 设置收缩的宽度
        children: [
          Container(color: Colors.red, child:const Center(child: Text('Item 1'))),
          Container(color: Colors.green, child:const Center(child: Text('Item 2'))),
          Container(color: Colors.blue, child:const Center(child: Text('Item 3'))),
            Container(color: Colors.blue, child:const Center(child: Text('Item 3'))),
              Container(color: Colors.blue, child:const Center(child: Text('Item 3'))),
                Container(color: Colors.blue, child:const Center(child: Text('Item 3'))),
        ],
      ),
    );
  }
  
}