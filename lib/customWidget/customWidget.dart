
import 'package:flutter/material.dart';

import 'package:tdesign_flutter/tdesign_flutter.dart';

class customWidget {
  ///页面主要按钮自定义设计
 static Widget pageMainBt({
    required Function onTap
  }){
   return  Positioned(
      left: 10,
      right: 10,
      bottom: 20,
      child: TDButton(
        isBlock: true,
        text: '提交',
        style: TDButtonStyle(
            textColor: Colors.white,
            backgroundColor: const Color.fromRGBO(121, 118, 254, 1)),
        onTap: ()=>onTap(),
      ),
    );
  }

}