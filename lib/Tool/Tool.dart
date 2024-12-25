

import 'package:flutter/material.dart';

///tool class
class Tool {
  /// create a listen to dismiss keyboard when click the blank.
  /// 
  /// you can put your [Widget] into [child] of [dismissKeyboardWhenClick] to achieve this feature.
 static Widget dismissKeyboardWhenClick({
    required Widget child
  }){
    return Listener(
                onPointerDown: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: child,
                );
  }
}

