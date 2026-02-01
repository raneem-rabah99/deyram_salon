class ProductState {
  final List<String>? newCategories;
  final List<String> categories;
  final List<String> products;
  final List<String> services;
  final List<String> branches;
  final List<String> productImages;
  final List<String> serviceImages;
  final List<String> productPrices;
  final List<String> servicePrices;
  final bool isLoading;
  final String? error;

  ProductState({
    this.newCategories = const [],
    this.categories = const [],
    this.products = const [],
    this.services = const [],
    this.branches = const [],
    this.productImages = const [],
    this.serviceImages = const [],
    this.productPrices = const [],
    this.servicePrices = const [],
    this.isLoading = false,
    this.error,
  });

  ProductState copyWith({
    List<String>? newCategories,
    List<String>? categories,
    List<String>? products,
    List<String>? services,
    List<String>? branches,
    List<String>? productImages,
    List<String>? serviceImages,
    List<String>? productPrices,
    List<String>? servicePrices,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      newCategories: newCategories ?? this.newCategories,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      services: services ?? this.services,
      branches: branches ?? this.branches,
      productImages: productImages ?? this.productImages,
      serviceImages: serviceImages ?? this.serviceImages,
      productPrices: productPrices ?? this.productPrices,
      servicePrices: servicePrices ?? this.servicePrices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
