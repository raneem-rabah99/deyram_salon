import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CouponsScreen extends StatefulWidget {
  @override
  _CouponsScreenState createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final Dio _dio = Dio();
  List<dynamic> _coupons = [];
  bool _loading = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
  }

  // Fetch coupons from the API
  Future<void> _fetchCoupons() async {
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final response = await _dio.get(
        'http://94.72.98.154/abdulrahim/public/api/coupons',
      );

      if (response.statusCode == 200) {
        print('Raw Response: ${response.data}'); // Inspect the response

        if (response.data is Map && response.data['data'] != null) {
          setState(() {
            _coupons =
                response.data['data']; // Extract coupons from the 'data' key
          });
        } else {
          setState(() {
            _error = 'No coupons available';
          });
        }
      } else {
        setState(() {
          _error =
              'Failed to load coupons. Status Code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coupons')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_loading) ...[
              Center(child: CircularProgressIndicator()),
            ] else ...[
              ElevatedButton(
                onPressed: _fetchCoupons,
                child: Text('Load Coupons'),
              ),
              if (_error.isNotEmpty) ...[
                SizedBox(height: 10),
                Text(_error, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 20),
              if (_coupons.isNotEmpty) ...[
                Expanded(
                  child: ListView.builder(
                    itemCount: _coupons.length,
                    itemBuilder: (context, index) {
                      final coupon = _coupons[index];
                      final rate = coupon['rate'] ?? 0;
                      final start = coupon['start'] ?? 'No Start Date';
                      final end = coupon['end'] ?? 'No End Date';
                      final provider = coupon['provider'] ?? {};
                      final name = provider['name'] ?? 'No Provider Name';
                      final bio = provider['bio'] ?? 'No Bio Available';

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text('$name'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rate: $rate%'),
                              Text('Valid from $start to $end'),
                              Text('Bio: $bio'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Center(child: Text('No coupons available')),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
