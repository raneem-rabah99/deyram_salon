import 'package:deyram_salon/features/home/data/models/technical_model.dart';
import 'package:flutter/foundation.dart'; // Required for @immutable
import 'package:meta/meta.dart'; // Required for @immutable

@immutable
abstract class TechnicialState {
  final List<Technicial> technicials;
  const TechnicialState(this.technicials);
}

class TechnicialInitial extends TechnicialState {
  TechnicialInitial() : super([]);
}

class TechnicialLoaded extends TechnicialState {
  TechnicialLoaded(List<Technicial> technicials) : super(technicials);
}
