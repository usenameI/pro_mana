import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:coordtransform_dart/coordtransform_dart.dart';

  Duration showTime=const Duration(milliseconds: 300);

/// 高德地图调用
Future openAmap(context, dynamic longitude, dynamic latitude,
    {required address, bool showErr = true}) async {
      List los = CoordinateTransformUtil.wgs84ToGcj02(double.parse(longitude), double.parse(latitude));

 
  if(Platform.isAndroid){
 var url = 'amapuri://route/plan/?did=&dlat=${los[1]}&dlon=${los[0]}&dname=$address&dev=0&t=0';
    try{
      await launchUrl(Uri.parse(url));
    }on Exception {
      if (showErr) {

      TDToast.showFail('未安装高德地图', context: context,duration: showTime);
      }
    }
  }else if(Platform.isIOS){
    var url='iosamap://path?sourceApplication=applicationName&did=&dlat=${los[1]}&dlon=${los[0]}&dname=$address&dev=0&t=0';
    url = Uri.encodeFull(url);
       try{
      await launchUrl(Uri.parse(url));
    }on Exception {
      if (showErr) {
      TDToast.showFail('未安装高德地图', context: context,duration: showTime);
      }
    }
  }

}

/// 腾讯地图调用
Future<bool> openTencentMap(context, dynamic longitude, dynamic latitude,
    {required address, bool showErr = true}) async {
      List los = CoordinateTransformUtil.wgs84ToGcj02(double.parse(longitude), double.parse(latitude));
  String url =
      'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=${los[1]},${los[0]}&referer=FN4BZ-6E33P-LFTDB-VRZ4C-NTP3Z-RVFFK&debug=true&to=${address ?? ''}';
  if (Platform.isIOS) {
    url = Uri.encodeFull(url);
  }
  try {
    await launch(url);
  } on Exception {
    if (showErr) {
      TDToast.showFail('未安装腾讯地图', context: context,duration: showTime);
    }
    return false;
  }
  return true;
}

/// 百度地图
Future<bool> openBaiduMap(context, dynamic longitude, dynamic latitude,
    {required address, bool showErr = true}) async {
  // 转换为 BD-09
   List los = CoordinateTransformUtil.wgs84ToBd09(double.parse(longitude), double.parse(latitude));
  String url =
      'baidumap://map/direction?destination=name:|latlng:${los[1]},${los[0]}&coord_type=bd09ll';
  if (Platform.isIOS) {
    url = Uri.encodeFull(url);
  }
  try {
    await launch(url);
  } on Exception {
    if (showErr) {
      TDToast.showFail('未安装百度地图', context: context,duration: showTime);
    }
    return false;
  }
  return true;
}

openMapFromApp(context,
    {required longitude, required latitude, required address}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return TDAlertDialog.vertical(
        title: '跳转第三方地图导航',
        content: '选择导航地图软件',
        contentWidget: Column(
          children: [
            const TDText('选择导航地图软件'),
            const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            TDButton(
              padding:const EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              text: '高德地图',
              theme: TDButtonTheme.primary,
              onTap: () {
                openAmap(context, longitude, latitude, address: address);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TDButton(
              padding:const EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              text: '百度地图',
              theme: TDButtonTheme.primary,
              onTap: () {
                openBaiduMap(context, longitude, latitude, address: address);
              },
            ),
            const SizedBox(height: 10),
            TDButton(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              text: '腾讯地图',
              theme: TDButtonTheme.primary,
              onTap: () {
                openTencentMap(context, longitude, latitude, address: address);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TDButton(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              text: '离开',
              theme: TDButtonTheme.light,
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        buttons: const [],
      );
    },
  );
}
