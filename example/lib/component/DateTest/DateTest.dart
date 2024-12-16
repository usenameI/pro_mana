
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
class DateTest extends StatefulWidget{
  const DateTest({super.key});
  @override
  State<DateTest> createState() {
    // TODO: implement createState
    return _DateTest();
  }
  
}
class _DateTest extends State<DateTest>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(child:   TDButton(
          text: 'rili',
          onTap: () {
                TDCalendarPopup(
                    context,
                    visible: true,
                    child: TDCalendar(
                       minDate: 946656000000,
                       maxDate: DateTime(3000,1,1).millisecondsSinceEpoch,
                      title: '请选择日期区间',
                      type: CalendarType.range,

                      height: 600,
                      // height: size.height * 0.6 + 176,
                    ),
                  );
          },
        ),),
    );
  }
  
}