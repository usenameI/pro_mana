import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class jlConfig {
  static Map defaultValue = {
    'name': 'name',
    'id': 'id',
    'organizationalStructureNoteVOList': 'organizationalStructureNoteVOList',
    'forbid': 'project',
  };
  static bool forbidValue = false;
  static

      ///设置键名
      setDefaultValue(jlType type) {
    switch (type) {
      case jlType.part:
        defaultValue.addAll({
          'name': 'label',
          'id': 'id',
          'organizationalStructureNoteVOList': 'children',
          'forbid': 'project'
        });

        break;
      case jlType.area:
        defaultValue.addAll({
          'name': 'name',
          'id': 'id',
          'organizationalStructureNoteVOList':
              'organizationalStructureNoteVOList',
          'forbid': 'project'
        });
        break;
      case jlType.book:
        defaultValue.addAll({
          'name': 'name',
          'id': 'id',
          'organizationalStructureNoteVOList': 'phoneBookNodeVOList',
          'forbid': 'project'
        });
        break;
      case jlType.device:
        defaultValue.addAll({
          'name': 'name',
          'id': 'id',
          'organizationalStructureNoteVOList': 'deviceManageNodeVOList',
          'forbid': 'project'
        });
        break;
    }
  }
}

// ///默认键名
// Map defaultValue = {
//   'name': 'name',
//   'id': 'id',
//   'organizationalStructureNoteVOList': 'organizationalStructureNoteVOList',
//   'forbid': 'project',

// };
//  bool forbidValue=false;

///设置键名
// setDefaultValue(jlType type) {
//   switch (type) {
//     case jlType.part:
//       defaultValue.addAll({
//         'name': 'label',
//         'id': 'id',
//         'organizationalStructureNoteVOList': 'children',
//         'forbid': 'project'
//       });

//       break;
//     case jlType.area:
//       defaultValue.addAll({
//         'name': 'name',
//         'id': 'id',
//         'organizationalStructureNoteVOList':
//             'organizationalStructureNoteVOList',
//         'forbid': 'project'
//       });
//       break;
//     case jlType.book:
//       defaultValue.addAll({
//         'name': 'name',
//         'id': 'id',
//         'organizationalStructureNoteVOList': 'phoneBookNodeVOList',
//         'forbid': 'project'
//       });
//       break;
//     case jlType.device:
//       defaultValue.addAll({
//         'name': 'name',
//         'id': 'id',
//         'organizationalStructureNoteVOList': 'deviceManageNodeVOList',
//         'forbid': 'project'
//       });
//       break;
//   }
// }

///枚举
enum jlType { part, area, book, device }

///级联选择器的控制器
class customJlxzqController extends ChangeNotifier {
  bool forbid = false;
  customJlxzqController() {
    stack.add({});
  }
  List stack = [];

  ///获取已选中的所有数据
  List getSelectData() {
    List vs = List.from(stack);
    vs.removeWhere((element) => element[jlConfig.defaultValue['name']] == null);
    return vs;
  }

  ///通知
  void toggle() {
    notifyListeners();
  }
}

///弹窗ui
class useCustomJLXZQ {
  customJlxzqController controller = customJlxzqController();
  Future show(context,
      {required List data,
      required callBack,
      required jlType type,
      bool forbid = false,
      bool forbidValue = false}) async {
    jlConfig.setDefaultValue(type);
    Navigator.of(context).push(TDSlidePopupRoute(
        modalBarrierColor: TDTheme.of(context).fontGyColor2,
        slideTransitionFrom: SlideTransitionFrom.bottom,
        builder: (context) {
          return TDPopupBottomConfirmPanel(
              title: '选择区域',
              leftClick: () {
                Navigator.maybePop(context);
              },
              rightClick: () {
                var v = controller.getSelectData();
                callBack(v);
                Navigator.maybePop(context);
              },
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  height: 300,
                  child: customJlxzq(
                    forbid: forbid,
                    data: data,
                    controller: controller,
                    callback: (value) {},
                    forbidValue: forbidValue,
                  )));
        }));
  }
}

class customJlxzq extends StatefulWidget {
  customJlxzqController? controller;
  List data;
  Function callback;
  bool forbid;
  customJlxzq(
      {super.key, this.controller,
      required this.data,
      required this.callback,
      this.forbid = false,
      bool forbidValue = false}) {
    jlConfig.forbidValue = forbidValue;
  }
  @override
  State<customJlxzq> createState() => _customJlxzq();
}

class _customJlxzq extends State<customJlxzq> with TickerProviderStateMixin {
//  List stack=[];
  List stackC = [];
  List Contents = [];
  int pageIndex = 0;
  final PageController _pageController = PageController();
  TabController? _tab;
  void _updateState() {
    setState(() {}); // 更新状态以反映控制器的变化
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller?.forbid = widget.forbid;
    // stack.add({});
    Contents.add(widget.data);
    _tab = TabController(length: widget.controller!.stack.length, vsync: this);
    widget.controller?.addListener(_updateState);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('log__级联数据${widget.data}');
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateState);
    super.dispose();
  }

  ///刷新状态
  renewState() {
    _tab = TabController(
        length: widget.controller!.stack.length,
        vsync: this,
        initialIndex: pageIndex);

    _tab?.animateTo(
      widget.controller!.stack.length > pageIndex + 1
          ? pageIndex + 1
          : pageIndex,
    );
    setState(() {});
  }

  DG(data, id) {
    dynamic useData;
    if (data is List) {
      for (var e in data) {
        var v = DG(e, id);
        if (v != null) {
          useData = v;
        }
      }
    }
    if (data is Map) {
      if (data[jlConfig.defaultValue['id']] == id) {
        useData = {
          'name': data[jlConfig.defaultValue['name']],
          'id': data[jlConfig.defaultValue['id']],
          jlConfig.defaultValue['organizationalStructureNoteVOList']:
              data[jlConfig.defaultValue['organizationalStructureNoteVOList']]
        };
      } else {
        var v = DG(
            data[jlConfig.defaultValue['organizationalStructureNoteVOList']],
            id);
        if (v != null) {
          useData = v;
        }
      }
    }
    return useData;
  }

  ///去除重复 为true不删除，false就删除
  dynamic remove(data, id) {
    bool cf = false;
    if (data is List) {
      for (var e in data) {
        var v = remove(e, id);
        if (v == true) {
          cf = true;
        }
      }
    }
    if (data is Map) {
      if (data['id'] == id) {
        cf = true;
      } else {
        var v = remove(
            data[jlConfig.defaultValue['organizationalStructureNoteVOList']],
            id);
        if (v == true) {
          cf = true;
        }
      }
    }
    return cf;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: double.infinity,
              child: TDTabBar(
                isScrollable: true,
                tabs: widget.controller?.stack.map((e) {
                  return TDTab(
                    size: TDTabSize.large,
                    text: e[jlConfig.defaultValue['name']] ?? '请选择',
                  );
                }).toList() as List<TDTab>,
                controller: _tab,
                showIndicator: true,
                backgroundColor: Colors.white,
                onTap: (p0) {
                  pageIndex = p0;
                  _pageController.animateToPage(
                    pageIndex,
                    duration: const Duration(milliseconds: 300), // 动画持续时间
                    curve: Curves.easeInOut, // 动画曲线
                  );
                },
              ),
            ),
            Expanded(
                child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: Contents.length,
              itemBuilder: (context, index) {
                return pl(
                    forbid: widget.forbid,
                    listData: Contents[index],
                    name: widget.controller?.stack[index]
                        [jlConfig.defaultValue['name']],
                    callback: (value, name, id, forbid) {
                      var v = DG(widget.data, id);

                      widget.callback(v);
                      widget.controller?.stack[index]
                          [jlConfig.defaultValue['id']] = id;
                      widget.controller?.stack[index]
                          [jlConfig.defaultValue['name']] = name;
                      widget.controller?.stack[index]
                          [jlConfig.defaultValue['forbid']] = forbid;
                      for (var i = widget.controller!.stack.length - 1;
                          i > -1;
                          i--) {
                        if (widget.controller?.stack[i]
                                [jlConfig.defaultValue['id']] ==
                            null) {
                          widget.controller?.stack.removeAt(i);
                          Contents.removeAt(i);
                        }
                      }
                      if (widget.controller!.stack.length > pageIndex + 1) {
                        for (var i = widget.controller!.stack.length - 1;
                            i > index;
                            i--) {
                          var va = remove(
                              v[jlConfig.defaultValue[
                                  'organizationalStructureNoteVOList']],
                              id);
                          if (va == false) {
                            widget.controller?.stack.removeAt(i);
                            Contents.removeAt(i);
                          }
                        }
                      }
                      if (v[jlConfig.defaultValue[
                              'organizationalStructureNoteVOList']] ==
                          null) {
                        renewState();
                        return;
                      } else if (v[jlConfig.defaultValue[
                          'organizationalStructureNoteVOList']] is List) {
                        if (v[jlConfig.defaultValue[
                                    'organizationalStructureNoteVOList']]
                                .length ==
                            0) {
                          renewState();
                          setState(() {});
                          return;
                        }
                      }
                      widget.controller?.stack.add({});
                      // print('log___dangqinav)
                      Contents.add(v[jlConfig
                          .defaultValue['organizationalStructureNoteVOList']]);
                      renewState();
                      pageIndex++;
                      _pageController.animateToPage(
                        pageIndex,
                        duration: const Duration(milliseconds: 300), // 动画持续时间
                        curve: Curves.easeInOut, // 动画曲线
                      );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }
}

///每一页面的列表组件
class pl extends StatefulWidget {
  dynamic listData;
  Function(dynamic, dynamic, dynamic, dynamic) callback;
  dynamic name;
  bool forbid;
  pl(
      {super.key, required this.listData,
      required this.callback,
      required this.name,
      required this.forbid});
  @override
  State<pl> createState() => _pl();
}

class _pl extends State<pl> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
        itemCount: widget.listData.length,
        itemBuilder: (context, index) {
          var item = widget.listData[index];
          return GestureDetector(
            child: Container(
                color: Colors.transparent,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                        visible:
                            widget.name == item[jlConfig.defaultValue['name']],
                        child: Icon(Icons.navigate_next_rounded, color: () {
                          ///正常模式
                          if (!widget.forbid) {
                            return widget.name ==
                                    item[jlConfig.defaultValue['name']]
                                ? TDTheme.of(context).brandNormalColor
                                : null;
                          }

                          ///禁止模式
                          return widget.name ==
                                      item[jlConfig.defaultValue['name']] &&
                                  item[jlConfig.defaultValue['forbid']] ==
                                      jlConfig.forbidValue
                              ? Colors.grey
                              : TDTheme.of(context).brandNormalColor;
                        }())),
                    TDText(
                        fontWeight: FontWeight.w400,
                        item[jlConfig.defaultValue['name']],
                        style: TextStyle(color: () {
                          if (!widget.forbid) {
                            return widget.name ==
                                    item[jlConfig.defaultValue['name']]
                                ? TDTheme.of(context).brandNormalColor
                                : null;
                          }

                          if (widget.name ==
                                  item[jlConfig.defaultValue['name']] &&
                              !item[jlConfig.defaultValue['forbid']] ==
                                  jlConfig.forbidValue) {
                            return TDTheme.of(context).brandNormalColor;
                          }
                           if (widget.name ==
                                  item[jlConfig.defaultValue['name']] &&
                              item[jlConfig.defaultValue['forbid']] ==
                                  jlConfig.forbidValue) {
                            return null;
                          }
                          // return widget.name ==
                          //             item[jlConfig.defaultValue['name']] &&
                          //         item[jlConfig.defaultValue['forbid']] ==
                          //             jlConfig.forbidValue
                          //     ? TDTheme.of(context).brandNormalColor
                          //     : null;

                        }(), fontStyle: () {
                          if (!widget.forbid) {
                            return null;
                          }
                          return item[jlConfig.defaultValue['forbid']] ==
                                  jlConfig.forbidValue
                              ? FontStyle.italic
                              : null;
                        }()), textColor: () {
                      if (!widget.forbid) {
                        return Colors.black;
                      }
                      return item[jlConfig.defaultValue['forbid']] ==
                              jlConfig.forbidValue
                          ? Colors.grey
                          : Colors.black;
                    }())
                  ],
                )),
            onTap: () {
              //选中后返回选中列表的数据

              widget.callback(
                  item[jlConfig
                      .defaultValue['organizationalStructureNoteVOList']],
                  item[jlConfig.defaultValue['name']],
                  item[jlConfig.defaultValue['id']],
                  item[jlConfig.defaultValue['forbid']]);
            },
          );
        });
  }
}
