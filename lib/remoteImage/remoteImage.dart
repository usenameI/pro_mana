
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:sensors_plus/sensors_plus.dart';

  enum photoDirection{
    ///左横拍
    left,
    ///右横拍
    right,
    ///竖直拍
    up
  }

class remoteImage {
   static Future<void> start(String imagePath,photoDirection direction) async {
    num remote=0;
      switch(direction){
        case photoDirection.left:
          // TODO: Handle this case.
          remote=-90;
        case  photoDirection.right:
          // TODO: Handle this case.
          remote=90;
        case  photoDirection.up:
        return ;
        default:
        return ;
      }
      img.Image? _rotatedImage;
    // 读取图像文件
    final file = File(imagePath);
    final imageBytes = await file.readAsBytes();
    
    // 解码图像
    img.Image originalImage = img.decodeImage(imageBytes)!;

    // 旋转图像（顺时针旋转90度）
    _rotatedImage = img.copyRotate(originalImage, angle: remote);

    // 保存旋转后的图像
    final rotatedImageBytes = img.encodeJpg(_rotatedImage);
    await file.writeAsBytes(rotatedImageBytes);

  }
}
// 重力感应器组件
class camreaDirection extends StatefulWidget{
  Function(photoDirection) callback;
  camreaDirection({
    required this.callback
  });
  @override
  State<camreaDirection> createState() {
    // TODO: implement createState
    return _camreaDirection();
  }
}

class _camreaDirection extends State<camreaDirection>{
    final _streamSubscriptions = <StreamSubscription<dynamic>>[];
      AccelerometerEvent? _accelerometerEvent;
      var _orientation;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _streamSubscriptions.add(
      accelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen(
        (AccelerometerEvent event) {
          _detectOrientation(event);
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Accelerometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }

      void _detectOrientation(AccelerometerEvent event) {
    // 根据重力传感器的值判断方向
    if (event.x.abs() > event.y.abs()) {
      // 横屏
        setState(() {
          _orientation = event.x > 0 ? "左" : "右";
          textAngle = event.x > 0 ? 1.57 : -1.57;
          widget.callback(event.x > 0?photoDirection.left:photoDirection.right);
        });
    } else {
      // 竖屏
      setState(() {
        _orientation = event.y > 0 ? "上" : "下";
        textAngle=0;
          widget.callback(photoDirection.up);
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
  ///文本旋转角度
  double textAngle=0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child:
    Center(child: 
    Transform.rotate(angle: textAngle,child:const Text('相册',style: TextStyle(color: Colors.white),),)
    )
     ,);
  }

}



///重力感应器判断状态
class phoneState {
  double angle=0;
final streamSubscriptions = <StreamSubscription<dynamic>>[];
  addListen(Function(double) callback){
  streamSubscriptions.add(
      accelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen(
        (AccelerometerEvent event) {
           // 根据重力传感器的值判断方向
    if (event.x.abs() > event.y.abs()) {
      // 横屏
        event.x > 0 ? {
          callback(1.57),
          angle=1.57} :{
            callback(-1.57),angle=-1.57};
    } else {
      // 竖屏
        callback(0);
        angle=0;
    }
        },
        cancelOnError: true,
      ),
    );
  }

  // 照片旋转
 Future<void> imagePro(path)async{
        photoDirection pDir=photoDirection.up;
    if(angle==1.57){
      pDir=photoDirection.left;
    }else if(angle==-1.57){
      pDir=photoDirection.right;
    }
   await remoteImage.start(path, pDir);
  }

}