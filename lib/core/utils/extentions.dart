extension StringOperation on String {
  String toFirstCaps() {
    try {
      return (this).substring(0, 1).toUpperCase() +
            (this).substring(1, (this).length)
        ..toLowerCase();
    } catch (e) {
      return this;
    }
  }
}
