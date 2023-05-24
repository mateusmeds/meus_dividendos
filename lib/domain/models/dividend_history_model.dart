class DividendHistoryModel {
  final DateTime? paymentDate;
  final double value;

  DividendHistoryModel({
    required this.value,
    this.paymentDate,
  });

  bool get received {
    DateTime dateNow = DateTime.now();
    return dateNow.isAfter(paymentDate ?? dateNow);
  }
}
