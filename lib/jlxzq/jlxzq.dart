import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
///默认键名
Map defaultValue={
  'name':'name',
  'id':'id',
  'organizationalStructureNoteVOList':'organizationalStructureNoteVOList'
};

///设置键名
setDefaultValue(jlType type){

    switch(type){
      case jlType.part:
      defaultValue={
         'name':'label',
          'id':'id',
          'organizationalStructureNoteVOList':'children'
      };
   
      break;
      case jlType.area:
      defaultValue={
        'name':'name',
        'id':'id',
        'organizationalStructureNoteVOList':'organizationalStructureNoteVOList'
      };
      break;
      case jlType.book:
      defaultValue={
        'name':'name',
        'id':'id',
        'organizationalStructureNoteVOList':'phoneBookNodeVOList'
      };
      break;
      case jlType.device:
            defaultValue={
        'name':'name',
        'id':'id',
        'organizationalStructureNoteVOList':'deviceManageNodeVOList'
      };
      break;
    }
}

///枚举
enum jlType{
  part,
  area,
  book,
  device
}

///级联选择器的控制器
class customJlxzqController extends ChangeNotifier {
  customJlxzqController(){
    stack.add({});
  }
  List stack = [];
  ///获取已选中的所有数据
  List getSelectData(){
    List vs = List.from(stack);
    vs.removeWhere((element) => element[defaultValue['name']] == null);
    return vs;
  }
  ///通知
  void toggle(){
    notifyListeners();
  }
}
///弹窗ui
class useCustomJLXZQ {
  customJlxzqController controller = customJlxzqController();
  Future show(context, {
    required List data, 
    required callBack,
    required jlType type
    }) async {
      setDefaultValue(type);
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
                    data: data,
                    controller: controller, callback: (value){

                    },
                  )));
        }));
  }
}

class customJlxzq extends StatefulWidget {
  customJlxzqController? controller;
  List data;
  Function callback;
  customJlxzq({this.controller, required this.data,required this.callback});
  @override
  State<customJlxzq> createState() => _customJlxzq();
}

class _customJlxzq extends State<customJlxzq> with TickerProviderStateMixin {
//  List stack=[];
  List stackC = [];
  List Contents = [];
  int pageIndex = 0;
  PageController _pageController = PageController();
  TabController? _tab;
  void _updateState() {
    setState((){}); // 更新状态以反映控制器的变化
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // stack.add({});
    Contents.add(widget.data);
    _tab = TabController(length: widget.controller!.stack.length, vsync: this);
    widget.controller?.addListener(_updateState);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('log__级联数据${widget.data}');
      //  addListV(pageIndex,);
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
      if (data[defaultValue['id']] == id) {
        useData = {
          'name': data[defaultValue['name']],
          'id': data[defaultValue['id']],
          defaultValue['organizationalStructureNoteVOList']:
          data[defaultValue['organizationalStructureNoteVOList']]
        };
      } else {
        var v = DG(data[defaultValue['organizationalStructureNoteVOList']], id);
        if (v != null){
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
        var v = remove(data[defaultValue['organizationalStructureNoteVOList']], id);
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
                    text: e[defaultValue['name']] ?? '请选择',
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
                    listData: Contents[index],
                    name: widget.controller?.stack[index][defaultValue['name']],
                    callback: (value, name, id) {
                      var v = DG(widget.data, id);
                      widget.callback(v);
                      widget.controller?.stack[index][defaultValue['id']] = id;
                      widget.controller?.stack[index][defaultValue['name']] = name;
                      for (var i = widget.controller!.stack.length - 1;
                          i > -1;
                          i--) {
                        if (widget.controller?.stack[i][defaultValue['id']] == null) {
                          widget.controller?.stack.removeAt(i);
                          Contents.removeAt(i);
                        }
                      }
                      if (widget.controller!.stack.length > pageIndex + 1) {
                        for (var i = widget.controller!.stack.length - 1;
                            i > index;
                            i--) {
                          var va = remove(
                              v[defaultValue['organizationalStructureNoteVOList']], id);
                          if (va == false) {
                            widget.controller?.stack.removeAt(i);
                            Contents.removeAt(i);
                          }
                        }
                      }
                      if (v[defaultValue['organizationalStructureNoteVOList']] == null) {
                        renewState();
                        return;
                      } else if (v[defaultValue['organizationalStructureNoteVOList']]
                          is List) {
                        if (v[defaultValue['organizationalStructureNoteVOList']].length ==
                            0) {
                          renewState();
                          setState(() {});
                          return;
                        }
                      }
                      widget.controller?.stack.add({});
                      // print('log___dangqinav)
                      Contents.add(v[defaultValue['organizationalStructureNoteVOList']]);
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
  Function callback;
  dynamic name;
  pl({required this.listData, required this.callback, required this.name});
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
                        visible: widget.name == item[defaultValue['name']],
                        child: Icon(
                          Icons.navigate_next_rounded,
                          color: TDTheme.of(context).brandNormalColor,
                        )),
                    TDText(
                      fontWeight: FontWeight.w400,
                      item[defaultValue['name']],
                      style: TextStyle(
                        color: widget.name == item[defaultValue['name']]
                            ? TDTheme.of(context).brandNormalColor
                            : null,
                      ),
                    )
                  ],
                )),
            onTap: () {
              //选中后返回选中列表的数据
      
              widget.callback(
                item[defaultValue['organizationalStructureNoteVOList']],
                item[defaultValue['name']], 
                item[defaultValue['id']]
                );
            },
          );
        });
  }
}
