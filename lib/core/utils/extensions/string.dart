
extension StringExtension on String {
  // DateFormat get monthFormatter => DateFormat.MMMd();
  bool get isNullOrEmpty => isEmpty;

}

extension StringExtension2 on String? {
  // DateFormat get monthFormatter => DateFormat.MMMd();
  bool get isNullOrEmpty => this == null || this!.isEmpty;


}
