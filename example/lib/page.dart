import 'package:pro_mana_example/component/CarouselViewTest/CarouselViewTest.dart';
import 'package:pro_mana_example/component/Graffiti/Graffiti.dart';
import 'package:pro_mana_example/component/Model3d/Model3d.dart';
import 'package:pro_mana_example/component/DateTest/dateTest.dart';
import 'package:pro_mana_example/component/ExtensionComponent/ExtensionComponent.dart';
import 'package:pro_mana_example/component/JsonApply/JsonApply.dart';
import 'package:pro_mana_example/component/JsonTransferCode/JsonTransferCode.dart';
import 'package:pro_mana_example/component/ModelJump/ModelJump.dart';
import 'package:pro_mana_example/component/VideoTrimmer/home_page.dart';
import 'package:pro_mana_example/component/bottomDragge/bottomDragge.dart';
import 'package:pro_mana_example/component/floating/floating.dart';

final sampleWidgets ={
  "JsonApply":()=>const Jsonapply(),
  "JsonTransferCode":()=>const JsonTransferCode(),
  "CarouselViewTest":()=>const CarouseViewTest(),
  "DateTest":()=>const DateTest(),
  "floating":()=>const FloatingWindow(),
  "Trimmer":()=>const HomePage(),
  "BottomDragge":()=>const BottomDragge(),
  "ModelJump":()=> const ModelJump(),
  "ExtensionComponent":()=> const ExtensionComponent(),
  "Model3d":()=>const Model3d(),
  "Graffiti":()=>const Graffiti()
};