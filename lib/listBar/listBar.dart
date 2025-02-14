import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class ListBarController {
  int listNum = 0;
  EasyRefreshController? erController;
  ListController? listController;
  bool isHidden = true;

  ///刷新
  Future<void> manualUpdataList(int listNum) async {
    this.listNum = listNum;
    listController?.update();
  }

  setState(bool state) {
    isHidden = state;
    listController?.update();
  }
}

class ListController extends ChangeNotifier {
  update() {
    notifyListeners();
  }
}

class listBar extends StatefulWidget {
  ListBarController controller;
  Future<int> Function() onLoad;
  Future<int> Function() onRefresh;
  Function onfinsh;
  Widget bottomBar;
  Widget Function(BuildContext, int) widgetList;

  listBar(
      {super.key, required this.onLoad,
      required this.onRefresh,
      required this.widgetList,
      required this.controller,
      required this.onfinsh,
      required this.bottomBar});

  @override
  State<listBar> createState() {
    // TODO: implement createState
    return _listBar();
  }
}

class _listBar extends State<listBar> {
  int currentPage = 0;
  final List<Color> colors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
  ];

  EasyRefreshController erController = EasyRefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.erController = erController;
      // widget.onfinsh();
      erController.callRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (context) => ListController(),
        child: Consumer<ListController>(builder: (context, value, child) {
          widget.controller.listController = value;
          return BottomBar(
            clip: Clip.none,
            fit: StackFit.expand,
            icon: (width, height) => Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: null,
                icon: Icon(
                  Icons.arrow_upward_rounded,
                  color: colors[currentPage],
                  size: width,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(10),
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            showIcon: false,
            width: MediaQuery.of(context).size.width,
            barColor: PairWithWhite.hjl,
            // barColor: Colors.transparent,
            start: 3,
            end: 0,
            offset: 10,
            barAlignment: Alignment.bottomCenter,
            iconHeight: 30,
            iconWidth: 30,
            reverse: false,
            barDecoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            iconDecoration: BoxDecoration(
              color: PairWithWhite.hjl,
              borderRadius: BorderRadius.circular(500),
            ),

            ///是否隐藏菜单
            hideOnScroll: widget.controller.isHidden,
            scrollOpposite: false,
            onBottomBarHidden: () {},
            onBottomBarShown: () {},
            body: (context, controller) {
              return Scrollbar(
                  thumbVisibility: true,
                  child: EasyRefresh(
                    controller: erController,
                    header: BallPulseHeader(
                        color: const Color.fromRGBO(121, 118, 254, 1)),
                    footer: BallPulseFooter(
                        color: const Color.fromRGBO(121, 118, 254, 1)),
                    onLoad: () async {
                      widget.controller.listNum = await widget.onLoad();
                      value.update();
                    },
                    onRefresh: () async {
                      widget.controller.listNum = 0;
                      value.update();
                      widget.controller.listNum = await widget.onRefresh();
                      value.update();
                    },
                    child: ListView.builder(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 5),
                        controller: controller,
                        itemCount: widget.controller.listNum == 0
                            ? 1
                            : widget.controller.listNum,
                        itemBuilder: (context, index) {
                          if (widget.controller.listNum == 0) {
                            return Column(
                              children: [
                                Image.asset('images/缺省页.png'),
                                const TDText(
                                  '暂无运维事件',
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 145, 161, 1)),
                                )
                              ],
                            );
                          }
                          return widget.widgetList(context, index);
                        }),
                  ));
            },
            child: widget.bottomBar,
          );
        }));
  }
}

class BarIcon {
  String title;
  Widget icon;
  bool touchChange;
  Panel? panel;
  BarIcon(
      {required this.title,
      required this.icon,
      this.touchChange = false,
      this.panel});
}

class Panel {
  String descript;
  String cancel;
  String confirm;
  Panel({this.descript = '信息', this.cancel = '取消', this.confirm = '确定'});
}

///底部菜单组件控制器
class BottomBarController extends ChangeNotifier {
  ///面板索引
  int index = 0;

  ///按钮索引
  int? barIndex;
  bottomController? b;
  List<BarIcon> iconList = [];
  revisePanel({String? descript, String? cancel, String? confirm}) {
    iconList[barIndex!].panel?.descript =
        (descript ?? iconList[barIndex!].panel?.descript)!;
    iconList[barIndex!].panel?.cancel =
        (cancel ?? iconList[barIndex!].panel?.cancel)!;
    iconList[barIndex!].panel?.confirm =
        (confirm ?? iconList[barIndex!].panel?.confirm)!;
    b?.updata();
  }
}

class bottomController extends ChangeNotifier {
  updata() {
    notifyListeners();
  }
}

///底部菜单组件封装
class bottomBar {
  ///可自动切换的组件
  static Widget covertBar(
      {required List<BarIcon> iconList,
      required Function(int) onclick,
      required Function(bool) barStateChange,
      required BottomBarController bottomBarController,
      MainAxisAlignment alignment = MainAxisAlignment.spaceBetween}) {
    bottomBarController.iconList = iconList;
    return ChangeNotifierProvider(
        create: (context) => bottomController(),
        child: Consumer<bottomController>(
          builder: (context, controller, child) {
            bottomBarController.b = controller;
            return Container(
                height: 55,
                padding: const EdgeInsets.only(
                    top: 3, bottom: 3, left: 12, right: 12),
                child: IndexedStack(
                  index: bottomBarController.index,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: alignment,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: iconList.map((e) {
                          return InkWell(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 20, height: 20, child: e.icon),
                                const SizedBox(
                                  height: 5,
                                ),
                                TDText(
                                  e.title,
                                  textColor: Colors.white,
                                  style: const TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            onTap: () {
                              var index = iconList.indexOf(e);
                              if (e.touchChange) {
                                bottomBarController.index = 1;
                                bottomBarController.barIndex = index;
                                barStateChange(false);
                                controller.updata();
                              } else {
                                onclick(index);
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    () {
                      if (bottomBarController.barIndex == null) {
                        return const SizedBox(
                          height: 30,
                        );
                      }

                      if (iconList[bottomBarController.barIndex!].panel ==
                          null) {
                        return const SizedBox(
                          height: 30,
                        );
                      }
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: TDText(
                              iconList[bottomBarController.barIndex!]
                                  .panel
                                  ?.descript,
                              textColor: Colors.white,
                            )),
                            TDButton(
                              text: iconList[bottomBarController.barIndex!]
                                  .panel
                                  ?.cancel,
                              onTap: () {
                                bottomBarController.index = 0;
                                barStateChange(true);
                                controller.updata();
                              },
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TDButton(
                              theme: TDButtonTheme.primary,
                              text: iconList[bottomBarController.barIndex!]
                                  .panel
                                  ?.confirm,
                              onTap: () {
                                onclick(bottomBarController.barIndex!);
                              },
                            ),
                          ],
                        ),
                      );
                    }()
                  ],
                ));
          },
        ));
  }
}
