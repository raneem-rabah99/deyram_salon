import 'package:flutter_bloc/flutter_bloc.dart';

// State Class
class LoyaltyState {
  final String cache;
  final String points;
  final String balance;

  LoyaltyState({
    this.cache = "15 \$",
    this.points = "7 Points",
    this.balance = "7 Points",
  });
}

// Cubit Class
class LoyaltyCubit extends Cubit<LoyaltyState> {
  LoyaltyCubit() : super(LoyaltyState());

  void updateCache(String value) => emit(
    LoyaltyState(cache: value, points: state.points, balance: state.balance),
  );
  void updatePoints(String value) => emit(
    LoyaltyState(cache: state.cache, points: value, balance: state.balance),
  );
  void updateBalance(String value) => emit(
    LoyaltyState(cache: state.cache, points: state.points, balance: value),
  );

  void save() {
    print("Saved Data:");
    print("Cache: ${state.cache}");
    print("Points: ${state.points}");
    print("Balance: ${state.balance}");
  }
}
