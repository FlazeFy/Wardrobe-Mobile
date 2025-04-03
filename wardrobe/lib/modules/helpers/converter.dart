import 'package:intl/intl.dart';

String getCleanTitleFromCtx(String val) {
  try {
    String newVal = val.replaceAll('_', ' ');
    String cap = newVal
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');

    return cap;
  } catch (error) {
    throw Exception(error.toString());
  }
}

String getMessageResponseFromObject(val, type) {
  var res = "";

  if (val is String) {
    return val;
  } else {
    if (type == "login") {
      if (val.containsKey('username') != null) {
        var usernameErr = val['username'];

        if (usernameErr != null) {
          res += "${usernameErr.join('\n')}";
        }
      }
      if (val.containsKey('password')) {
        var passErr = val['password'];
        if (passErr != null) {
          res += "${passErr.join('\n')}";
        }
      }
    }

    return res;
  }
}

String getErrorValidation(dynamic val) {
  List<String> messages = [];

  if (val is! String) {
    val.forEach((key, error) {
      if (error is List) {
        messages.addAll(error.map((e) => e.toString()));
      } else if (error is String) {
        messages.add(error);
      }
    });

    return messages.join(', ').replaceAll('.', '');
  } else {
    return val;
  }
}

String numberToPrice(double val) {
  try {
    if (val >= 1000) {
      String res = (val / 1000).toStringAsFixed(0);
      return '${res}K';
    } else {
      return val.toString();
    }
  } catch (error) {
    throw Exception(error.toString());
  }
}

String commaThousandFormat(double val) {
  try {
    final formatter = NumberFormat("#,###", "en_US");
    return formatter.format(val);
  } catch (error) {
    throw Exception(error.toString());
  }
}

String formatCurrency(double val) {
  // final prefs = await SharedPreferences.getInstance();
  // String currencyType =
  //     prefs.getString("currency_type") ?? 'Abbreviated Numeral';
  String currencyType = 'Abbreviated Numeral';

  if (currencyType == 'Abbreviated Numeral') {
    return "Rp. ${numberToPrice(val)}";
  } else if (currencyType == 'Rupiah' ||
      currencyType == 'Rupiah With Zero Sen') {
    return "Rp. ${commaThousandFormat(val)}${currencyType == 'Rupiah With Zero Sen' ? '.00' : ''}";
  } else if (currencyType == 'Rupiah Without Format') {
    return "Rp. $val";
  }

  return "Rp. $val";
}

int getUTCHourOffset() {
  return DateTime.now().timeZoneOffset.inHours;
}

String convertDatetimeBasedLocal(String datetime) {
  DateTime result = DateTime.parse(datetime);
  int offsetHours = getUTCHourOffset();
  result = result.add(Duration(hours: offsetHours));

  return DateFormat("yyyy-MM-dd HH:mm").format(result);
}
