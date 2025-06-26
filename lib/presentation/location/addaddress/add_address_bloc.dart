import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:selorgweb_main/model/addaddress/add_address_save_response_mode.dart';
import 'package:selorgweb_main/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_event.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_state.dart';
import 'package:selorgweb_main/apiservice/post_method.dart' as api;
import 'package:http/http.dart' as http;

import 'package:selorgweb_main/utils/constant.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(AddAddressInitialState()) {
    on<SaveAddressEvent>(saveAddress);
    on<SelectLabelEvent>(selectLabelFunction);
    on<UpdateAddressEvent>(updateAddress);
    on<SetLatLonLocationEvent>(saveMapData);
    on<GetLocationEvent>(getlocation);
  }

  saveMapData(SetLatLonLocationEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressLoadingState());
    debugPrint('google ${event.latitude}');
    emit(
      LocationSuccessState(
        latitude: event.latitude,
        longitude: event.longitude,
        place: event.place,
      ),
    );
  }

  selectLabelFunction(SelectLabelEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressLoadingState());
    emit(SelectedLabelState(label: event.label));
  }

  saveAddress(SaveAddressEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressLoadingState());
    try {
      String url = saveAddressUrl;
      api.Response res = await api.ApiService().postRequestSecure(
        url,
        jsonEncode({
          "userId": event.userId,
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
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var addAddressSaveResponse = addAddressSaveResponseFromJson(
          res.resBody,
        );
        emit(
          AddAddressSaveSuccess(addAddressSaveResponse: addAddressSaveResponse),
        );
      } else {
        var addAddressSaveResponse = addAddressSaveResponseFromJson(
          res.resBody,
        );
        emit(
          AddAddressErrorState(errorMsg: addAddressSaveResponse.message ?? ""),
        );
      }
    } catch (e) {
      emit(AddAddressErrorState(errorMsg: e.toString()));
    }
  }

  updateAddress(UpdateAddressEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressLoadingState());
    try {
      String url = "$updateAddressUrl/${event.id}";
      debugPrint(url);
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('PUT', Uri.parse(url));
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

      var res = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        var addAddressSaveResponse = addAddressSaveResponseFromJson(res);
        emit(
          AddAddressSaveSuccess(addAddressSaveResponse: addAddressSaveResponse),
        );
      } else {
        emit(AddAddressErrorState(errorMsg: response.reasonPhrase ?? ""));
      }
    } catch (e) {
      emit(AddAddressErrorState(errorMsg: e.toString()));
    }
  }

  getlocation(GetLocationEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressLoadingState());
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
        LocationSuccessState(
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
}
