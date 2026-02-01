import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/data/models/dashboard_data.dart';
import 'package:deyram_salon/features/home/data/sources/dashboard_service.dart';
import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DashboardData>(
      future: apiService.fetchDashboardData(), // Fetch data from the API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          final data = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xffE3E3E3), width: 2),
                    color: Colors.white,
                  ),
                  child: MetricsSection(
                    title: "Product Metrics Dashboard",
                    mainValue:
                        data.servicesCount.toString(), // Replace with API value
                    mainLabel: "Services Count", // Updated main label
                    subMetrics: [
                      {
                        "label": "Categories Count",
                        "value": data.categoriesCount.toString(),
                      }, // Replace with API value
                      {
                        "label": "Products Count",
                        "value": data.productsCount.toString(),
                      }, // Replace with API value
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffE3E3E3), width: 2),
                  color: Colors.white,
                ),
                child: MetricsSection(
                  title: "Product Metrics Dashboard",
                  mainValue: "900", // Example value (could be replaced)
                  mainLabel:
                      "A product you sold", // Example label (could be replaced)
                  subMetrics: [
                    {
                      "label": "Product requests",
                      "value": "50",
                    }, // Example value (could be replaced)
                    {
                      "label": "Waiting for shipping",
                      "value": "8",
                    }, // Example value (could be replaced)
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class MetricsSection extends StatelessWidget {
  final String title;
  final String mainValue;
  final String mainLabel;
  final List<Map<String, String>> subMetrics;

  MetricsSection({
    required this.title,
    required this.mainValue,
    required this.mainLabel,
    required this.subMetrics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.darkpink,
          ),
        ),
        SizedBox(height: 12),

        // Main Metric Box
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xffE3E3E3), width: 2),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                mainValue,
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkpink,
                ),
              ),
              SizedBox(height: 4),
              Text(
                mainLabel,
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),

        // Sub-Metrics in Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              subMetrics.map((item) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xffE3E3E3), width: 2),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          item["value"]!,
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkpink,
                          ),
                        ),
                        Text(
                          item["label"]!,
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

// 🔹 RATING SECTION (UPDATED)
class RatingSection extends StatelessWidget {
  final List<int> ratingData = [1343, 324, 122, 90, 33];

  @override
  Widget build(BuildContext context) {
    // حساب القيمة الأكبر لتحديد النسبة
    final int maxRating = ratingData.reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        // Rating Container
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xffE3E3E3), width: 2),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                "Your Rating In The Application",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkpink,
                ),
              ),
              Text(
                "4.8/5",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "2,343 RATINGS",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 10),

              // Rating Bars
              Column(
                children: List.generate(ratingData.length, (index) {
                  double percentage = (ratingData[index] / maxRating) * 0.5;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: percentage,
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColor.darkpink,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(ratingData[index].toString()),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
