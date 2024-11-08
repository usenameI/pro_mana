import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class secondTime extends StatefulWidget {  
  Function callBack;
  int setSecond;
  secondTime({
     this.setSecond=10,
    required this.callBack
  });
  @override  
  _MyAppState createState() => _MyAppState();  
}  
  
class _MyAppState extends State<secondTime> {  
   DateTime? startTime;    
  Timer? time;
  int init=0;
  void startLoading() {  
    // 记录开始时间  
    startTime = DateTime.now();  
    time=Timer.periodic(const Duration(seconds: 1), (timer) {
      
      init++;
      if(init==widget.setSecond){
        widget.callBack(true);
      }
      setState((){});
     });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startLoading();
     });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(time!=null){
      time!.cancel();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TDText('累计时间: ${init}秒');
  }  
  
  
}