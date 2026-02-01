class BookingModel {
  final String userName;
  final String providerName;
  final String location;
  final String date;
  final String time;
  final double price;
  final bool isInHome;

  BookingModel({
    required this.userName,
    required this.providerName,
    required this.location,
    required this.date,
    required this.time,
    required this.price,
    required this.isInHome,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      userName: json['userName'] ?? 'Unknown',
      providerName: json['providerName'] ?? 'Unknown',
      location: json['location'] ?? 'No Location',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      isInHome: json['isInHome'] ?? false,
    );
  }
}
