import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/pages/added_branch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/features/home/presentation/pages/edit_manage.dart';

class ManageBranch extends StatefulWidget {
  const ManageBranch({super.key});

  @override
  State<ManageBranch> createState() => _ManageBranchState();
}

class _ManageBranchState extends State<ManageBranch> {
  final Dio dio = Dio();
  List<Map<String, dynamic>> branches = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchBranches();
  }

  void addBranch(String name, String address, String city) {
    setState(() {
      branches.add({
        "name": name,
        "address": {
          "region": {
            "city": {"name": city},
            "name": address,
          },
        },
        "city": city,
      });
    });
  }

  Future<void> fetchBranches() async {
    try {
      Response response = await dio.get(
        "http://94.72.98.154/abdulrahim/public/api/branches",
      );

      print("API Response: ${response.data}"); // Debugging log

      if (response.statusCode == 200 &&
          response.data is Map &&
          response.data.containsKey("data")) {
        setState(() {
          branches = List<Map<String, dynamic>>.from(response.data["data"]);
          isLoading = false;
        });
      } else {
        throw Exception("Unexpected API response format");
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching branches: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Iconarrowleft.arowleft,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Manage Branches", style: TextStyle(fontFamily: 'Serif')),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromARGB(255, 176, 176, 176),
            height: 1.0,
          ),
        ),
      ),
      body:
          isLoading
              ? Center(
                child: CircularProgressIndicator(),
              ) // Show loading indicator
              : errorMessage.isNotEmpty
              ? Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(fontFamily: 'Serif', color: Colors.red),
                ),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        branches.map((branch) {
                          // Extracting correct city and area from nested API structure
                          String branchName =
                              branch["name"] ?? "Unknown Branch";
                          String city =
                              branch["address"]?["region"]?["city"]?["name"] ??
                              "No City";
                          String area =
                              branch["address"]?["region"]?["name"] ??
                              "No Area";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    branchName,
                                    style: TextStyle(
                                      fontFamily: 'Serif',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.darkpink,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: IconButton(
                                      icon: Icon(Icons.more_vert),
                                      color: Color.fromARGB(255, 12, 12, 12),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => EditManage(
                                                  branchName: branch["name"],
                                                  branchAddress:
                                                      branch["address"]?["region"]?["name"] ??
                                                      '',
                                                  branchCity:
                                                      branch["address"]?["region"]?["city"]?["name"] ??
                                                      '',
                                                ),
                                          ),
                                        ).then((updatedBranch) {
                                          if (updatedBranch != null) {
                                            // Get the updated data from the result
                                            setState(() {
                                              branch["name"] =
                                                  updatedBranch['branchName'];
                                              branch["address"]?["region"]?["name"] =
                                                  updatedBranch['address'];
                                              branch["address"]?["region"]?["city"]?["name"] =
                                                  updatedBranch['city'];
                                            });

                                            // Optionally, show a success message
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Branch updated successfully!",
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('•  $city'),
                                  SizedBox(width: 10),
                                  Text('•  $area'),
                                ],
                              ),
                              Divider(color: Colors.grey.shade400),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddManage(onBranchAdded: addBranch),
            ),
          );
        },
        backgroundColor: Color(0xFFA64D79), // Background color
        shape: CircleBorder(), // Ensures a circular shape
        child: Addcircleoutline.addcircl, // Using the custom image
      ),
    );
  }
}
