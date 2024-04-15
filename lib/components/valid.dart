import 'package:restaurante/components/message.dart';

validInput(String value, int min, int max) {
  if (value.isEmpty) {
    return "$messageInputEmpty";
  } else if (value.length > max) {
    return "$messaggeInputMax $max";
  } else if (value.length < min) {
    return "$messaggeInputMin $min";
  }
}

validMail(String value, int min, int max) {
  if (value.isEmpty) {
    return "$messageInputEmpty";
  } else if (value.length > max) {
    return "$messaggeInputMax $max";
  } else if (value.length < min) {
    return "$messaggeInputMin $min";
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "please enter a vlaid email";
  }
}
