import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_mana_example/signal/imageContanier.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
class MobileExample extends StatefulWidget {
  const MobileExample({super.key});

  @override
  State<MobileExample> createState() => _MobileExampleState();
}

class _MobileExampleState extends State<MobileExample> {
  final ImagePainterController _controller = ImagePainterController(
    color: Colors.green,
    strokeWidth: 4,
    mode: PaintMode.line,
  );

  bool complete=false;
  String imagePath='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("绘图"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: saveImage,
          )
        ],
      ),
      
      body:
    !complete? ContainerToImage(callback: (p0) {
      imagePath=p0;
      complete=true;
      setState(() {
        
      });
    },):
      ImagePainter.file(        
        File(imagePath), 
        controller: _controller,
placeholderWidget:SizedBox()
        ),
      
      //  ImagePainter.asset(
      //   imagePath,
      //   controller: _controller,
      //   scalable: true,
      //   textDelegate: TextDelegate(),
      // ),
    );
  }

  void saveImage() async {
    final image = await _controller.exportImage();
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath = '$directory/sample/$imageName';
    final imgFile = File(fullPath);
    if (image != null) {
      imgFile.writeAsBytesSync(image);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[700],
          padding: const EdgeInsets.only(left: 10),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Image Exported successfully.",
                  style: TextStyle(color: Colors.white)),
              TextButton(
                onPressed: () => OpenFile.open(fullPath),
                child: Text(
                  "Open",
                  style: TextStyle(
                    color: Colors.blue[200],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}