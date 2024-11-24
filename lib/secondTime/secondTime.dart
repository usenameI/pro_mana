import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class StopController {
  int init = 0;
  Stop? stop;
  DateTime? startTime;
  Timer? time;

  void startT() {
    // 记录开始时间
    startTime = DateTime.now();
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      init++;
      stop?.notifyListeners();
    });
  }

  void stopT() {
    if (time != null) {
      time!.cancel();
    }
  }
}

class Stop extends ChangeNotifier {}

class stopWatch extends StatelessWidget {
  StopController stopController;
  stopWatch({super.key, required this.stopController});
  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600; // 计算小时
    int minutes = (seconds % 3600) ~/ 60; // 计算分钟
    int secs = seconds % 60; // 计算剩余秒数
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (context) => Stop(),
        child: Consumer<Stop>(
          builder: (context, value, child) {
            stopController.stop = value;
            return TDText(formatDuration(stopController.init));
          },
        ));
  }
}

class secondTime extends StatefulWidget {
  Function callBack;
  int setSecond;
  secondTime({this.setSecond = 10, required this.callBack});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<secondTime> {
  DateTime? startTime;
  Timer? time;
  int init = 0;
  void startLoading() {
    // 记录开始时间
    startTime = DateTime.now();
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      init++;
      if (init == widget.setSecond) {
        widget.callBack(true);
      }
      setState(() {});
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
    if (time != null) {
      time!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TDText('累计时间: ${init}秒');
  }
}
