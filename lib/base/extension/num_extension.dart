extension NumExtension on num? {
  String get asMoneyString => this != null
      ? (this! < 0
          ? "-\$${(-this!).toStringAsFixed(2)}"
          : "\$${this!.toStringAsFixed(2)}")
      : "\$0.00";
}
