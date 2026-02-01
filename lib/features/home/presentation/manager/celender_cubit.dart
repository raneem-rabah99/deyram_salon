import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarCubit extends Cubit<List<Map<String, String>>> {
  final Dio dio = Dio(); // Initialize Dio instance

  CalendarCubit()
    : super([
        {"start": "09:00 AM", "end": "02:00 PM"},
        {"start": "04:00 PM", "end": "08:00 PM"},
        {"start": "09:00 PM", "end": "12:00 AM"},
      ]) {
    fetchAvailableDays(); // Fetch days on initialization
  }

  List<String> days = ["Loading..."]; // Default placeholder
  String selectedDay = "Every days";

  Future<void> fetchAvailableDays() async {
    try {
      Response response = await dio.get(
        "http://94.72.98.154/abdulrahim/public/api/days",
      );

      print("API Response: ${response.data}"); // Debugging log

      if (response.statusCode == 200 &&
          response.data is Map &&
          response.data.containsKey("data")) {
        List<dynamic> daysData = response.data["data"]; // Extract "data" array
        days =
            daysData
                .map((day) => day["name"].toString())
                .toList(); // Extract names
        selectedDay = days.isNotEmpty ? days.first : "No Days Available";
      } else {
        throw Exception("Unexpected API response format");
      }

      emit(List.from(state)); // Trigger UI update
    } catch (e) {
      print("Error fetching days: $e");
    }
  }

  void addShift() {
    if (state.length < 10) {
      emit([
        ...state,
        {"start": "Select Time", "end": "Select Time"},
      ]);
    }
  }

  void removeShift(int index) {
    final updatedShifts = List<Map<String, String>>.from(state);
    updatedShifts.removeAt(index);
    emit(updatedShifts);
  }

  void updateShift(int index, String startOrEnd, String newValue) {
    final updatedShifts = List<Map<String, String>>.from(state);
    updatedShifts[index][startOrEnd] = newValue;
    emit(updatedShifts);
  }

  void updateSelectedDay(String day) {
    selectedDay = day;
    emit(List.from(state)); // Trigger UI refresh
  }
}
