import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:deyram_salon/core/theme/app_assets.dart';

import 'package:deyram_salon/features/home/presentation/manager/product_and_service_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final Dio dio;

  ProductCubit(this.dio) : super(ProductState());

  Future<void> fetchCategoriesa() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await dio.get(
        'http://94.72.98.154/abdulrahim/public/api/categories?filter[name]=m',
      );
      final List<String> categories =
          List<String>.from(
            response.data['data'].map((category) => category['name']),
          ).toSet().toList(); // Ensure unique values
      emit(state.copyWith(categories: categories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchProducts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await dio.get(
        'http://94.72.98.154/abdulrahim/public/api/products',
      );

      final List<String> products = List<String>.from(
        response.data['data'].map((product) => product['name']),
      );
      final List<String> productImages = List<String>.from(
        response.data['data'].map(
          (product) =>
              product['image_url'] != null && product['image_url'] != ''
                  ? product['image_url']
                  : AppAssets.Imageproduct,
        ),
      );

      final List<String> productPrices = List<String>.from(
        response.data['data'].map((product) => product['price'].toString()),
      );

      emit(
        state.copyWith(
          products: products,
          productImages: productImages,
          productPrices: productPrices,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchServices() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await dio.get(
        'http://94.72.98.154/abdulrahim/public/api/services',
      );

      final List<String> services = List<String>.from(
        response.data['data'].map((service) => service['name']),
      );
      final List<String> serviceImages = List<String>.from(
        response.data['data'].map(
          (service) =>
              service['image_url'] != null && service['image_url'] != ''
                  ? service['image_url']
                  : AppAssets.Imageservice,
        ),
      );
      final List<String> servicePrices = List<String>.from(
        response.data['data'].map((service) => service['price'].toString()),
      );

      emit(
        state.copyWith(
          services: services,
          serviceImages: serviceImages,
          servicePrices: servicePrices,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchBranchesa() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await dio.get(
        'http://94.72.98.154/abdulrahim/public/api/branches',
      );
      final List<String> branches = List<String>.from(
        response.data['data'].map((branch) => branch['name']),
      );
      emit(state.copyWith(branches: branches, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> addProductLocally(
    String name,
    String category,
    String branch,
    String price,
    String description,
  ) async {
    try {
      // Add the new product to the local list
      final newProducts = List<String>.from(state.products)..add(name);
      final newPrices = List<String>.from(state.productPrices)..add(price);
      final newImages = List<String>.from(state.productImages)
        ..add(AppAssets.Imageproduct); // Assuming a default image for now

      // Update the state with the new product
      emit(
        state.copyWith(
          products: newProducts,
          productPrices: newPrices,
          productImages: newImages,
        ),
      );

      // Optionally, if you need to also send the new product to an API:
      // await sendProductToApi(name, category, branch, price, description);

      debugPrint("Product added: $name");
      debugPrint("Updated Products List: $newProducts");
    } catch (e) {
      emit(state.copyWith(error: 'Error adding product: ${e.toString()}'));
      debugPrint("Error adding product: $e");
    }
  }

  Future<void> addServiceLocally(
    String name,
    String serviceType,
    String branch,
    String price,
    String description,
  ) async {
    try {
      final newServices = List<String>.from(state.services)..add(name);
      final newPrices = List<String>.from(state.servicePrices)..add(price);
      final newImages = List<String>.from(state.serviceImages)
        ..add(AppAssets.Imageservice);

      emit(
        state.copyWith(
          services: newServices,
          servicePrices: newPrices,
          serviceImages: newImages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Error adding service: ${e.toString()}'));
      debugPrint("Error adding service: $e");
    }
  }

  Future<void> fetchCategories() async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await dio.get(
        'http://94.72.98.154/abdulrahim/public/api/categories?filter[name]=m',
      );

      print("Categories API Response: ${response.data}"); // Debugging line

      final List<String> fetchedCategories =
          List<String>.from(
            response.data['data'].map((category) => category['name']),
          ).toSet().toList();

      // Merge existing categories with fetched ones
      final updatedCategories = Set<String>.from(state.categories)
        ..addAll(fetchedCategories);

      emit(
        state.copyWith(
          categories: updatedCategories.toList(),
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchBranches() async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await dio.get(
        'http://94.72.98.154/abdulrahim/public/api/branches',
      );
      print("Branches API Response: ${response.data}"); // Debugging line
      final List<String> branches = List<String>.from(
        response.data['data'].map((branch) => branch['name']),
      );
      emit(state.copyWith(branches: branches, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> addCategoryLocally(String nameEn, String nameAr) async {
    try {
      final newCategory = '$nameEn ($nameAr)'; // Store both languages
      final updatedCategories = List<String>.from(
        state.categories,
      ); // Ensure it's not null
      updatedCategories.add(newCategory); // Add new category
      emit(state.copyWith(categories: updatedCategories)); // Emit updated state

      debugPrint("Category added: $newCategory");
      debugPrint("Updated categories list: $updatedCategories"); // Debugging
    } catch (e) {
      emit(state.copyWith(error: 'Error adding category: ${e.toString()}'));
      debugPrint("Error adding category: $e");
    }
  }

  void addCategory(String categoryName) {
    // Add the new category to the list (for now, we assume it's a local list)
    List<String> updatedCategories = List.from(state.categories);
    updatedCategories.add(categoryName);

    // Emit the updated state with the new category
    emit(state.copyWith(categories: updatedCategories));
  }
}
