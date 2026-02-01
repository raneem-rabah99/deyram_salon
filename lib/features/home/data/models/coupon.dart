class Coupon {
  final String code;
  final double discount;
  final String message;
  final DateTime startDate;
  final DateTime endDate;
  final String category;
  final bool sendNotification;

  Coupon({
    required this.code,
    required this.discount,
    required this.message,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.sendNotification,
  });
}
