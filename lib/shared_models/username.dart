class Username {
  final String value;

  const Username(this.value);

  bool isValid() {
    if (value.isEmpty) {
      return false;
    }
    if (value.length > 25) {
      return false;
    }
    if (value.contains('badword')) {
      return false;
    }
    return true;
  }
}
