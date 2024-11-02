class recursion {
  ///递归根据条件定位数据再根据键名获取到想要的键值
  static String? getValueForData(
      {required dynamic data,
      required String conditionKey,
      required String conditionValue,
      required String keyName}) {
    String? value;
    if (data is List) {
      for (var e in data) {
        var v = getValueForData(
            data: e,
            conditionKey: conditionKey,
            conditionValue: conditionValue,
            keyName: keyName);
        if (v != null) {
          value = v;
        }
      }
    }

    if (data is Map) {
      if (data[conditionKey] == conditionValue) {
        print('log__${data[conditionKey]}:$conditionValue');
        value = data[keyName];
      } else {
        for (var entry in data.entries) {
          if (entry.value is List) {
            var v = getValueForData(
                data: entry.value,
                conditionKey: conditionKey,
                conditionValue: conditionValue,
                keyName: keyName);
            if (v != null) {
              value = v;
            }
          }
        }
      }
    }

    return value;
  }
}
