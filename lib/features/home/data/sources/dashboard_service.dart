import 'package:deyram_salon/features/home/data/models/dashboard_data.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<DashboardData> fetchDashboardData() async {
    try {
      final response = await _dio.get(
        'http://94.72.98.154/abdulrahim/public/api/home-page',
      );

      if (response.statusCode == 200) {
        return DashboardData.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
