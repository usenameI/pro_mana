import 'package:flutter/material.dart';
import 'package:pro_mana/secondTime/secondTime.dart';
import 'package:provider/provider.dart';

import 'package:tdesign_flutter/tdesign_flutter.dart';

///加载弹窗功能封装
class LoadingDailag {
  static show(BuildContext context,
      {required DialogController dialogController,
      required Future<void> Function() onSuccess,
      required Function() onExit}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogWidget(
          dialogController: dialogController,
          onSuccess: onSuccess,
          onExit: onExit,
        );
      },
    );
  }
}

///对话框控制器
class DialogController {
  TimeController? timeState;
  CancelController? cancelController;
}

class TimeController extends ChangeNotifier {
  int count = 0;
  int current = 0;
  String title = '';
  set({int? count, int? current, String? title}) {
    this.count = count ?? this.count;
    this.current = current ?? this.current;
    this.title = title ?? this.title;
    notifyListeners();
  }
}

class CancelController extends ChangeNotifier {
  bool cancelLoad = false;

  set(bool cancelLoad) {
    this.cancelLoad = cancelLoad;
    notifyListeners();
  }
}

///对话框组件
class DialogWidget extends StatefulWidget {
  ///控制器
  DialogController? dialogController;

  ///创建成功回调
  Future<void> Function() onSuccess;

  ///退出回调
  Function() onExit;

  DialogWidget(
      {this.dialogController, required this.onSuccess, required this.onExit});

  @override
  State<DialogWidget> createState() {
    // TODO: implement createState
    return _DialogWidget();
  }
}

class _DialogWidget extends State<DialogWidget> {
  ///是否允许后面的操作
  bool isRun = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.onSuccess();
      if (isRun) {
        Navigator.pop(context);
        widget.onExit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {},
        child: Center(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: TDText(
                  '提示',
                  font: Font(size: 18, lineHeight: 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ChangeNotifierProvider(
                create: (context) => TimeController(),
                child: Consumer<TimeController>(
                  builder: (context, value, child) {
                    if (widget.dialogController != null) {
                      widget.dialogController!.timeState = value;
                    }

                    return TDLoading(
                      size: TDLoadingSize.large,
                      icon: TDLoadingIcon.circle,
                      text: '${value.title} ${value.count}/${value.current}',
                      axis: Axis.horizontal,
                    );
                  },
                ),
              ),
              Row(
                children: [
                  secondTime(callBack: (value) {
                    // cancelLoad = true;
                    widget.dialogController?.cancelController?.set(true);
                  }),
                  const Expanded(child: SizedBox()),
                  ChangeNotifierProvider(
                      create: (context) => CancelController(),
                      child: Consumer<CancelController>(
                        builder: (context, value, child) {
                          widget.dialogController?.cancelController = value;
                          return Visibility(
                              visible: value.cancelLoad,
                              child: TDButton(
                                text: '取消',
                                type: TDButtonType.text,
                                theme: TDButtonTheme.primary,
                                onTap: () {
                                  isRun=false;
                                  Navigator.pop(context);
                                },
                              ));
                        },
                      )),
                ],
              ),
            ],
          ),
        )));
  }
}