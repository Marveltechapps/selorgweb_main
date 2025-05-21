import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:selorgweb_main/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/lat_long_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/presentation/location/location_event.dart';
import 'package:selorgweb_main/presentation/location/location_state.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/model/location/myplacemark.dart' as p;

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitialState()) {
    on<GetLocationEvent>(getlocation);
    on<ContinueLocationEvent>(locationContinue);
    on<GetLatLonEvent>(getLatLonFunction);
    on<GetLatLonOnIdleEvent>(loc);
    on<SearchLocationEvent>(seachLocation);
    on<GetLatLonOnListEvent>(getlatlon);
    on<LatLonLocationEvent>(latlonloction);
    on<GetLocationUsingLatLongFromApiEvent>(getlatlongfromapi);
  }

  getlatlon(GetLatLonOnListEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoadingState());
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
        emit(LocationErrorState(error: "Failed to fetch data"));
      }
    } catch (e) {
      emit(LocationErrorState(error: e.toString()));
    }
  }
  // getlatlon(GetLatLonOnListEvent event, Emitter<LocationState> emit) async {

  seachLocation(SearchLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoadingState());
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
          emit(LocationErrorState(error: "Failed to fetch data"));
        }
      }
    } catch (e) {
      emit(LocationErrorState(error: e.toString()));
    }
  }

  getLatLonFunction(GetLatLonEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoadingState());
    emit(
      GetLatLonSuccessState(
        latitude: event.latitude,
        longitude: event.longitude,
      ),
    );
  }

  bool looksLikeWater(Placemark placemark) {
    // If locality and administrativeArea are missing, it's suspicious
    if ((placemark.locality == null || placemark.locality!.isEmpty) &&
        (placemark.administrativeArea == null ||
            placemark.administrativeArea!.isEmpty)) {
      return true;
    }

    // Keywords (fallback for odd returns)
    final combined =
        '${placemark.name} ${placemark.thoroughfare} ${placemark.subLocality} ${placemark.name}'
            .toLowerCase();
    const waterKeywords = ['ocean', 'lake', 'sea', 'bay', 'harbor', 'water'];

    return waterKeywords.any((kw) => combined.contains(kw));
  }

  loc(GetLatLonOnIdleEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoadingState());
    // bool serviceEnabled;
    // LocationPermission permission;
    Placemark? place;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // permission = await Geolocator.checkPermission();
    // if (!serviceEnabled) {
    //   permission = await Geolocator.requestPermission();
    //   debugPrint("Location services are disabled.");
    //   // return;
    // }
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // locationMessage = "Location permission denied.";
    //     debugPrint("Location permission denied.");
    //     return;
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   debugPrint(
    //       "Location permission permanently denied. Enable from settings.");
    //   // locationMessage =
    //   //     "Location permission permanently denied. Enable from settings.";
    //   return;
    // }

    // Get current location
    // Position position = await Geolocator.getCurrentPosition(
    //   locationSettings: AndroidSettings(accuracy: LocationAccuracy.best),
    // );
    debugPrint("Coordinates");
    debugPrint(event.latitude);
    debugPrint(event.longitude);
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //   double.parse(event.latitude),
    //   double.parse(event.longitude),
    // );
    // debugPrint("Coordinates2");

    // if (placemarks.isNotEmpty) {
    //   place = placemarks.first;
    //   // debugPrint(
    //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
    // }
    String url =
        "$latlonggetAddressUrl${event.latitude},${event.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
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
      debugPrint(place.postalCode);
      if (place.name!.isEmpty ||
          looksLikeWater(place) ||
          place.postalCode!.isEmpty) {
        emit(
          LocationErrorState(
            error: "Location not found. Please try again later.",
          ),
        );
      } else {
        emit(
          LocationSuccessState(
            latitude: event.latitude.toString(),
            longitude: event.longitude.toString(),
            place: place,
          ),
        );
      }
      debugPrint("Latitude: ${event.latitude}, Longitude: ${event.longitude}");
    } else {
      emit(
        LocationErrorState(
          error: "Location not found. Please try again later.",
        ),
      );
    }
  }

  getlocation(GetLocationEvent event, Emitter<LocationState> emit) async {
    try {
      emit(LocationLoadingState());
      bool serviceEnabled;
      LocationPermission permission;
      Placemark? place;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      permission = await Geolocator.checkPermission();
      if (!serviceEnabled) {
        permission = await Geolocator.requestPermission();
        debugPrint("Location services are disabled.");
        // return;
      }
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
      debugPrint('works current position');
      debugPrint(position.latitude.toString() + position.longitude.toString());
      String url =
          "$latlonggetAddressUrl${position.latitude},${position.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = latLongLocationResponseFromJson(response.body);
        String placeurl =
            "${baseUrl}mapLocation/location?placeId=${result.results?.first.placeId}";

        final placeResponse = await http.get(Uri.parse(placeurl));
        // debugPrint("data:");
        // debugPrint(placeResponse.body);
        final decoded = jsonDecode(placeResponse.body);

        String getComponent(String type) {
          return decoded['address_components']?.firstWhere(
                (comp) => (comp['types'] as List).contains(type),
                orElse: () => null,
              )?['long_name'] ??
              '';
        }

        emit(
          LocationSuccessState(
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            place: Placemark(
              name: decoded['name'] ?? '',
              street: getComponent('route'),
              locality: getComponent('locality'),
              subLocality: getComponent('sublocality'),
              administrativeArea: getComponent('administrative_area_level_3'),
              subAdministrativeArea: getComponent(
                'administrative_area_level_1',
              ),
              postalCode: getComponent('postal_code'),
              country: getComponent('country'),
            ),
          ),
        );
      } else {
        emit(LocationErrorState(error: "Failed to fetch data"));
      }
      debugPrint(
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }

  getlatlongfromapi(
    GetLocationUsingLatLongFromApiEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoadingState());
    String url =
        "$latlonggetAddressUrl${event.latitude},${event.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = latLongLocationResponseFromJson(response.body);
        String placeurl =
            "${baseUrl}mapLocation/location?placeId=${result.results?.first.placeId}";

        final placeResponse = await http.get(Uri.parse(placeurl));
        // debugPrint("data:");
        // debugPrint(placeResponse.body);
        final decoded = jsonDecode(placeResponse.body);

        String getComponent(String type) {
          return decoded['address_components']?.firstWhere(
                (comp) => (comp['types'] as List).contains(type),
                orElse: () => null,
              )?['long_name'] ??
              '';
        }

        emit(
          LocationSuccessState(
            latitude: event.latitude.toString(),
            longitude: event.longitude.toString(),
            // place:
            //     p.Placemark.fromGooglePlace(result.results!.first.toJson())
            //         as Placemark,
            place: Placemark(
              name: decoded['name'] ?? '',
              street: getComponent('route'),
              locality: getComponent('locality'),
              subLocality: getComponent('sublocality'),
              administrativeArea: getComponent('administrative_area_level_3'),
              subAdministrativeArea: getComponent(
                'administrative_area_level_1',
              ),
              postalCode: getComponent('postal_code'),
              country: getComponent('country'),
            ),
          ),
        );
      } else {
        emit(LocationErrorState(error: "Failed to fetch data"));
      }
    } catch (e) {
      emit(LocationErrorState(error: e.toString()));
    }
  }

  latlonloction(LatLonLocationEvent event, Emitter<LocationState> emit) {
    emit(LocationLoadingState());
    emit(
      LocationContinueSuccessState(
        screenType: event.screenType,
        latitude: event.latitude,
        longitude: event.longitude,
        place: event.place,
        placemark: Placemark(),
      ),
    );
  }

  locationContinue(
    ContinueLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    String? place;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      permission = await Geolocator.requestPermission();
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
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.best),
    );
    String url =
        "$latlonggetAddressUrl${event.latitude},${event.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = latLongLocationResponseFromJson(response.body);
      String placeurl =
          "${baseUrl}mapLocation/location?placeId=${result.results?.first.placeId}";

      final placeResponse = await http.get(Uri.parse(placeurl));
      // debugPrint("data:");
      // debugPrint(placeResponse.body);
      final decoded = jsonDecode(placeResponse.body);

      String getComponent(String type) {
        return decoded['address_components']?.firstWhere(
              (comp) => (comp['types'] as List).contains(type),
              orElse: () => null,
            )?['long_name'] ??
            '';
      }

      place = "${getComponent('sublocality')} - ${getComponent('locality')}";
      // debugPrint(
      //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");

      emit(
        LocationContinueSuccessState(
          screenType: event.screenType,
          latitude: event.latitude.toString(),
          longitude: event.longitude.toString(),
          place: place,
          placemark: Placemark(
            name: decoded['name'] ?? '',
            street: getComponent('route'),
            locality: getComponent('locality'),
            subLocality: getComponent('sublocality'),
            administrativeArea: getComponent('administrative_area_level_3'),
            subAdministrativeArea: getComponent('administrative_area_level_1'),
            postalCode: getComponent('postal_code'),
            country: getComponent('country'),
          ),
        ),
      );
    }
    debugPrint(
      "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
    );
    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }
}
