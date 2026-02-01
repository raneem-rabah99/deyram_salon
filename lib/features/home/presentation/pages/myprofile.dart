import 'dart:io';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/features/home/presentation/manager/gallery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/core/theme/app_assets.dart'; // For default image in case there's no stored image
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_state.dart';
import 'package:deyram_salon/features/home/presentation/widget/product_service_grid.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String? _username;
  ImageProvider? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    final cubit = context.read<ProductCubit>();

    // Ensure to fetch products and services if they are empty
    if (cubit.state.products.isEmpty) cubit.fetchProducts();
    if (cubit.state.services.isEmpty) cubit.fetchServices();
  }

  // Load user data from FlutterSecureStorage
  Future<void> _loadUserData() async {
    final username = await _secureStorage.read(key: 'username');
    final imagePath = await _secureStorage.read(key: 'image');

    ImageProvider imageProvider;

    if (imagePath != null && File(imagePath).existsSync()) {
      // If imagePath exists and the file is available, use it
      imageProvider = FileImage(File(imagePath));
    } else {
      // Otherwise, use a default image
      imageProvider = AssetImage('assets/images/deram 1.png');
    }

    setState(() {
      _username =
          username ?? 'No username'; // If no username, default to 'No username'
      _profileImage = imageProvider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Iconarrowleft.arowleft,
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            "My Profile",
            style: TextStyle(
              fontFamily: 'Serif',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            // Background
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/combination.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  // Profile Image
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _profileImage ??
                          AssetImage(
                            'assets/images/deram 1.png',
                          ), // Default image if no profile image available
                    ),
                  ),
                  SizedBox(height: 6),
                  // Username
                  Text(
                    _username ?? 'Loading...',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: AboutDialogWithGallery(),
                                  ),
                            ),
                        child: Text("About"),
                      ),
                      SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text("Loyalty Points"),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  // Tabs
                  Column(
                    children: [
                      Container(
                        child: TabBar(
                          labelColor: Colors.black,
                          indicatorColor: Theme.of(context).primaryColor,
                          tabs: [
                            Tab(text: "Services"),
                            Tab(text: "Product"),
                            Tab(text: "Review"),
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        child: TabBarView(
                          children: [
                            // Services Tab
                            BlocBuilder<ProductCubit, ProductState>(
                              builder: (context, state) {
                                if (state.isLoading)
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                if (state.error != null)
                                  return Center(
                                    child: Text("Error: ${state.error}"),
                                  );

                                final services = state.services;
                                final serviceImages = state.serviceImages;
                                final prices = state.servicePrices;

                                if (services.isEmpty)
                                  return Center(
                                    child: Text("No services available."),
                                  );

                                return ProductServiceGrid(
                                  items: services,
                                  imageUrls:
                                      serviceImages.isNotEmpty
                                          ? serviceImages
                                          : List.filled(
                                            services.length,
                                            AppAssets.Imageproduct,
                                          ),
                                  prices:
                                      prices.isNotEmpty
                                          ? prices
                                          : List.filled(services.length, "N/A"),
                                  isProduct: false,
                                );
                              },
                            ),
                            // Product Tab
                            BlocBuilder<ProductCubit, ProductState>(
                              builder: (context, state) {
                                if (state.isLoading)
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                if (state.error != null)
                                  return Center(
                                    child: Text("Error: ${state.error}"),
                                  );

                                final products = state.products;
                                final productImages = state.productImages;
                                final prices = state.productPrices;

                                if (products.isEmpty)
                                  return Center(
                                    child: Text("No products available."),
                                  );

                                return ProductServiceGrid(
                                  items: products,
                                  imageUrls:
                                      productImages.isNotEmpty
                                          ? productImages
                                          : List.filled(
                                            products.length,
                                            AppAssets.Imageproduct,
                                          ),
                                  prices:
                                      prices.isNotEmpty
                                          ? prices
                                          : List.filled(products.length, "N/A"),
                                  isProduct: true,
                                );
                              },
                            ),
                            // Review Tab (placeholder)
                            Center(child: Text("Review")),
                          ],
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
  }
}

class AboutDialogWithGallery extends StatelessWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String> _loadAboutText() async {
    final about = await _storage.read(key: 'aboutText');
    return about ?? "No about info available.";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Provider",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                ),
              ),
            ),
            SizedBox(height: 16),
            // Load About Text
            FutureBuilder<String>(
              future: _loadAboutText(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if (snapshot.hasError) return Text("Error loading about info.");
                return Text(
                  snapshot.data!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, height: 1.6),
                );
              },
            ),
            SizedBox(height: 20),
            // Gallery Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Gallery Work",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Gallery Images
            BlocBuilder<GalleryCubit, List<File>>(
              builder: (context, images) {
                if (images.isEmpty) {
                  return Text("No photos available.");
                }

                return SizedBox(
                  height: 100,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length > 4 ? 4 : images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(images[index], fit: BoxFit.cover),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
