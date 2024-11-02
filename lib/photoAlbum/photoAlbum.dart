import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class photoAlbum{
  ///不可使用相机
  static Future<List<AssetEntity>?> getAssetNoCamera(context)async{
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,pickerConfig: AssetPickerConfig(
      textDelegate: AssetPickerTextDelegate()
    ));
    return result??[];
  }


  ///可使用相机
 static Future<List<AssetEntity>?> getAsset(context) async {
  const AssetPickerTextDelegate textDelegate = AssetPickerTextDelegate();
          final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,pickerConfig:AssetPickerConfig(
            maxAssets: 9,
            
            specialItemPosition: SpecialItemPosition.prepend,
            specialItemBuilder: (
              BuildContext context,
              AssetPathEntity? path,
              int length,
            ) {
              if (path?.isAll != true) {
                return null;
              }
              return Semantics(
                label: textDelegate.sActionUseCameraHint,
                button: true,
                onTapHint: textDelegate.sActionUseCameraHint,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                      final AssetEntity? result = await _pickFromCamera(context);
                    if (result == null) {
                      return;
                    }
                    final picker = context.findAncestorWidgetOfExactType<
                        AssetPicker<AssetEntity, AssetPathEntity>>()!;
                    final builder =
                        picker.builder as DefaultAssetPickerBuilderDelegate;
                    final p = builder.provider;
                    await p.switchPath(
                      PathWrapper<AssetPathEntity>(
                        path:
                            await p.currentPath!.path.obtainForNewProperties(),
                      ),
                    );
                    p.selectAsset(result);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(28.0),
                    color: Theme.of(context).dividerColor,
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(Icons.camera_enhance),
                    ),
                  ),
                ),
              );
            },
          ),);
          return result??[];
  }
 static Future<AssetEntity?> _pickFromCamera(BuildContext c) {
  return CameraPicker.pickFromCamera(
    c,
    pickerConfig:const  CameraPickerConfig(enableRecording: true),
  );
}
}