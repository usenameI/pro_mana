
import 'package:flutter/material.dart';

class shadow{
  static BoxShadow defaultShadow= BoxShadow(
                color: Colors.black.withOpacity(0.2), // 阴影颜色
                spreadRadius: 2, // 阴影扩散半径
                blurRadius: 8, // 模糊半径
                offset: const Offset(0, 4), // 阴影偏移
              );
}