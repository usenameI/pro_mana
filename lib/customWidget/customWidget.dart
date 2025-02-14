import 'package:flutter/material.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:pro_mana/tool/tool.dart';
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
      {List rightBt = const [], Function(int)? onTap,required Function() exit}) {
    return 
    Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10),
      child: TDNavBar(
      padding: EdgeInsets.all(0),
      leftBarItems:[
        TDNavBarItem(
          iconWidget: TDButton(
            style: TDButtonStyle(
              backgroundColor: Colors.white
            ),
            onTap: () {
              exit();
            },
            child: Icon(Icons.arrow_back_ios_new),
          )
        )
      ],
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: title,
        screenAdaptation: false,
        useDefaultBack: false,
        rightBarItems: rightBt.map((e) {
          return TDNavBarItem(iconWidget: e);
        }).toList()),
    )
    ;
  }
  ///页面组件
  static pageBody(
      {required String title,
      required Widget child,
      rightBts = const [],
      Function(int)? ontap,
      required Function() exit
      }) {
    return SafeArea(
        child: Container(
      color: colorUse.bc,
      child: Column(
        children: [
          titleBar(title, rightBt: rightBts, onTap: ontap,exit:exit),
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

///custom widget do dismiss keyboard for [Container]
class CContainer extends StatelessWidget {
  CContainer(
      {super.key,
      this.keys,
      this.alignment,
      this.padding,
      this.color,
      this.decoration,
      this.foregroundDecoration,
      this.width,
      this.height,
      this.constraints,
      this.margin,
      this.transform,
      this.transformAlignment,
      this.child,
      this.clipBehavior = Clip.none});
  Key? keys;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  Color? color;
  Decoration? decoration;
  Decoration? foregroundDecoration;
  double? width;
  double? height;
  BoxConstraints? constraints;
  EdgeInsetsGeometry? margin;
  Matrix4? transform;
  AlignmentGeometry? transformAlignment;
  Widget? child;
  Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Tool.dismissKeyboardWhenClick(
        child: Container(
      key: keys,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    ));
  }
}

///custom widget do dismiss keyboard for [SizedBox]
class CSizedBox extends StatelessWidget {
  CSizedBox({super.key, this.keys, this.width, this.height, this.child});
  Key? keys;
  double? width;
  double? height;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Tool.dismissKeyboardWhenClick(
        child: SizedBox(
      key: keys,
      width: width,
      height: height,
      child: child,
    ));
  }
}

///custom widget do dismiss keyboard for [Column]
class CColumn extends StatelessWidget {
  CColumn({
    super.key,
    this.keys,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
  });

  Key? keys;
  MainAxisAlignment mainAxisAlignment;
  MainAxisSize mainAxisSize;
  CrossAxisAlignment crossAxisAlignment;
  TextDirection? textDirection;
  VerticalDirection verticalDirection;
  TextBaseline? textBaseline;
  List<Widget> children;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Tool.dismissKeyboardWhenClick(
        child: Column(
      key: keys,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      textBaseline: textBaseline,
      children: children,
    ));
  }
}

///custom widget do dismiss keyboard for [Row]
class CRow extends StatelessWidget{
  CRow({
    super.key,
    this.keys,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
  });
  Key? keys;
  MainAxisAlignment mainAxisAlignment;
  MainAxisSize mainAxisSize;
  CrossAxisAlignment crossAxisAlignment;
  TextDirection? textDirection;
  VerticalDirection verticalDirection;
  TextBaseline? textBaseline;
  List<Widget> children;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Tool.dismissKeyboardWhenClick(child: Row(
      key:keys,
      mainAxisAlignment:mainAxisAlignment,
      mainAxisSize:mainAxisSize,
      crossAxisAlignment:crossAxisAlignment,
      textDirection:textDirection,
      verticalDirection:verticalDirection,
      textBaseline:textBaseline,
      children:children,
    ));
  }
  
}


class customStep{
 static Widget show(List<TDStepsItemData> steps){
    return TDSteps(
              steps:steps,
              direction: TDStepsDirection.vertical,
              activeIndex: 2,
              readOnly: true,
              verticalSelect: false,);
  }
}

