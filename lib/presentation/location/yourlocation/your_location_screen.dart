import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_screen.dart';
import 'package:selorgweb_main/presentation/location/location_bloc.dart';
import 'package:selorgweb_main/presentation/location/location_state.dart';
import 'package:selorgweb_main/presentation/location/location_event.dart';
import '../../../utils/constant.dart';

// ignore: must_be_immutable
class YourLocationScreen extends StatelessWidget {
  final String screenType;
  final String? lat;
  final String? long;
  YourLocationScreen({
    super.key,
    this.lat,
    this.long,
    required this.screenType,
  });

  static String latitude = "";
  static String longitude = "";
  static Placemark place = Placemark();
  static bool iserrorLocation = false;
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    _markers.add(
      Marker(
        markerId: const MarkerId('selected-location'),
        position: LatLng(double.parse(lat!), double.parse(long!)),
        // infoWindow: InfoWindow(title: 'Initial Position'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(),
      child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationSuccessState) {
            debugPrint(state.place?.name);
            latitude = "";
            longitude = "";
            latitude = /* lat ??  */ state.latitude!;
            longitude = /* long ??  */ state.longitude!;
            place = state.place!;
            iserrorLocation = false;
          } else if (state is LocationContinueSuccessState) {
            if (state.screenType == 'dialog') {
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
                      screenType: screenType,
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
                      screenType: screenType,
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
                      screenType: screenType,
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
            if (screenType == "search") {
              latitude = lat ?? "";
              longitude = long ?? "";
            } else if (screenType == "dialog") {
              latitude = lat ?? "";
              longitude = long ?? "";
            } else if (screenType == "listview") {
              latitude = lat ?? "";
              longitude = long ?? "";
            } /* else if (screenType == "address") {
              latitude = lat ?? "";
              longitude = long ?? "";
            } */ else {
              // context.read<LocationBloc>().add(GetLocationEvent());
            }
          }
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            child: SizedBox(
              width: 500,
              height: 500,
              child: Stack(
                children: [
                  latitude == ""
                      ? SizedBox()
                      : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(lat!),
                            double.parse(long!),
                          ),
                          zoom: 14.0,
                        ),
                        onMapCreated: _onMapCreated,
                        onCameraIdle: () {
                          context.read<LocationBloc>().add(
                            GetLatLonOnIdleEvent(
                              latitude: latitude,
                              longitude: longitude,
                            ),
                          );
                        },
                        onCameraMove: (CameraPosition position) {
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
                                color: appColor,
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
                                                        if (screenType ==
                                                                "search" ||
                                                            screenType ==
                                                                "address") {
                                                          context
                                                              .read<
                                                                LocationBloc
                                                              >()
                                                              .add(
                                                                LatLonLocationEvent(
                                                                  latitude:
                                                                      latitude,
                                                                  longitude:
                                                                      longitude,
                                                                  screenType:
                                                                      screenType,
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
                                                                      screenType,
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
                                                  color: appColor,
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
    var paint = Paint()..color = appColor;

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
