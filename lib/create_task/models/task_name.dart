class TaskName {
  const TaskName(this.value);

  final String value;

  bool isValid() {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }
}
