import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GalleryCubit extends Cubit<List<File>> {
  GalleryCubit() : super([]);

  Future<void> pickImage() async {
    if (state.length >= 10) return;

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      emit([...state, File(pickedFile.path)]);
    }
  }

  void removeImage(int index) {
    final updatedList = List<File>.from(state);
    updatedList.removeAt(index);
    emit(updatedList);
  }
}
