
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

///定位服务
class getLocation{
   // 检查权限
 static Future<bool> checkqx()async{
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
    }else{
      var end = await Permission.location.request();
      if(end.isGranted){
        return true;
      }else{
        return false;
      }
    }
    
  }

  ///手动打开经纬度功能
 static Future openLocation()async{
   var state = await Permission.location.request();
   if(state==PermissionStatus.granted){
    return true;
   }
   return false;
  }
  //返回经纬度
 static Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  var config=AndroidSettings(forceLocationManager: true,timeLimit:const Duration(seconds: 2));
  var p;
  try{
     p = await Geolocator.getCurrentPosition(
    locationSettings: config,
  );
  }catch(e){
    p = await Geolocator.getLastKnownPosition(forceAndroidLocationManager: true,);
  }
  return p;
}
  // 返回经纬度
 static Future<Map<String,num?>> getCor(context,{
 Duration? setTime
 }) async {
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  var config=AndroidSettings(forceLocationManager: true,timeLimit:setTime );
  var p;
  try{
     p =  await Geolocator.getCurrentPosition(
    locationSettings: config,
  );
  }catch(e){
    p = await Geolocator.getLastKnownPosition(forceAndroidLocationManager: true);
    if(p==null){

      return {
      'latitude':null,
      'longitude': null,
      };
    }
    
  }
return {
      'latitude':p?.latitude,
      'longitude': p?.longitude,
};
  }
///计算经纬度的距离
static double getRection({
  required double startLatitude,
  required double startLongitude,
  required double endLatitude,
  required double endLongitude,
}){
  double distance = Geolocator.distanceBetween(
    startLatitude, 
    startLongitude, 
    endLatitude, 
    endLongitude
    );
    return distance;
}

}