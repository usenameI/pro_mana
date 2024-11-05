import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


  ///本地存储
 class storageLocal{
  ///int
 static Future<int?> getInt({ required String keyName})async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyName) ?? 1;
  }
  ///设置int
   static Future<bool> setInt({required String keyName,required int value})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.setInt(keyName, value);  
  }
  ///String
  static Future<String?> getString({ required String keyName})async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('systemType');
  }
  ///设置String
  static Future<bool> setString({required String keyName,required String value})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.setString(keyName, value);  
  }

  ///list
  static Future<List<String>?> getList({required String keyName})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(keyName);
  }

  ///设置List
  static Future<bool> setList({required String keyName,required List<String> list})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(keyName, list);
  }
  ///bool
  static Future<bool?> getBool({required String keyName})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyName);
  }
  ///设置bool
  static Future<bool> setBool({required String keyName,required bool value})async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return await prefs.setBool(keyName,value);
  }

 }







