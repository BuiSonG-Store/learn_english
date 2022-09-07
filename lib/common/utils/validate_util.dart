class ValidateUtil {
  static String? validEmail(String input, {bool required = false}) {
    if (!required && input.isEmpty) {
      return null;
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(input.trim())) {
      return null;
    }
    return 'Email không hợp lệ';
  }

  static String? validName(String? name) {
    if (((name?.length ?? 0) < 5) || ((name?.length ?? 0) > 30)) {
      return 'Họ tên phải lớn hơn 5 và nhỏ hơn 30 ký tự';
    }
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(name!)) {
      List<String> subString = name.trim().split(' ');
      if ((subString.isNotEmpty) && subString.length >= 2) {
        for (final obj in subString) {
          if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(obj)) {
            return 'Tên chỉ được chứa chữ cái hoặc số';
          }
        }
        return null;
      }
      return 'Tên chỉ được chứa chữ cái hoặc số';
    }
    return null;
  }

  static String? validEmpty(String? input, {String? content}) {
    if (input?.isEmpty ?? true) {
      return content ?? 'Mục này không được bỏ trống';
    }
    return null;
  }

  static String? validPassword(String? input, {String? content}) {
    if (input?.isEmpty ?? true) {
      return content ?? 'Mục này không được bỏ trống!';
    }
    if (input!.length < 6) {
      return content ?? 'Mật khẩu phải lớn hơn 6 ký tự!';
    }
  }
}
