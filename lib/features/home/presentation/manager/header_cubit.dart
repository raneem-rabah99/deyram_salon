import 'package:bloc/bloc.dart';

class AvailableForWorkCubit extends Cubit<bool> {
  AvailableForWorkCubit() : super(false);

  void toggleAvailability() => emit(!state);
}
