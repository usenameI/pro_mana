
  import 'dart:ui';

import 'package:tdesign_flutter/tdesign_flutter.dart';


// 主题颜色设置
class colorUse{
  //主题颜色
 static Color themeC=const Color.fromRGBO(108, 129, 254, 1);
  ///树状组件左边颜色
 static Color treeLeft =const Color.fromARGB(255, 243, 243, 243);
  ///背景颜色
 static Color bc = const Color.fromRGBO(245, 246, 249, 1);
  ///成功状态：通常代表成功或完成
 static Color successColor=const Color(0xFF7ED321);
  ///进行中状态：表示正在进行的任务
 static Color progress=const Color(0xFFF5A623);
  ///紧急状态：用于紧急或需要立即关注的状态
 static Color emergency=const Color(0xFFD0021B);
  ///未开始状态：表示未开始或无效的状态
 static Color notStarted=const Color(0xFF979797);
  ///暂停状态：常用于暂停或等待的状态
 static Color pause=const Color(0xFF4A90E2);
  ///待审核状态：可以表示需要审核或确认的状态
 static Color audit=const Color(0xFF9013FE);
  ///已取消状态：用于表示已取消的状态
 static Color haveCanceled=const Color(0xFFC0392B);
  ///已过期状态：表示已过期的状态
 static Color haveExpired=const Color(0xFF7F8C8D);
  ///待处理状态：通常用于待处理或需要注意的状态
 static Color awaitHandle=const Color(0xFFF1C40F);
  ///已完成状态：可以表示已完成的状态
 static Color haveCompleted=const Color(0xFF1ABC9C);
  ///其他颜色
  static Color other=const Color.fromARGB(255, 165, 165, 165);

  ///TDesign的light风格背景颜色
static Color lightColor(context){
  return TDTheme.of(context).brandFocusColor;
}

}

// 绿色：通常代表成功或完成。
// 橙色：表示正在进行的任务。
// 红色：用于紧急或需要立即关注的状态。
// 灰色：表示未开始或无效的状态。
// 蓝色：常用于暂停或等待的状态。
// 紫色：可以表示需要审核或确认的状态。
// 深红色：用于表示已取消的状态。
// 暗灰色：表示已过期的状态。
// 黄色：通常用于待处理或需要注意的状态。
// 青色：可以表示已完成的状态。