import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModelJump extends StatelessWidget {
  const ModelJump({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MJ();
  }
}

class MJ extends StatefulWidget {
  const MJ({super.key});

  @override
  State<MJ> createState() {
    // TODO: implement createState
    return _MJ();
  }
}

class _MJ extends State<MJ> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('测试模态跳转'),
        ),
        body: ListView.builder(
          itemCount: bts.length,
          itemBuilder: (context, index) {
            return bts[index];
          },
        ));
  }

  List<Widget> get bts => [
        bt(
            title: 'Cupertino Photo Share Example',
            onTap: () {
              Navigator.of(context).push(MaterialWithModalsPageRoute(
                  builder: (context) => Container(
                        color: Colors.red,
                      )));
            }),
        bt(
            title: 'Material fit',
            onTap: () {
              showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                        color: Colors.red,
                      ),
                      );
            }),
            bt(
            title: 'Bar Modal',
            onTap: () {
             showBarModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                        color: Colors.red,
                      ),
                      );
            }),
            bt(
            title: 'Cupertino Modal fit',
            onTap: () {
              showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                        color: Colors.red,
                      )
                      );
            }),

      ];

  Widget bt({required String title, required Function() onTap}) {
    return ElevatedButton(onPressed: () => onTap(), child: Text(title));
  }
}
