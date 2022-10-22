class CheckDynamics {
  static int myInt(dynamic v) {
    if (v == null) {
      return 0;
    } else if (v is int) {
      return v;
    } else {
      return int.parse(v);
    }
  }

  static bool myBool(dynamic v) {
    if (v == null) {
      return false;
    } else if (v is bool) {
      return v;
    } else {
      return false;
    }
  }

  static String myString(dynamic v) {
    if (v == null) {
      return '';
    } else if (v is String) {
      return v;
    } else {
      return v.toString();
    }
  }

  static double myDouble(dynamic v) {
    if (v == null) {
      return 0.0;
    } else if (v is double) {
      return v;
    } else if (v is int) {
      return v.toDouble();
    } else if (v is String) {
      v = v.replaceAll(RegExp(r'\s+'), '');
      if (v == '') {
        return 0.0;
      }
      return double.parse(v);
    }
    return 0.0;
  }
}
