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
