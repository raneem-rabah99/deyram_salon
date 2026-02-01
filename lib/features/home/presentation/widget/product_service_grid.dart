import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:deyram_salon/core/theme/app_assets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductServiceGrid extends StatelessWidget {
  final List<String> items;
  final List<String> imageUrls;
  final List<String> prices;
  final bool isProduct;

  const ProductServiceGrid({
    required this.items,
    required this.imageUrls,
    required this.prices,
    required this.isProduct,
  });

  Future<String?> _getUserImage() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'image');
  }

  @override
  Widget build(BuildContext context) {
    final minLength = [
      items.length,
      imageUrls.length,
      prices.length,
    ].reduce((a, b) => a < b ? a : b);

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: minLength,
      itemBuilder: (context, index) {
        final imageUrl = imageUrls[index];
        final price = prices[index];

        if (isProduct) {
          // Product Card
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
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
                                  : NetworkImage(imageUrl) as ImageProvider,
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

              ImageProvider imageProvider;
              if (imagePath != null && File(imagePath).existsSync()) {
                imageProvider =
                    kIsWeb
                        ? NetworkImage(imagePath)
                        : FileImage(File(imagePath));
              } else {
                imageProvider = AssetImage(defaultImagePath);
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 14),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.asset(
                              imageUrl,
                              height: 70,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -20,
                            left: 14,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundImage: imageProvider,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
                      Padding(
                        padding: const EdgeInsets.all(6),
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
                            SizedBox(height: 4),
                            Text(
                              'Dubai, United Arab Emirates',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 6,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 6),
                                SizedBox(width: 4),
                                Text(
                                  '2 km away',
                                  style: TextStyle(
                                    fontSize: 6,
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
                                  '4.5 (36 Reviews)',
                                  style: TextStyle(
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
    );
  }
}
