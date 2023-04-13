class MoreInfo {
  const MoreInfo(this.value);

  final String value;

  bool isValid() {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }
}
