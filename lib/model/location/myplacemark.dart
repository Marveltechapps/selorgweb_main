import 'package:flutter/material.dart';

class Placemark {
  final String name;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Placemark({
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Placemark.fromGooglePlace(Map<String, dynamic> json) {
    debugPrint('function started');
    String getType(List types, String target) =>
        types.contains(target) ? target : '';

    String getComponent(String type) {
      return json['address_components']?.firstWhere(
            (comp) => (comp['types'] as List).contains(type),
            orElse: () => null,
          )?['long_name'] ??
          '';
    }

    return Placemark(
      name: json['name'] ?? '',
      street: getComponent('route'),
      city: getComponent('locality'),
      state: getComponent('administrative_area_level_1'),
      postalCode: getComponent('postal_code'),
      country: getComponent('country'),
    );
  }

  @override
  String toString() {
    return "$name, $street, $city, $state $postalCode, $country";
  }
}
