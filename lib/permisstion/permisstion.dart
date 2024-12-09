
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class permisstion{
  ///检查并获取通知权限的同时并引导用户打开锁屏和横幅权限
 static   requestNotification(BuildContext context,{required Function(bool) callback}) async {
  PermissionStatus resPermission;
     resPermission = await Permission.notification.status;
    if(resPermission.isDenied){
      permissionPrompt(context: context, content: '');
         resPermission= await Permission.notification.request();
         overlayEntry?.remove();
         overlayEntry=null;
        if(resPermission.isGranted){
          prompt(context:context,content: "打开横幅和锁屏通知有更好的体验",callback: (p0) {
            callback(p0);
          },);
          // AppSettings.openAppSettings(type: AppSettingsType.notification);
        }
    }else if(resPermission.isPermanentlyDenied){
     
        prompt(context: context,content: "多次拒绝通知权限请求只能通过手动打开,打开通知、横幅、和锁屏",callback: (p0) {
          callback(p0);
        },);
    }else if(resPermission.isGranted){
      callback(true);
    }
  
  }


 static OverlayEntry? overlayEntry;

  ///prompt UI
  ///
  ///[context]
  ///
  ///[content] is [String] to descipt about prompt information.
 static prompt({required BuildContext context,required String content,required Function(bool) callback}){
   
       overlayEntry = OverlayEntry(
    builder: (context){
      return Positioned.fill(
        child: Container(
          color: colorUse.maskColor,
          child: Center(child: TDConfirmDialog(
              title: '提示',
              content:content,
              buttonText: '前往设置',
              action: () async {
                overlayEntry?.remove();
                 overlayEntry=null;
                 AppSettings.openAppSettings(type: AppSettingsType.notification,asAnotherTask:false).then((value){
                    print('log___nidakaile shezhiyemian');
                });
                  Permission.notification.status;
              },
            ),),
      ));
    }
  );

 Overlay.of(context).insert(overlayEntry!);
  }

   static permissionPrompt({required BuildContext context,required String content}){
       overlayEntry = OverlayEntry(
    builder: (context){
      return Positioned(
        top: 50,
        left: 20,
        right: 20,
        child:
        Material(
          child: Container(
          color: colorUse.progress,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30,),
              Text('如果不开启你将无法使用通知权限去提醒你'),
              SizedBox(height: 30,),
            ],),
        ),
        )
         );
    }
  );

 Overlay.of(context).insert(overlayEntry!);
  }
}