
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class permisstion{
  ///检查并获取通知权限的同时并引导用户打开锁屏和横幅权限
 static  Future<bool> requestNotification(BuildContext context)async{
  PermissionStatus resPermission;
     resPermission = await Permission.notification.status;
    if(resPermission.isDenied){
         resPermission= await Permission.notification.request();
        if(resPermission.isGranted){
          prompt(context);
          // AppSettings.openAppSettings(type: AppSettingsType.notification);
        }
    }
    
    if(resPermission.isDenied){
      return false;
    }else if(resPermission.isGranted){
      return true;
    }else{
      return false;
    }
  }

  ///引导用户手动打开电池优化白名单避免后台杀进程
  static batteryList(){
  //     final intent = inte.AndroidIntent(
  //   action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
  //   package: 'pro_mana_example', // 替换为您的应用包名
  // );
  // intent.launch();
  }

  ///prompt UI
 static prompt(BuildContext context){
    OverlayEntry? overlayEntry;
       overlayEntry = OverlayEntry(
    builder: (context){
      return Positioned.fill(
        child: Container(
          color: colorUse.maskColor,
          child: Center(child: TDConfirmDialog(
              title: '提示',
              content:'打开横幅和锁屏通知有更好的体验',
              buttonText: '前往设置',
              action: () {
                overlayEntry?.remove();
                 overlayEntry=null;
                 AppSettings.openAppSettings(type: AppSettingsType.notification);
              },
            ),),
      ));
    }
  );

 Overlay.of(context).insert(overlayEntry!);
  }
}