

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/lat_long_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/presentation/address/address_state.dart';
import 'package:selorgweb_main/presentation/address/adress_event.dart';
import 'package:selorgweb_main/utils/constant.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState>{
  AddressBloc():super(AddressInitialState()){
    on<GetLocationEvent>(getlocation);
    on<GetLocationUsingLatLongFromApiEvent>(getlatlongfromapi);
    on<SearchLocationEvent>(seachLocation);
    on<GetLatLonOnListEvent>(getlatlon);
    on<PlaceLocaitonEvent>(placelocatiovalue);
    on<ContinueLocationEvent>(locationContinue);
    on<UpdateLocationEvent>(updateLocation);
  }

  
  placelocatiovalue(PlaceLocaitonEvent event, Emitter<AddressState> emit) {
    emit(AddressLoadingState());
    emit(PlaceLocaitonState(locationText: event.locationText));
  }


 
  updateLocation(UpdateLocationEvent event, Emitter<AddressState> emit) {
    emit(AddressLoadingState());
    emit(UpdateLocationState(location: event.location));
  }


 

  // onTap(GetScreenEvent event, Emitter<AddressState> emit) {
  //   emit(AddressLoadingState());
  //   emit(NavigateState(index: event.index));
  // }

  getlatlon(GetLatLonOnListEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    String url =
        "$getLatLonUrl${event.placeId}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var latlongLocationResponse = latLonLocationResponseFromJson(
          response.body,
        );
        emit(
          LatLongSuccessState(
            longitude:
                latlongLocationResponse.result!.geometry!.location!.lng
                    .toString(),
            latitude:
                latlongLocationResponse.result!.geometry!.location!.lat
                    .toString(),
          ),
        );
      } else {
        emit(AddressErrorState(message: "Failed to fetch data"));
      }
    } catch (e) {
      emit(AddressErrorState(message: e.toString()));
    }
  }

  getlocation(GetLocationEvent event, Emitter<AddressState> emit) async {
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
    //   place = placemarks.first.subLocality;
    //   // debugPrint(
    //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
    // }
    emit(
      LocationSuccessState(
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

  getlatlongfromapi(
    GetLocationUsingLatLongFromApiEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());
    String url =
        "$latlonggetAddressUrl${event.latitude},${event.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = latLongLocationResponseFromJson(response.body);
        emit(LatLongAddressSuccessState(latLongLocationResponse: result));
      } else {
        emit(AddressErrorState(message: "Failed to fetch data"));
      }
    } catch (e) {
      emit(AddressErrorState(message: e.toString()));
    }
  }

  seachLocation(SearchLocationEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());
    String url = seachLocationUrl + event.searchText;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var searchedLocationResponse = searchedLocationResponseFromJson(
          response.body,
        );
        emit(
          SearchedLocationSuccessState(
            searchedLocationResponse: searchedLocationResponse,
          ),
        );
      } else {
        if (event.searchText.isEmpty) {
        } else {
          emit(AddressErrorState(message: "Failed to fetch data"));
        }
      }
    } catch (e) {
      emit(AddressErrorState(message: e.toString()));
    }
  }

  //
  locationContinue(ContinueLocationEvent event, Emitter<AddressState> emit) async {
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

