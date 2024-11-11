import 'package:flutter/material.dart';
// 范围日期选择
class rangeTime{
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