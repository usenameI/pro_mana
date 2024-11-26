package com.example.pro_mana


// import androidx.annotation.NonNull
// import io.flutter.embedding.engine.plugins.FlutterPlugin
// import io.flutter.plugin.common.MethodCall
// import io.flutter.plugin.common.MethodChannel
// import io.flutter.plugin.common.MethodChannel.MethodCallHandler
// import io.flutter.plugin.common.MethodChannel.Result
// import com.example.pro_mana.LocationHelper
// import android.location.Location
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.plugins.activity.ActivityAware
// import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
// import android.app.Activity
// /** ProManaPlugin */
//  class ProManaPlugin: FlutterPlugin, MethodCallHandler,ActivityAware  {
//   /// The MethodChannel that will the communication between Flutter and native Android
//   ///
//   /// This local reference serves to register the plugin with the Flutter Engine and unregister it
//   /// when the Flutter Engine is detached from the Activityq
//   private lateinit var channel : MethodChannel
//   ///经纬度类的对象
//   lateinit var locationHelper: LocationHelper;
//   ///引用
//   private lateinit var flutterActivity: FlutterActivity
//   override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//     channel = MethodChannel(flutterPluginBinding.binaryMessenger, "pro_mana")
//     channel.setMethodCallHandler(this)
//     locationHelper = LocationHelper(flutterPluginBinding.applicationContext)
//     // locationHelper?.setLocationCallBack(this)
//     // flutterActivity = flutterPluginBinding.activity as FlutterActivity
//   }
//     // override fun onAttachedToActivity(binding: ActivityPluginBinding) {
//     //     // activity = binding.activity
//     // }

//   override fun onMethodCall(call: MethodCall, result: Result) {
//     if (call.method == "getPlatformVersion") {
//       result.success("Android ${android.os.Build.VERSION.RELEASE}")
//     }else if(call.method == "test"){
            
            
//             // locationHelper.requestLocationPermissions()
//     }else {
//       result.notImplemented()
//     }
//   }

//   override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//     channel.setMethodCallHandler(null)
//   }

//   // override fun setLocation(location: Location?) {
//   //       location?.let {
//   //           val latitude = it.latitude
//   //           val longitude = it.longitude
//   //           // 处理获取到的经纬度
//   //           println("log__ggaaaaaLatitude: $latitude, Longitude: $longitude")
//   //           // Toast.makeText(this, "Latitude: $latitude, Longitude: $longitude", Toast.LENGTH_SHORT).show()
//   //       }
//   //   }


// }



import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import android.app.Activity
import com.example.pro_mana.LocationHelper
import android.location.Location
class ProManaPlugin : FlutterPlugin, MethodCallHandler, ActivityAware ,LocationHelper.LocationCallBack{
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    var locationHelper: LocationHelper?=null
    private lateinit var result: MethodChannel.Result 
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "pro_mana")
        channel.setMethodCallHandler(this)
       
        locationHelper = LocationHelper(flutterPluginBinding.applicationContext)
          // locationHelper?.setLocationCallBack(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result=result
        // 回复的内容
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }"test"->{
                 println("log__jiujiujiujiujiujiujiujiujiujiujiu")
                locationHelper?.setLocationCallBack(this)
              locationHelper?.requestLocationPermissions(activity)
            // result.success("A这是一个测试的字符串")
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity

    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
    }

    ///获取经纬度的回调
    override fun setLocation(location: Location?,success: Boolean) {
        location?.let {
            val latitude = it.latitude
            val longitude = it.longitude
            // 处理获取到的经纬度
              val locationMap = mapOf(
                "latitude" to location?.latitude,
                "longitude" to location?.longitude,
                "success" to success
            )
            result.success(locationMap)
            // Toast.makeText(this, "Latitude: $latitude, Longitude: $longitude", Toast.LENGTH_SHORT).show()
        }
    }
}