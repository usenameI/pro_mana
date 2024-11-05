import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
///图片预览
class preview {
  ///单图预览
  static Future show(String url, context, {bool onDelete = true}) async {
    return await showDialog(
        useSafeArea: false,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Stack(
            children: [
              PhotoView(
                enableRotation: true,
                imageProvider: NetworkImage(url),
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
                          visible: onDelete,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              icon: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(75, 158, 158, 158),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  TDIcons.delete,
                                  color: Colors.white,
                                ),
                              ))),
                    ],
                  )))
            ],
          );
        });
  }
}
