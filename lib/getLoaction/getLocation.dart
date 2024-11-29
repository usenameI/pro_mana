import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

enum SignStrength { none, weak, good, strong }

///定位服务
class getLocation {
  // 检查权限
  static Future<bool> checkqx() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  ///检查手机定位服务是否开启同时开启定位服务
  static Future<bool> checkLocationPermission() async {
    var sta = await Permission.location.status;
    if (sta.isGranted) {
      return true;
    } else {
      var end = await Permission.location.request();
      if (end.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  ///手动打开定位服务功能
  static Future openLocation() async {
    var state = await Permission.location.request();
    if (state == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  // 返回经纬度
  static Future<locationData> getCor({Duration? setTime}) async {
    final LocationSettings locationSettings = AndroidSettings(
      forceLocationManager: true,
      accuracy: LocationAccuracy.best,
    );

    final position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    ///更新卫星状态
    determineSignStrength(position);
    return locationData(
        latitude: position.latitude, longitude: position.longitude);
  }

  ///当前信号状况
  static SignStrength? signStrength=SignStrength.good;

  ///信号强度变化监听开关
  static bool signalStrengthSwitch = false;

  static OverlayEntry? overlayEntry;
  static BuildContext? context; 

  ///判断gps信号强度
  static determineSignStrength(Position p) async {
    var satelliteCount = (p as AndroidPosition).satelliteCount;
    var s;
    if (satelliteCount > 7) {
      s = SignStrength.strong;
    } else if (satelliteCount > 3 && satelliteCount < 8) {
      s = SignStrength.good;
    } else if (satelliteCount > 0 && satelliteCount < 4) {
      s = SignStrength.weak;
    } else if (satelliteCount == 0) {
      s = SignStrength.none;
    }
    if(signStrength!=s){
      if(signStrength!=SignStrength.none&&signStrength!=SignStrength.weak&&s!=SignStrength.good&&s!=SignStrength.strong){
        signStrength=s;
      alertGPS();
      }
      signStrength=s;
      
    }

  

  }

  ///提示gps信号过弱
 static alertGPS(){
  if(overlayEntry!=null){
    return ;
  }
  String content='';
  switch(signStrength){
    case SignStrength.weak:
      content="当前GPS信号弱,请移动到信号强度好的地方";
      case SignStrength.none:
      content="暂无GPS信号,请移动到信号强度好的地方";
      default:
      

  }

   overlayEntry = OverlayEntry(
    builder: (context){
      return Positioned.fill(
        child: Container(
          color: colorUse.maskColor,
          child: Center(child: TDConfirmDialog(
              title: 'GPS信号提示',
              content:content,
              action: () {
                overlayEntry?.remove();
                 overlayEntry=null;
              },
            ),),
      ));
    }
  );

 Overlay.of(context!).insert(overlayEntry!);

  }

  ///开启信号强度变化提示---请放在main方法内
 static setSwitchForSign(bool state,BuildContext contextV) {
    context=contextV;
    signalStrengthSwitch = state;
  }

  ///计算经纬度的距离
  static double getRection({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    double distance = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distance;
  }

  ///米数显示
  static String formatDistance(double meters) {
    if (meters >= 1000) {
      double kilometers = meters / 1000;
      return '${kilometers.toStringAsFixed(2)} 千米'; // 保留两位小数
    } else {
      return '${meters.toStringAsFixed(0)} 米'; // 整数米数
    }
  }

  static Stream<Position>? positionStream;
  static StreamSubscription? subscription;

  ///移动获取经纬度
  static moveGetLo(Function(locationData) callback,
      {required Function(dynamic) onError, required Function() onDone}) {
    var config = AndroidSettings(
      accuracy: LocationAccuracy.medium,
      distanceFilter: 1,
      forceLocationManager: true,
    );
    positionStream = Geolocator.getPositionStream(locationSettings: config);
    subscription = positionStream!.listen((Position position) {
      ///更新卫星状态
      determineSignStrength(position);
      callback(locationData(
          latitude: position.latitude, longitude: position.longitude));
    }, onError: (value) {
      onError(value);
    }, onDone: () {
      onDone();
    });
  }

  ///停止移动获取经纬度
  static stopMoveGetLo() {
    if (subscription != null) {
      subscription?.cancel();
      subscription = null;
    }
  }
}

class locationData {
  double latitude;
  double longitude;
  locationData({
    required this.latitude,
    required this.longitude,
  });
}
