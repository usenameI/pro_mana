///获取日期（map格式）用于自定义组件
class dateGet {
  ///获取当前时间返回map格式
  static Map getDate() {
    var date = DateTime.now();
    return {
      'year': date.year,
      'month': date.month,
      'day': date.day,
      'hour': date.hour,
      'minute': date.minute,
      'second': date.second
    };
  }

  ///map时间转换yyyy-mm-dd格式
  static String formatDate(Map date) {
    ///获取时间状态
    if (date['year'] == null) {
      return '';
    }
    return '${date['year'].toString().padLeft(4, '0')}-'
        '${date['month'].toString().padLeft(2, '0')}-'
        '${date['day'].toString().padLeft(2, '0')}';
  }

  ///map时间转换yyyy-mm-dd hh:mm:ss格式
  static String formatDateAndTime(Map date) {
    if (date['year'] == null) {
      return '';
    }

    return '${date['year'].toString().padLeft(4, '0')}-'
        '${date['month'].toString().padLeft(2, '0')}-'
        '${date['day'].toString().padLeft(2, '0')} '
        '${date['hour'].toString().padLeft(2, '0')}:'
        '${date['minute'].toString().padLeft(2, '0')}:'
        '${date['second'].toString().padLeft(2, '0')}';
  }

  ///字符串转map格式
  static Map mapFromString(DateTime date,
      {int? hour, int? minute, int? second}) {
    return {
      'year': date.year,
      'month': date.month,
      'day': date.day,
      'hour': hour ?? date.hour,
      'minute': minute ?? date.minute,
      'second': second ?? date.second,
    };
  }

  ///Timestamp transfrom map
  static Map mapFromTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return {
      'year': dateTime.year,
      'month': dateTime.month,
      'day': dateTime.day,
      'hour': dateTime.hour,
      'minute': dateTime.minute,
      'second': dateTime.second,
    };
  }
}
