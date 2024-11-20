import 'package:flutter/material.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

///页面自定义组件
class customWidget {
  ///页面主要按钮自定义设计
  static Widget pageMainBt({required Function onTap}) {
    return Positioned(
      left: 10,
      right: 10,
      bottom: 20,
      child: TDButton(
        isBlock: true,
        text: '提交',
        style: TDButtonStyle(
            textColor: Colors.white,
            backgroundColor: const Color.fromRGBO(121, 118, 254, 1)),
        onTap: () => onTap(),
      ),
    );
  }

  ///文本按钮
  static Widget textBt(String name, {required Function onTap}) {
    return TDButton(
      type: TDButtonType.text,
      theme: TDButtonTheme.primary,
      text: name,
      activeStyle:
          TDButtonStyle(textColor: const Color.fromARGB(255, 28, 3, 139)),
      onTap: () => onTap(),
    );
  }

  ///标题栏
  static titleBar(String title,
      {List rightBt = const [], Function(int)? onTap}) {
    return TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: title,
        screenAdaptation: false,
        useDefaultBack: true,
        rightBarItems: rightBt.map((e) {
          return TDNavBarItem(iconWidget: e);
        }).toList());
  }

  ///页面组件
  static pageBody(
      {required String title,
      required Widget child,
      rightBts = const [],
      Function(int)? ontap}) {
    return SafeArea(
        child: Container(
      color: colorUse.bc,
      child: Column(
        children: [
          titleBar(title, rightBt: rightBts, onTap: ontap),
          Expanded(
            child: Container(
              color: colorUse.bc,
              child: child,
            ),
          )
        ],
      ),
    ));
  }
}
