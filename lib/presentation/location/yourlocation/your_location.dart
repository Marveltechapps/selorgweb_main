import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selorgweb_main/model/location/myplacemark.dart' as p;
import 'package:selorgweb_main/presentation/location/addaddress/add_address_screen.dart';
import 'package:selorgweb_main/presentation/location/location_bloc.dart';
import 'package:selorgweb_main/presentation/location/location_event.dart';
import 'package:selorgweb_main/presentation/location/location_state.dart';
import 'package:selorgweb_main/utils/constant.dart';

class YourLocation extends StatefulWidget {
  const YourLocation({
    super.key,
    this.lat,
    this.long,
    required this.screenType,
  });
  final String screenType;
  final String? lat;
  final String? long;

  @override
  State<YourLocation> createState() => _YourLocationState();
}

class _YourLocationState extends State<YourLocation> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(12.9715987, 77.5945627);
  LatLng _currentPosition = const LatLng(12.9715987, 77.5945627);
  LatLng? _selectedPosition;
  Set<Marker> _markers = {};
  static String latitude = "";
  static String longitude = "";
  static Placemark place = Placemark();
  static bool iserrorLocation = false;
  void _onCameraMove(CameraPosition position) {
    setState(() {
      _currentPosition = position.target;
    });
  }

  void _onCameraIdle() {
    _updateMarker(_currentPosition);
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('selected-location'),
          position: _initialPosition,
          // infoWindow: InfoWindow(title: 'Initial Position'),
        ),
      };
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('selected-location'),
          position: _initialPosition,
          // infoWindow: InfoWindow(title: 'Initial Position'),
        ),
      );
    });
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
      _markers = {
        Marker(
          markerId: const MarkerId('selected-location'),
          position: position,
          // infoWindow: InfoWindow(title: 'Selected Position'),
        ),
      };
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.lat);
    debugPrint(widget.long);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(),
      child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationSuccessState) {
            latitude = "";
            longitude = "";
            latitude = /* lat ??  */ state.latitude!;
            longitude = /* long ??  */ state.longitude!;
            place = state.place!;
            iserrorLocation = false;
          } else if (state is LatLongAddressSuccessState) {
            debugPrint("hi");
            location =
                "${state.latLongLocationResponse.results![0].addressComponents![1].shortName} - ${state.latLongLocationResponse.results![0].addressComponents![3].shortName}";
            debugPrint(location);
            // place = state;
            debugPrint(
              state.latLongLocationResponse.results?.first.addressComponents
                  .toString(),
            );
            debugPrint(state.latLongLocationResponse.results?.first.placeId);

            // place =
            //     p.Placemark.fromGooglePlace(
            //           state.latLongLocationResponse.results?.first
            //               as Map<String, dynamic>,
            //         )
            //         as Placemark;
            debugPrint("works");
            debugPrint(place.name);
          } else if (state is LocationContinueSuccessState) {
            debugPrint(state.toString());
            if (state.screenType == 'editaddress') {
              var location = {
                'latitude': state.latitude,
                'longitude': state.longitude,
                'place': {
                  'name': state.place,
                  'street': state.placemark.street,
                  'locality': state.placemark.locality,
                  'subLocality': state.placemark.subLocality,
                  'administrativeArea': state.placemark.administrativeArea,
                  'subAdministrativeArea':
                      state.placemark.subAdministrativeArea,
                  'postalCode': state.placemark.postalCode,
                  'country': state.placemark.country,
                },
              };
              debugPrint("getted location pinned");
              debugPrint(location.toString());
              Navigator.pop(context, jsonEncode(location));
            } else if (state.screenType == 'dialog') {
              location = state.place ?? "";
              Navigator.pop(context);
              Navigator.pop(context, location);
            } else if (state.screenType == 'screen') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddAddress(
                      latitude: state.latitude.toString(),
                      isEdit: false,
                      longitude: state.longitude.toString(),
                      place: place,
                      screenType: widget.screenType,
                    );
                  },
                ),
              );
            } else if (state.screenType == 'address') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddAddress(
                      isEdit: false,
                      latitude: state.latitude.toString(),
                      longitude: state.longitude.toString(),
                      place: place,
                      screenType: widget.screenType,
                    );
                  },
                ),
              );
            } else if (state.screenType == 'listview') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddAddress(
                      isEdit: false,
                      latitude: state.latitude.toString(),
                      longitude: state.longitude.toString(),
                      place: place,
                      screenType: widget.screenType,
                    );
                  },
                ),
              );
            } else if (state.screenType == 'current') {
              location = state.place ?? "";
              Navigator.pop(context);
              Navigator.pop(context, location);
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return AddAddress(
              //         isEdit: false,
              //         latitude: state.latitude.toString(),
              //         longitude: state.longitude.toString(),
              //         place: place,
              //         screenType: screenType);
              //   },
              // ));
            } else if (state.screenType == 'search') {
              location = state.place ?? "";
              Navigator.pop(context);
              Navigator.pop(context, location);
            }
            iserrorLocation = false;
          } else if (state is GetLatLonSuccessState) {
            latitude = "";
            longitude = "";
            latitude = /*  lat ??  */ state.latitude;
            longitude = /* long ??  */ state.longitude;
            iserrorLocation = false;
            debugPrint("$latitude $longitude");
          } else if (state is LocationErrorState) {
            iserrorLocation = true;
            place = Placemark();
            // Handle error state
            debugPrint("Error: ${state.error}");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.error),
            //     backgroundColor: Colors.red,
            //   ),
            // );
          }
        },
        builder: (context, state) {
          if (state is LocationInitialState) {
            locationInitiatted = "done";
            latitude = "";
            longitude = "";
            iserrorLocation = false;
            if (widget.screenType == "search") {
              latitude = widget.lat ?? "";
              longitude = widget.long ?? "";
            } else if (widget.screenType == "dialog") {
              latitude = widget.lat ?? "";
              longitude = widget.long ?? "";
            } else if (widget.screenType == "listview") {
              latitude = widget.lat ?? "";
              longitude = widget.long ?? "";
            } /* else if (widget.screenType == "address") {
              latitude = widget.lat ?? "";
              longitude = widget.long ?? "";
            } */ else {
              debugPrint("getLocation event");
              // context.read<LocationBloc>().add(GetLocationEvent());
              context.read<LocationBloc>().add(
                GetLocationUsingLatLongFromApiEvent(
                  latitude: widget.lat!,
                  longitude: widget.long!,
                ),
              );
            }
          }
          return Dialog(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        double.parse(widget.lat!),
                        double.parse(widget.long!),
                      ),
                      zoom: 20,
                    ),
                    // markers: _markers,
                    // onTap: _onMapTapped,
                    onCameraIdle: () {
                      context.read<LocationBloc>().add(
                        GetLatLonOnIdleEvent(
                          latitude: latitude,
                          longitude: longitude,
                        ),
                      );
                    },
                    onCameraMove: (CameraPosition position) {
                      debugPrint(position.toString());
                      context.read<LocationBloc>().add(
                        GetLatLonEvent(
                          latitude: position.target.latitude.toString(),
                          longitude: position.target.longitude.toString(),
                        ),
                      );
                    },
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Order will be Delivered here",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Place the Pin to your exact Location",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomPaint(
                              size: Size(20, 15),
                              painter: TrianglePainter(),
                            ),
                            Icon(
                              Icons.location_on,
                              size: 50,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: IntrinsicHeight(
                          child: Container(
                            // height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children:
                                    place.name == null && !iserrorLocation
                                        ? [
                                          CircularProgressIndicator(
                                            color: appColor,
                                          ),
                                        ]
                                        : [
                                          if (!iserrorLocation)
                                            Row(
                                              children: [
                                                place.subLocality == ""
                                                    ? SizedBox()
                                                    : Text(
                                                      place.subLocality
                                                          .toString(),
                                                      style: TextStyle(
                                                        //  fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                              ],
                                            ),
                                          SizedBox(height: 8),

                                          if (iserrorLocation)
                                            Text(
                                              "We are not serviceable at this location. Please try a different location",
                                              style: TextStyle(color: redColor),
                                            ),
                                          if (!iserrorLocation)
                                            Text(
                                              "${place.name}${place.name == "" ? "" : ","}${place.subLocality}${place.subLocality == "" ? "" : ","} ${place.locality}${place.locality == "" ? "" : ","} ${place.administrativeArea}${place.administrativeArea == "" ? "" : ","} ${place.postalCode}${place.postalCode == "" ? "" : ","} ${place.country}",
                                              //"${place.name} ,${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          SizedBox(height: 8),
                                          if (!iserrorLocation)
                                            GestureDetector(
                                              onTap:
                                                  state is LocationLoadingState
                                                      ? null
                                                      : () {
                                                        debugPrint(latitude);
                                                        debugPrint(longitude);
                                                        if (widget.screenType ==
                                                                "search" ||
                                                            widget.screenType ==
                                                                "address") {
                                                          context.read<LocationBloc>().add(
                                                            LatLonLocationEvent(
                                                              latitude:
                                                                  latitude,
                                                              longitude:
                                                                  longitude,
                                                              screenType:
                                                                  widget
                                                                      .screenType,
                                                              place:
                                                                  "${place.subLocality.toString()}, ${place.locality}",
                                                            ),
                                                          );
                                                        } else {
                                                          context
                                                              .read<
                                                                LocationBloc
                                                              >()
                                                              .add(
                                                                ContinueLocationEvent(
                                                                  screenType:
                                                                      widget
                                                                          .screenType,
                                                                  latitude:
                                                                      latitude,
                                                                  longitude:
                                                                      longitude,
                                                                ),
                                                              );
                                                        }
                                                      },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  left: 30,
                                                  right: 30,
                                                  top: 10,
                                                  bottom: 10,
                                                ),
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                    3,
                                                    71,
                                                    3,
                                                    1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width,
                                                child: Center(
                                                  child:
                                                      state is LocationLoadingState
                                                          ? CircularProgressIndicator(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  5,
                                                                ),
                                                            color: Colors.white,
                                                          )
                                                          : Text(
                                                            "Confirm & Continue",
                                                            style: TextStyle(
                                                              //  fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                ),
                                              ),
                                            ),
                                        ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.green;

    var path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
