class BookingCardModel {
  final String userName;
  final String location;
  final String date;
  final String time;
  final double price;
  final bool isInHome;

  BookingCardModel({
    required this.userName,

    required this.location,
    required this.date,
    required this.time,
    required this.price,
    required this.isInHome,
  });
}
