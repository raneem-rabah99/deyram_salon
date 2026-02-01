import 'package:flutter_bloc/flutter_bloc.dart';

class TextCubit extends Cubit<String> {
  TextCubit() : super('Initial Text'); // Set the initial text value

  void updateText(String newText) {
    emit(newText); // Emit new text to update the state
  }
}
