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
