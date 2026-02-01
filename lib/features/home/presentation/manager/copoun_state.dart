import 'package:deyram_salon/features/home/data/models/coupon.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CouponState {
  final List<Coupon> coupons;
  const CouponState(this.coupons);
}

class CouponInitial extends CouponState {
  CouponInitial() : super([]);
}

class CouponLoaded extends CouponState {
  CouponLoaded(List<Coupon> coupons) : super(coupons);
}
