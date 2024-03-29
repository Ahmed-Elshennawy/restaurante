import 'package:restaurante/components/message.dart';

validInput(String value, int min, int max) {
  if (value.length > max) {
    return "$messaggeInputMax $max";
  } else if (value.length < min) {
    return "$messaggeInputMin $min";
  } else if (value.isEmpty) {
    return "$messageInputEmpty";
  }
}
