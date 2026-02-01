class DashboardData {
  final int servicesCount;
  final int categoriesCount;
  final int productsCount;

  DashboardData({
    required this.servicesCount,
    required this.categoriesCount,
    required this.productsCount,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      servicesCount: json['data']['services_count'],
      categoriesCount: json['data']['categories_count'],
      productsCount: json['data']['products_count'],
    );
  }
}
