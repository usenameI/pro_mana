import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pro_mana/Graffiti/Graffiti.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

///图片预览
class preview {
  ///单图预览
  ///返回一个结果结果是你点击删除的图片所在的索引
  static Future show(String url, context, {bool onDelete = true, Function(String)? onEdit}) async {
    return await showDialog(
        useSafeArea: false,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ImagePreview(url: url,onDelete: onDelete,onEdit: onEdit,);
        });
  }
}


class ImagePreview extends StatefulWidget{

  String url;
  bool onDelete;
  Function(String)? onEdit;
  ImagePreview({super.key,required this.url,required this.onDelete,required this.onEdit });

  @override
  State<ImagePreview> createState() {
    // TODO: implement createState
    return _ImagePreview();
  }
  
}

class _ImagePreview extends State<ImagePreview>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
            children: [
              PhotoView(
                enableRotation: true,
                imageProvider: NetworkImage(widget.url),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                      child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(75, 158, 158, 158),
                                shape: BoxShape.circle),
                            child: const Icon(
                              TDIcons.close,
                              color: Colors.white,
                            ),
                          )),
                      const Expanded(child: SizedBox()),
                      Visibility(
                        visible: widget.onEdit!=null,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Graffiti(
                                        config: GraffitiConfig(
                                        type: PaintingType.netWork,
                                        url: widget.url))),
                                ).then((value){
                                  if(value!=null&&widget.onEdit!=null){
                                    widget.onEdit!(value);
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))),
                      const SizedBox(
                        width: 5,
                      ),
                      Visibility(
                          visible: widget.onDelete,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              icon: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(75, 158, 158, 158),
                                    shape: BoxShape.circle
                                    ),
                                child: const Icon(
                                  TDIcons.delete,
                                  color: Colors.white,
                                ),
                              ))),
                    ],
                  )))
            ],
          );
  }
  
}