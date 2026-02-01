class OrderModel {
  final String userName;
  final String location;
  final double price;

  OrderModel({
    required this.userName,
    required this.location,
    required this.price,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userName: json['user_name'] ?? '',
      location: json['location'] ?? '',
      price:
          (json['price'] != null)
              ? double.tryParse(json['price'].toString()) ?? 0.0
              : 0.0,
    );
  }
}
