import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_mana/Graffiti/imageContanier.dart';

enum PaintingType{
  file,
  netWork
}
class GraffitiConfig{
  PaintingType type;
  ///if you select netWork as background ,you should to add a url
  String url;
GraffitiConfig({required this.type,this.url=''});
}


class Graffiti extends StatefulWidget {
   GraffitiConfig config;
   Graffiti({super.key,required this.config});

  @override
  State<Graffiti> createState() => _Graffiti();
}

class _Graffiti extends State<Graffiti> {
  final ImagePainterController _controller = ImagePainterController(
    color: Colors.green,
    strokeWidth: 4,
    mode: PaintMode.line,
  );

  bool complete = false;
  String imagePath = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("绘图"),
        leading: IconButton(
          onPressed: (){
          Navigator.pop(context,);        
        }, icon:const Icon(Icons.close)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: saveImage,
          )
        ],
      ),
      body: !complete
          ? ContainerToImage(
              callback: (p0) {
                imagePath = p0;
                complete = true;
                setState(() {});
              },
            )
          : 
          (){
            switch(widget.config.type){
              case PaintingType.file:
              return ImagePainter.file(
              File(imagePath),
              controller: _controller,
            );
                
              case PaintingType.netWork:
              return ImagePainter.network(
                widget.config.url, 
                controller: _controller,scalable: true
                );
                
            }
          }()
          
          ,
    );
  }

  void saveImage() async {
    final image = await _controller.exportImage();
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath = '$directory/sample/$imageName';
    final imgFile = File(fullPath);
    if (image != null){
        imgFile.writeAsBytesSync(image);
        Navigator.pop(context,fullPath);
    }
  }
                                                                            
}
