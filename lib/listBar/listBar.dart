import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:provider/provider.dart';

class barIcon{
  String title;
  Widget icon;
  barIcon({
    required this.title,
    required this.icon
  });
}

class listBarController {
  
}

class listController extends ChangeNotifier {
  update() {
    notifyListeners();
  }
}

class listBar extends StatefulWidget {
  EasyRefreshController reController;
  Future<int> Function() onLoad;
  Future<int> Function() onRefresh;
  Widget Function(BuildContext, int) widgetList;

  
  listBar(
      {required this.reController,
      required this.onLoad,
      required this.onRefresh,
      required this.widgetList});

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

  int listNum=0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      borderRadius: BorderRadius.circular(500),
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      showIcon: true,
      width: MediaQuery.of(context).size.width,
      barColor: PairWithWhite.hjl,
      start: 3,
      end: 0,
      offset: 10,
      barAlignment: Alignment.bottomCenter,
      iconHeight: 30,
      iconWidth: 30,
      reverse: false,
      barDecoration: BoxDecoration(
        color: colors[currentPage],
        borderRadius: BorderRadius.circular(500),
      ),
      iconDecoration: BoxDecoration(
        color: PairWithWhite.hjl,
        borderRadius: BorderRadius.circular(500),
      ),
      hideOnScroll: true,
      scrollOpposite: false,
      onBottomBarHidden: () {},
      onBottomBarShown: () {},
      body: (context, controller) {
        return ChangeNotifierProvider(
            create: (context) => listController(),
            child: Consumer<listController>(
              builder: (context, value, child) {
                return
                Scrollbar(child: EasyRefresh(
                  controller: widget.reController,
                  header: BallPulseHeader(
                      color: const Color.fromRGBO(121, 118, 254, 1)),
                  footer: BallPulseFooter(
                      color: const Color.fromRGBO(121, 118, 254, 1)),
                  onLoad: () async {
                  listNum = await widget.onLoad();
                   listNum = value.update();
                  },
                  onRefresh: () async {
                    await widget.onRefresh();
                    value.update();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                    controller: controller,
                    itemCount: listNum,
                    itemBuilder: (context, index) =>
                        widget.widgetList(context, index),
                  ),
                ))
                 ;
              },
            ));
      },
      child: Container(
        height: 50,
      ),
    );
  }
}
