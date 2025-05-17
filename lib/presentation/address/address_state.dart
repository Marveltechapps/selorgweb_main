import 'package:selorgweb_main/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';

abstract class AddressState {}

class AddressInitialState extends AddressState {}

class AddressDummyState extends AddressState {}

class AddressLoadingState extends AddressState {}

class UpdateLocationState extends AddressState {
  final String location;

  UpdateLocationState({required this.location});
}


class NavigateState extends AddressState {
  final int index;

  NavigateState({required this.index});
}

class LocationSuccessState extends AddressState {
  String? latitude;
  String? longitude;
  String? place;

  LocationSuccessState({
    required this.latitude,
    required this.longitude,
    required this.place,
  });
}

class LocationContinueSuccessState extends AddressState {
  String? latitude;
  String? longitude;
  String? place;

  LocationContinueSuccessState({
    required this.latitude,
    required this.longitude,
    required this.place,
  });
}


class LatLongSuccessState extends AddressState {
  String latitude;
  String longitude;

  LatLongSuccessState({required this.latitude, required this.longitude});
}

class PlaceLocaitonState extends AddressState {
  final String locationText;

  PlaceLocaitonState({required this.locationText});
}

class SearchedLocationSuccessState extends AddressState {
  final List<SearchedLocationResponse> searchedLocationResponse;

  SearchedLocationSuccessState({required this.searchedLocationResponse});
}

class LatLongAddressSuccessState extends AddressState {
 final LatLongLocationResponse latLongLocationResponse;

  LatLongAddressSuccessState({required this.latLongLocationResponse});
}

class AddressErrorState extends AddressState {
  final String message;

  AddressErrorState({required this.message});
}
