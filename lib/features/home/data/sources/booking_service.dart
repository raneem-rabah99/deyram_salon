import 'package:deyram_salon/features/home/data/models/booking_model_item.dart';
import 'package:dio/dio.dart';

class BookingRepository {
  final Dio _dio = Dio();

  Future<List<BookingModelItem>> fetchAppointments() async {
    try {
      Response response = await _dio.get(
        "http://94.72.98.154/abdulrahim/public/api/appointments",
        queryParameters: {
          "status": [1, 2, 3, 4, 5, 6, 7],
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['appointments'];
        return data.map((json) => BookingModelItem.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load appointments");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
