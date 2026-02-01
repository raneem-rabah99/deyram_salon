import 'package:bloc/bloc.dart';
import 'package:deyram_salon/features/home/data/models/technical_model.dart';

import 'package:deyram_salon/features/home/presentation/manager/technical_state.dart';

class TechnicialCubit extends Cubit<TechnicialState> {
  TechnicialCubit() : super(TechnicialInitial());

  void addTechnician(Technicial technician) {
    final updatedTechnicians = List<Technicial>.from(state.technicials)
      ..add(technician);
    emit(TechnicialLoaded(updatedTechnicians));
  }
}
