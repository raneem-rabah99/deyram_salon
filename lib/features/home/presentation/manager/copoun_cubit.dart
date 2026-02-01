import 'package:bloc/bloc.dart';
import 'package:deyram_salon/features/home/data/models/coupon.dart';
import 'package:deyram_salon/features/home/presentation/manager/copoun_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit() : super(CouponInitial());

  void addCoupon(Coupon coupon) {
    final List<Coupon> updatedCoupons = List.from(state.coupons)..add(coupon);
    emit(CouponLoaded(updatedCoupons));
  }
}
