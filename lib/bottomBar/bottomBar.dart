import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pro_mana/style/color/colorUse.dart';

class bottomBarConfig{
  String title;
  IconData icon;
  bool renew;
  bottomBarConfig({
    required this.title,
    required this.icon,
    required this.renew
  });
}

class bottomBar{
  static homeBottomBar({required List<bottomBarConfig> list, required Function(int) onTap}) {
    return ConvexAppBar(
      backgroundColor: PairWithWhite.hjl,
      style: TabStyle.react,
      items: 
      list.map((e){
        return TabItem(
            icon:e.icon,
            title: e.title);
      }).toList() ,
    
      onTap: (int i) => onTap(i),
    );
  }
}
