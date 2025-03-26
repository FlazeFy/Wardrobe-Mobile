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
