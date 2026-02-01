import 'dart:io';

import 'package:deyram_salon/features/home/presentation/pages/add_service_page.dart';
import 'package:deyram_salon/features/home/presentation/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_assets.dart';

import 'package:deyram_salon/features/home/presentation/manager/product_and_service_state.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/add_product_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductServiceScreen extends StatefulWidget {
  @override
  _ProductServiceScreenState createState() => _ProductServiceScreenState();
}

class _ProductServiceScreenState extends State<ProductServiceScreen> {
  int _selectedIndex = 0;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String?> _getUserImage() async {
    return await _secureStorage.read(key: 'image');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<ProductCubit>();
      cubit.fetchCategories();
      cubit.fetchProducts();
      cubit.fetchServices();
      cubit.fetchBranches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCubit>.value(
      value: context.read<ProductCubit>(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Iconarrowleft.arowleft,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false,
                );
              },
            ),
            title: Text('Products and Services'),

            bottom: TabBar(
              onTap: (index) => setState(() => _selectedIndex = index),
              tabs: [Tab(text: 'Products'), Tab(text: 'Services')],
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3.0, // Adjust width as needed
                  color: Color(0xff4E1830),
                ),
                insets: EdgeInsets.symmetric(
                  horizontal: 120.0,
                ), // Adjust for wider indicator
              ),
              labelColor: Color(0xff4E1830),
              labelStyle: TextStyle(
                fontFamily: 'Serif',
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Make selected text bold
              ),
            ),
          ),
          body: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state.error != null) {
                return Center(
                  child: Text(
                    'Error: ${state.error}',
                    style: TextStyle(fontFamily: 'Serif', color: Colors.red),
                  ),
                );
              }

              // Get the correct list depending on the selected tab
              final items =
                  _selectedIndex == 0 ? state.products : state.services;
              final imageUrls =
                  _selectedIndex == 0
                      ? state.productImages
                      : state.serviceImages;
              final prices =
                  _selectedIndex == 0
                      ? state.productPrices
                      : state.servicePrices;

              final minLength = [
                items.length,
                imageUrls.length,
                prices.length,
              ].reduce((a, b) => a < b ? a : b);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: minLength,
                  itemBuilder: (context, index) {
                    final imageUrl = imageUrls[index];
                    // Default image if null
                    final price = prices[index]; // Default price if null

                    if (_selectedIndex == 0) {
                      // Product Card
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                    image: DecorationImage(
                                      image:
                                          imageUrl == AppAssets.Imageproduct
                                              ? AssetImage(imageUrl)
                                              : NetworkImage(imageUrl)
                                                  as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index],
                                    style: TextStyle(
                                      fontFamily: 'Serif',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "\$$price",
                                    style: TextStyle(
                                      fontFamily: 'Serif',
                                      fontSize: 8,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Service Card
                      return FutureBuilder<String?>(
                        future: _getUserImage(),
                        builder: (context, snapshot) {
                          String? imagePath = snapshot.data;
                          String defaultImagePath = AppAssets.user;

                          ImageProvider? imageProvider;
                          if (imagePath != null &&
                              File(imagePath).existsSync()) {
                            imageProvider =
                                kIsWeb
                                    ? NetworkImage(imagePath)
                                    : FileImage(File(imagePath));
                          } else {
                            imageProvider = AssetImage(defaultImagePath);
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    clipBehavior:
                                        Clip.none, // Ensures the circle is not clipped
                                    children: [
                                      // Main Service Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                        child: Image.asset(
                                          imageUrl,
                                          height: 75,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Small Circular Logo (Above the Image)
                                      Positioned(
                                        top:
                                            -20, // Moves the circle above the main image
                                        left: 14,
                                        child: CircleAvatar(
                                          radius: 23,
                                          backgroundImage: imageProvider,
                                        ),
                                      ),
                                      // Salon Label (Bottom-Right)
                                      Positioned(
                                        right: 10,
                                        bottom: 10,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            'Salon',
                                            style: TextStyle(
                                              fontFamily: 'Serif',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Card Details Below the Image
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index],
                                          style: TextStyle(
                                            fontFamily: 'Serif',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Dubai, United Arab Emirates',
                                          style: TextStyle(
                                            fontFamily: 'Serif',
                                            fontSize: 8,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 8,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '2 km away',
                                              style: TextStyle(
                                                fontFamily: 'Serif',
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 9,
                                              color: Colors.yellow[700],
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              '4.5 (38 Reviews)',
                                              style: TextStyle(
                                                fontFamily: 'Serif',
                                                fontSize: 9,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider.value(
                        value: context.read<ProductCubit>(),
                        child:
                            _selectedIndex == 0
                                ? AddProductPage()
                                : AddServicePage(),
                      ),
                ),
              );

              if (result == true) {
                setState(() {});
              }
            },
            backgroundColor: Color(0xFFA64D79),
            shape: CircleBorder(),
            child: Addcircleoutline.addcircl,
          ),
        ),
      ),
    );
  }
}
