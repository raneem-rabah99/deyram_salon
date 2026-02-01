import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class CitiesCubit extends Cubit<Map<String, dynamic>> {
  final Dio _dio = Dio();

  CitiesCubit()
    : super({
        'cities': [],
        'countries': [],
        'selectedCity': 'United Arab Emirates',
        'selectedCountry': 'United Arab Emirates',
        'isCityDropdownOpen': false,
        'isCountryDropdownOpen': false,
      });

  void fetchCities() async {
    try {
      final response = await _dio.get(
        'http://94.72.98.154/abdulrahim/public/api/cities',
      );
      final List cities = response.data['data'] ?? [];
      emit({
        ...state,
        'cities':
            cities.map<String>((city) => city['name'].toString()).toList(),
      });
    } catch (e) {
      emit({...state, 'cities': []});
    }
  }

  void fetchCountries() async {
    try {
      final response = await _dio.get(
        'http://94.72.98.154/abdulrahim/public/api/countries',
      );
      final List countries = response.data['data'] ?? [];
      emit({
        ...state,
        'countries':
            countries
                .map<String>((country) => country['name'].toString())
                .toList(),
      });
    } catch (e) {
      emit({...state, 'countries': []});
    }
  }

  void selectCity(String city) {
    emit({...state, 'selectedCity': city, 'isCityDropdownOpen': false});
  }

  void selectCountry(String country) {
    emit({
      ...state,
      'selectedCountry': country,
      'isCountryDropdownOpen': false,
    });
  }

  void toggleCityDropdown() {
    emit({...state, 'isCityDropdownOpen': !state['isCityDropdownOpen']});
    if (state['cities'].isEmpty) {
      fetchCities();
    }
  }

  void toggleCountryDropdown() {
    emit({...state, 'isCountryDropdownOpen': !state['isCountryDropdownOpen']});
    if (state['countries'].isEmpty) {
      fetchCountries();
    }
  }
}

class CountrySelector extends StatelessWidget {
  final ValueChanged<String>? onSelected;
  final bool isCitySelector;

  const CountrySelector({
    Key? key,
    this.onSelected,
    required this.isCitySelector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, Map<String, dynamic>>(
      builder: (context, state) {
        final List<String> items =
            isCitySelector
                ? List<String>.from(state['cities'] ?? [])
                : List<String>.from(state['countries'] ?? []);
        final String selectedItem =
            isCitySelector
                ? (state['selectedCity'] ?? 'United Arab Emirates')
                : (state['selectedCountry'] ?? 'United Arab Emirates');
        final bool isDropdownOpen =
            isCitySelector
                ? state['isCityDropdownOpen'] ?? false
                : state['isCountryDropdownOpen'] ?? false;

        return GestureDetector(
          onTap:
              () =>
                  isCitySelector
                      ? context.read<CitiesCubit>().toggleCityDropdown()
                      : context.read<CitiesCubit>().toggleCountryDropdown(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffE3E3E3)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Iconlocation.location,
                            SizedBox(
                              width: 8,
                            ), // مسافة بسيطة بين الأيقونة والنص
                            Expanded(
                              child: Text(
                                'EX: $selectedItem',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffA3A3A3),
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // لتفادي تجاوز النص
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xffE3E3E3),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          isDropdownOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                if (isDropdownOpen)
                  Column(
                    children:
                        items
                            .map(
                              (item) => ListTile(
                                title: Text(item),
                                onTap: () {
                                  if (isCitySelector) {
                                    context.read<CitiesCubit>().selectCity(
                                      item,
                                    );
                                  } else {
                                    context.read<CitiesCubit>().selectCountry(
                                      item,
                                    );
                                  }
                                  onSelected?.call(item);
                                },
                              ),
                            )
                            .toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
