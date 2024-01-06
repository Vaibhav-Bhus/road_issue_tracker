class Validations{
  String otpValidator(String val) {
    String error = '';

    if (val.trim().length < 5) error += 'OTP must be more than 5 charaters\n';
    if (val.trim().length >= 7) {
      error += 'OTP must be smaller than 7 charater\n';
    }
    if (val.contains((RegExp(r'[a-zA-Z]'))) ||
        val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      error += 'OTP must not contains alphabets/special charaters\n';
    }

    if (error != '') {
      return error;
    } else {
      return "";
    }
  }
  String phoneValidator(String val) {
    String error = '';

    if (val.trim().length != 10) error += 'Phone No. must be of 10 charaters\n';
    if (val.contains((RegExp(r'[a-zA-Z]'))) ||
        val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      error += 'Phone No. must not contains alphabets/special charaters\n';
    }

    if (error != '') {
      return error;
    } else {
      return "";
    }
  }
}