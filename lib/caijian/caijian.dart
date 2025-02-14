import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

///裁剪图片
class caijian extends StatefulWidget {
  dynamic path;
  caijian({super.key, required this.path});
  @override
  State<caijian> createState() {
    // TODO: implement createState
    return _caijian();
  }
}

class _caijian extends State<caijian> {
  final _controller = CropController();
  ///比例
  double aspect=19/6;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  ///是否返回
  bool isBack=false;
  ///裁剪是否可点击
  bool isClick=true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  TDLoadingController.dismiss();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
    
   PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
       if (didPop) {
    return;
  }
  if(!isBack)return;
       final navigator = Navigator.of(context);
  // bool value = await someFunction();
  
    navigator.pop(result);
  
    },
    child:  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
             TDNavBar(
              height: 48,
              titleFontWeight: FontWeight.w600,
              title: '裁剪',
              screenAdaptation: false,
              useDefaultBack: true,
              onBack: () {
                isBack=true;
              },
            ),
            Expanded(child: FutureBuilder(
              future: fileToUint8List(widget.path),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return 
                  Container(
                    color: Colors.black,
                    padding:const EdgeInsets.only(left: 30,right: 30),
                    child: Crop(
                      maskColor:const Color.fromARGB(176, 0, 0, 0),
                      baseColor: Colors.black,
                          image: snapshot.data as Uint8List,
                          controller: _controller,
                          onCropped: (image) {
                            TDLoadingController.dismiss();
                            isClick=true;
                            int timestampInMilliseconds = DateTime.now().millisecondsSinceEpoch;
                            saveUint8ListToFile(image,'$timestampInMilliseconds.png');
                          }),
                  );
                }
                return const SizedBox();
              },
            )),
           const SizedBox(height: 50,),
          Wrap(
            children: [
              TDButton(type: TDButtonType.text,text: '16:9',
              onTap: () {
                _controller.aspectRatio=19/6;
              },
              ),
              TDButton(type: TDButtonType.text,text: '8:5',
              onTap: () {
                _controller.aspectRatio=8/5;
              },
              ),
              TDButton(type: TDButtonType.text,text: '7:5',
              onTap: () {
                _controller.aspectRatio=7/5;
              },
              ),
              TDButton(type: TDButtonType.text,text: '4:3',
              onTap: () {
                _controller.aspectRatio=4/3;
              },
              ),
              TDButton(type: TDButtonType.text,text: '任意',
              onTap: () {
                _controller.aspectRatio=null;
              },
              ),
            ],
          ),
            TDButton(
              text: '裁剪',
              disabled:!isClick,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              theme: TDButtonTheme.primary,
              onTap: () {
                if(!isClick){
                  return ;
                }
                isClick=false;
                TDLoadingController.show(context,text: '裁剪中');
                _controller.crop();
              },
              )
          ],
        ))));
  }

  Future<Uint8List> fileToUint8List(String filePath) async {
    // 创建文件对象
    File file = File(filePath);
    // 读取文件的字节数据
    List<int> bytes = await file.readAsBytes();
    // 转换为 Uint8List
    Uint8List uint8List = Uint8List.fromList(bytes);
    return uint8List;
  }

  ///将数据存进沙盒
Future<void> saveUint8ListToFile(Uint8List data, String fileName) async {
  // 获取缓存目录
   final directory = await getTemporaryDirectory();
  
  // 确保目录存在
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }

  // 创建文件路径
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);

  // 写入数据
  await file.writeAsBytes(data);
  Navigator.pop(context,filePath);
}


}
