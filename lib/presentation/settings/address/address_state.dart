import 'package:geocoding/geocoding.dart';
import 'package:selorgweb_main/model/addaddress/delete_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/get_saved_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';

abstract class AddressState {}

class AddressInitialState extends AddressState {}

class AddressLoadingState extends AddressState {}

class AddressSuccessState extends AddressState {
  final GetSavedAddressResponse getSavedAddressResponse;

  AddressSuccessState({required this.getSavedAddressResponse});
}

class AddressDeletedSuccessState extends AddressState {
  final DeleteAddressResponse deleteAddressResponse;

  AddressDeletedSuccessState({required this.deleteAddressResponse});
}

class AddressErrorState extends AddressState {
  final String errorMsg;

  AddressErrorState({required this.errorMsg});
}

class LocationSuccessStateFromAPi extends AddressState {
  String? latitude;
  String? longitude;
  Placemark? place;

  LocationSuccessStateFromAPi(
      {required this.latitude, required this.longitude, required this.place});
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

class SearchedLocationSuccessState extends AddressState {
  final List<SearchedLocationResponse> searchedLocationResponse;

  SearchedLocationSuccessState({required this.searchedLocationResponse});
}