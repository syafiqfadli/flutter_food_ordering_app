class InputValidator {
  String? emailValidation(String? text) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text!);

    if (text.isEmpty) {
      return "Please enter email";
    }

    if (!emailValid) {
      return "Please enter valid email";
    }

    return null;
  }

  String? passwordValidation(String? text) {
    if (text!.isEmpty) {
      return "Please enter password";
    }

    return null;
  }

  String? emptyValidation(String? text) {
    if (text!.isEmpty) {
      return "Please do not leave empty.";
    }

    return null;
  }

  String? createPasswordValidation(String? text) {
    bool passValid =
        RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$").hasMatch(text!);

    if (text.isEmpty) {
      return "Please enter password";
    }

    if (!passValid) {
      return "Please enter valid password";
    }

    return null;
  }
}
