import 'dart:io';
import 'dart:typed_data';
import 'dart:ui'as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
class ContainerToImage extends StatefulWidget {
  Function(String) callback;
  ContainerToImage({super.key, required this.callback});
  @override
  _ContainerToImageState createState() => _ContainerToImageState();
}

class _ContainerToImageState extends State<ContainerToImage> {
  final GlobalKey _globalKey = GlobalKey();
  Future<void> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      // 获取存储路径
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/container_image.png';
      File imgFile = File(imagePath);
      await imgFile.writeAsBytes(pngBytes);
      print('图片已保存到: $imagePath');
      widget.callback(imagePath);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
          Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _capturePng();
      });
    });

    });
  }

  @override
  Widget build(BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RepaintBoundary(
          key: _globalKey,
          child: Container(
            width: width,
            height: height-150,
            color: Colors.white,
            child: const Center(child: Text('这是一个容器', style: TextStyle(color: Colors.white))),
          ),
        ),
        // SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: _capturePng,
        //   child: Text('保存为图片'),
        // ),
      ],
    );
  }
}