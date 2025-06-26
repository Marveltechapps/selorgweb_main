import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:selorgweb_main/apiservice/secure_storage/secure_storage.dart';
import 'package:selorgweb_main/model/addaddress/delete_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/get_saved_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/presentation/settings/address/address_event.dart';
import 'package:selorgweb_main/presentation/settings/address/address_state.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:http/http.dart' as http;

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitialState()) {
    on<GetSavedAddressEvent>(getSavedAddress);
    on<DeleteSavedAddressEvent>(deleteAddress);
    on<GetLocationUsingLatLongFromApiEvent>(getlocation);
    on<SearchLocationEvent>(seachLocation);
    on<ContinueLocationEvent>(locationContinue);
  }

  getSavedAddress(
    GetSavedAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());
    try {
      String url = "$getAddressUrl${event.userId}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url) , headers: {
        "Authorization":"Bearer ${await TokenService.getToken()}"
      });
      if (response.statusCode == 200) {
        var getSavedAddressResponse = getSavedAddressResponseFromJson(
          response.body,
        );
        emit(
          AddressSuccessState(getSavedAddressResponse: getSavedAddressResponse),
        );
      } else if (response.statusCode == 404) {
        debugPrint("hello from 404");
        var getSavedAddressResponse = getSavedAddressResponseFromJson(
          response.body,
        );
        debugPrint(getSavedAddressResponse.toString());
        emit(
          AddressSuccessState(getSavedAddressResponse: getSavedAddressResponse),
        );
      } else {
        emit(AddressErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(AddressErrorState(errorMsg: e.toString()));
    }
  }

  deleteAddress(
    DeleteSavedAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());
    try {
      var headers = {'Content-Type': 'application/json'};

      String url = "$deleteAddressUrl${event.id}";

      var request = http.Request('DELETE', Uri.parse(url));
      request.body = json.encode({
        "label": event.label,
        "details": {
          "houseNo": event.houseNo,
          "building": event.building,
          "landmark": event.landMark,
          "area": event.area,
          "city": event.city,
          "state": event.state,
          "pincode": event.pinCode,
        },
        "coordinates": {
          "latitude": event.latitude,
          "longitude": event.longitude,
        },
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        var deleteAddressResponse = deleteAddressResponseFromJson(res);
        emit(
          AddressDeletedSuccessState(
            deleteAddressResponse: deleteAddressResponse,
          ),
        );
      } else {
        emit(AddressErrorState(errorMsg: response.reasonPhrase ?? ""));
      }
    } catch (e) {
      emit(AddressErrorState(errorMsg: e.toString()));
    }
  }

  getlocation(
    GetLocationUsingLatLongFromApiEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());
    Placemark? place;
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      debugPrint("Location services are disabled.");
      // return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // locationMessage = "Location permission denied.";
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        "Location permission permanently denied. Enable from settings.",
      );
      // locationMessage =
      //     "Location permission permanently denied. Enable from settings.";
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    // );
    // if (placemarks.isNotEmpty) {
    //   place = placemarks.first.subLocality;
    //   // debugPrint(
    //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
    // }
    String url =
        "$latlonggetAddressUrl${position.latitude},${position.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = latLongLocationResponseFromJson(response.body);
      String placeurl =
          "${baseUrl}mapLocation/location?placeId=${result.results?.first.placeId}";

      final placeResponse = await http.get(Uri.parse(placeurl));
      debugPrint("data:");
      debugPrint(placeResponse.body);
      final decoded = jsonDecode(placeResponse.body);

      String getComponent(String type) {
        return decoded['address_components']?.firstWhere(
              (comp) => (comp['types'] as List).contains(type),
              orElse: () => null,
            )?['long_name'] ??
            '';
      }

      place = Placemark(
        name: decoded['name'] ?? '',
        street: getComponent('route'),
        locality: getComponent('locality'),
        subLocality: getComponent('sublocality'),
        administrativeArea: getComponent('administrative_area_level_3'),
        subAdministrativeArea: getComponent('administrative_area_level_1'),
        postalCode: getComponent('postal_code'),
        country: getComponent('country'),
        thoroughfare: getComponent('thoroughfare'),
      );
      emit(
        LocationSuccessStateFromAPi(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          place: place,
        ),
      );

      debugPrint(
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
      );
    }
    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }

  seachLocation(SearchLocationEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    String url = seachLocationUrl + event.searchText;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        debugPrint(response.body);
        var searchedLocationResponse = searchedLocationResponseFromJson(
          response.body,
        );
        debugPrint(searchedLocationResponse[0].toString());
        emit(
          SearchedLocationSuccessState(
            searchedLocationResponse: searchedLocationResponse,
          ),
        );
      } else {
        if (event.searchText.isEmpty) {
        } else {
          emit(AddressErrorState(errorMsg: "Failed to fetch data"));
        }
      }
    } catch (e) {
      emit(AddressErrorState(errorMsg: e.toString()));
    }
  }

  locationContinue(
    ContinueLocationEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      debugPrint("Location services are disabled.");
      // return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // locationMessage = "Location permission denied.";
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        "Location permission permanently denied. Enable from settings.",
      );
      // locationMessage =
      //     "Location permission permanently denied. Enable from settings.";
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    // );
    // if (placemarks.isNotEmpty) {
    //   place =
    //       "${placemarks.first.subLocality ?? ''} - ${placemarks.first.locality ?? ''}";
    //   // debugPrint(
    //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
    // }
    emit(
      LocationContinueSuccessState(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        place: "place",
      ),
    );
    debugPrint(
      "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
    );
    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }
}
