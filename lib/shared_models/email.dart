import 'package:pomodoro_timer/helpers/constants/regular_expressions.dart';

class Email {
  final String value;

  const Email(this.value);

  bool isValid() {
    bool isValid = kEmailExpression.hasMatch(value);
    return isValid;
  }
}
