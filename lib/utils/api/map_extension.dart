import 'dart:convert';

import '../log_helper.dart';

extension APIMapBody on Map<String, dynamic> {
  bool hasStatusNum(int value, {bool printStatus = false}) {
    if (containsKey('status')) {
      final result = this['status'].toString() == value.toString();
      if (printStatus) {
        Log.error('API body status - ${this['status']}');
      }
      return result;
    }
    // print('hasStatusNumber - status param not contain');
    return false;
  }

  bool get hasMessage {
    return containsKey('message');
  }

  String pprint() {
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(this);
  }
}
