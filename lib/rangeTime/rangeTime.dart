import 'package:flutter/material.dart';
import 'package:pro_mana/dateGet/dateGet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
// 范围日期选择
class rangeTime{

 static Future showDate(context) async {
    var startTime;
    var endTime;
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 300,
            height: 500,
            child: Column(
              children: [
                Expanded(
                  child: SfDateRangePicker(
                    headerStyle: const DateRangePickerHeaderStyle(
                        backgroundColor: Colors.white),
                    backgroundColor: Colors.white,
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      // 处理选择变化
                      startTime=args.value.startDate;
                      endTime=args.value.endDate;
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TDButton(
                      text: '确定',
                      theme: TDButtonTheme.primary,
                      onTap: () {
                        if(startTime!=null&&endTime!=null){
                        Navigator.pop(context,[
                          dateGet.mapFromString(startTime),
                          dateGet.mapFromString(endTime,
                          hour: 23,
                          minute: 59,
                          second: 59
                          ),
                        ]);
                        }
                      },
                    ),
                    const SizedBox(width: 10,),
                    TDButton(
                      text: '取消',
                      type: TDButtonType.text,
                      theme: TDButtonTheme.primary,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }



  static Future<sae> startAndEnd(context,Map start,Map end ) async {
    final DateTimeRange? picked = await showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Container(
                color: Colors.white,
               margin:const EdgeInsets.only(left: 10,right: 10,top: 50,bottom: 80),
                child: StatefulBuilder(
            builder: (context, setState) {
              return DateRangePickerDialog(
                firstDate: DateTime(2000),
                lastDate:  DateTime(2101),
                initialDateRange: start['year']==null?null: DateTimeRange(
                  start: DateTime(start['year']!,start['month'] ,start['day']),
                  end: DateTime(start['year']!,end['month'],end['day']),
                ),
              );
            },
          ),
              );
          },
        );
    return sae(start: {
      'year':picked!.start.year,
      'month':picked.start.month,
      'day':picked.start.day,
    }, end: {
      'year':picked.end.year,
      'month':picked.end.month,
      'day':picked.end.day,
    });
  }
}
class sae{
 Map<String,int> start;
 Map<String,int> end;
  sae({
    required this.start,
    required this.end
  });
}