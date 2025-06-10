import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_bloc.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_event.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_state.dart';
import 'package:selorgweb_main/presentation/location/yourlocation/your_location.dart';
import 'package:selorgweb_main/utils/widgets/success_dialog_widget.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/utils/widgets/add_address_styles.dart';

// ignore: must_be_immutable
class AddAddress extends StatelessWidget {
  final Placemark place;
  final String screenType;
  final String latitude;
  final String longitude;
  String? id;
  final bool isEdit;
  String? houseNo;
  String? building;
  String? landmark;
  String? label;

  AddAddress({
    super.key,
    required this.place,
    required this.screenType,
    required this.latitude,
    this.id,
    required this.isEdit,
    this.houseNo,
    this.building,
    this.landmark,
    this.label,
    required this.longitude,
  });

  static String selectedLabel = '';
  static TextEditingController houseNoController = TextEditingController();
  static TextEditingController buildingController = TextEditingController();
  static TextEditingController landmarkController = TextEditingController();
  static String lat = "";
  static String long = "";
  static Placemark placemark = Placemark();
  final _formKey = GlobalKey<FormState>();
  Set<Marker> markers = {};
  void showLocationSelect(BuildContext context) {
    showDialog(
      context: context,
      // barrierDismissible: !(location == "No Location Found"),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 500,
              maxWidth: 500,
              minHeight: 500,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,

                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: appColor,
                        child: Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  // LocationScreen(screenType: 'address'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAddressBloc(),
      child: BlocConsumer<AddAddressBloc, AddAddressState>(
        listener: (context, state) {
          if (state is AddAddressSaveSuccess) {
            showSuccessDialog(
              true,
              state.addAddressSaveResponse.message ?? "",
              "${place.name} ,${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}",
              selectedLabel,
              screenType,
              context,
            );
            houseNoController.clear();
            buildingController.clear();
            landmarkController.clear();
          } else if (state is SelectedLabelState) {
            selectedLabel = state.label;
          } else if (state is LocationSuccessState) {
            debugPrint('latitude works');
            debugPrint(state.latitude);

            _mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(
                  double.parse(state.latitude!),
                  double.parse(state.longitude!),
                ),
              ),
            );

            lat = state.latitude!;
            long = state.longitude!;
            placemark = state.place!;
            markers = {
              Marker(
                markerId: MarkerId('unique_id'),
                position: LatLng(double.parse(lat), double.parse(long)),
                infoWindow: InfoWindow(
                  title: 'Place Your Location',
                  snippet: 'Some info here',
                ),
              ),
            };

            debugPrint('latitude ends');
          }
        },
        builder: (context, state) {
          if (state is AddAddressInitialState) {
            placemark = place;
            // lat = "";
            // long = "";
            selectedLabel = label ?? "";
            houseNoController.text = houseNo ?? "";
            buildingController.text = building ?? "";
            landmarkController.text = landmark ?? "";
            debugPrint(latitude.toString());
            lat = latitude;
            long = longitude;
            markers.add(
              Marker(
                markerId: MarkerId('unique_id'),
                position: LatLng(double.parse(lat), double.parse(long)),
                infoWindow: InfoWindow(
                  title: 'Place Your Location',
                  snippet: 'Some info here',
                ),
              ),
            );
          }
          debugPrint('lat and long $lat ');
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AddAddressStyles.maxWidth,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AddAddressStyles.defaultPadding,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 323,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GoogleMap(
                              onTap: (argument) async {
                                debugPrint(screenType);
                                if (screenType == "editaddress") {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return YourLocationScreen(
                                  //         lat: lat,
                                  //         long: long,
                                  //         screenType: screenType,
                                  //       );
                                  //     },
                                  //   ),
                                  // );
                                  var editeddate = await showDialog(
                                    context: context,
                                    builder:
                                        (context) => YourLocation(
                                          lat: latitude,
                                          long: longitude,
                                          screenType: screenType,
                                        ),
                                  );
                                  if (editeddate != null) {
                                    debugPrint(editeddate);
                                    final format = jsonDecode(editeddate);
                                    final decoded = Map<String, dynamic>.from(
                                      format,
                                    );
                                    debugPrint(decoded.toString());
                                    debugPrint(decoded['latitude'].toString());

                                    try {
                                      final placemark1 = Placemark(
                                        name: decoded['place']['name'] ?? '',
                                        street:
                                            decoded['place']['street'] ?? '',
                                        locality:
                                            decoded['place']['locality'] ?? '',
                                        subLocality:
                                            decoded['place']['subLocality'] ??
                                            '',
                                        administrativeArea:
                                            decoded['place']['administrativeArea'] ??
                                            '',
                                        subAdministrativeArea:
                                            decoded['place']['subAdministrativeArea'] ??
                                            '',
                                        postalCode:
                                            decoded['place']['postalCode'] ??
                                            '',
                                        country:
                                            decoded['place']['country'] ?? '',
                                      );
                                      debugPrint(
                                        '${decoded['latitude'].toString()}-jik ${decoded['longitude'].toString()}',
                                      );
                                      // ignore: use_build_context_synchronously
                                      context.read<AddAddressBloc>().add(
                                        SetLatLonLocationEvent(
                                          latitude:
                                              decoded['latitude'].toString(),
                                          longitude:
                                              decoded['longitude'].toString(),
                                          place: placemark1,
                                        ),
                                      );
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                  }
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  double.parse(lat),
                                  double.parse(long),
                                ),
                                zoom: 20.0,
                              ),
                              onMapCreated: (controller) {
                                _mapController = controller;
                              },
                              markers: markers,
                              // onCameraIdle: () {
                              //   context.read<LocationBloc>().add(GetLatLonOnIdleEvent(
                              //       latitude: latitude, longitude: longitude));
                              // },
                              // onCameraMove: (CameraPosition position) {
                              //   context.read<LocationBloc>().add(GetLatLonEvent(
                              //       latitude: position.target.latitude.toString(),
                              //       longitude: position.target.longitude.toString()));
                              // },
                            ) /*   ImageNetwork(url:
          "https://cdn.builder.io/api/v1/image/assets/TEMP/08c56c190f2fda8733801f3fb8dd6154df55c0368b56a26bb54f2a751577ff14?placeholderIfAbsent=true&apiKey=479ee9553c984302af0d67c8f0a948e9",
          fit: BoxFit.cover,
          width: double.infinity,
        ), */,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  placemark.subLocality == ""
                                      ? SizedBox()
                                      : Text(
                                        placemark.subLocality ?? "",
                                        style:
                                            AddAddressStyles.locationTitleStyle,
                                      ),
                                  Text(
                                    "${placemark.name}${placemark.name == "" ? "" : ","}${placemark.subLocality}${placemark.subLocality == "" ? "" : ","} ${placemark.locality}${placemark.locality == "" ? "" : ","} ${placemark.administrativeArea}${placemark.administrativeArea == "" ? "" : ","} ${placemark.postalCode}${placemark.postalCode == "" ? "" : ","} ${placemark.country}",
                                    style:
                                        AddAddressStyles.locationSubtitleStyle,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 49),
                            OutlinedButton(
                              onPressed: () async {
                                debugPrint(screenType);
                                if (screenType == "editaddress") {
                                  // Navigator.pop(context);
                                  // showDialog(
                                  //   context: context,
                                  //   // barrierDismissible: !(location == "No Location Found"),
                                  //   builder: (BuildContext context) {
                                  //     return Container(
                                  //       width: 500,
                                  //       constraints: BoxConstraints(
                                  //         maxHeight: 500,
                                  //         maxWidth: 500,
                                  //         minHeight: 500,
                                  //       ),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //           horizontal: 20,
                                  //           vertical: 8,
                                  //         ),
                                  //         child: Column(
                                  //           spacing: 10,
                                  //           mainAxisSize: MainAxisSize.min,

                                  //           children: [
                                  //             Align(
                                  //               alignment: Alignment.topRight,
                                  //               child: InkWell(
                                  //                 onTap:
                                  //                     () => Navigator.pop(
                                  //                       context,
                                  //                     ),
                                  //                 child: CircleAvatar(
                                  //                   radius: 14,
                                  //                   backgroundColor: appColor,
                                  //                   child: Icon(
                                  //                     Icons.close,
                                  //                     size: 16,
                                  //                     color: Colors.white,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),

                                  //             Container(
                                  //               width: 300,
                                  //               height: 300,
                                  //               clipBehavior: Clip.hardEdge,
                                  //               decoration: BoxDecoration(),
                                  //               child: YourLocationScreen(
                                  //                 lat: latitude,
                                  //                 long: longitude,
                                  //                 screenType: screenType,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // );

                                  var editeddate = await showDialog(
                                    context: context,
                                    builder:
                                        (context) => YourLocation(
                                          lat: lat,
                                          long: long,
                                          screenType: screenType,
                                        ),
                                  );
                                  if (editeddate != null) {
                                    debugPrint(editeddate);
                                    final format = jsonDecode(editeddate);
                                    final decoded = Map<String, dynamic>.from(
                                      format,
                                    );
                                    debugPrint(decoded.toString());
                                    debugPrint(decoded['latitude'].toString());

                                    try {
                                      final placemark1 = Placemark(
                                        name: decoded['place']['name'] ?? '',
                                        street:
                                            decoded['place']['street'] ?? '',
                                        locality:
                                            decoded['place']['locality'] ?? '',
                                        subLocality:
                                            decoded['place']['subLocality'] ??
                                            '',
                                        administrativeArea:
                                            decoded['place']['administrativeArea'] ??
                                            '',
                                        subAdministrativeArea:
                                            decoded['place']['subAdministrativeArea'] ??
                                            '',
                                        postalCode:
                                            decoded['place']['postalCode'] ??
                                            '',
                                        country:
                                            decoded['place']['country'] ?? '',
                                      );
                                      debugPrint(
                                        '${decoded['latitude'].toString()}-jik ${decoded['longitude'].toString()}',
                                      );
                                      // ignore: use_build_context_synchronously
                                      context.read<AddAddressBloc>().add(
                                        SetLatLonLocationEvent(
                                          latitude:
                                              decoded['latitude'].toString(),
                                          longitude:
                                              decoded['longitude'].toString(),
                                          place: placemark1,
                                        ),
                                      );
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                  }

                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => YourLocationScreen(
                                  //       lat: latitude,
                                  //       long: longitude,
                                  //       screenType: screenType,
                                  //     )

                                  // );

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return YourLocationScreen(
                                  //         lat: latitude,
                                  //         long: longitude,
                                  //         screenType: screenType,
                                  //       );
                                  //     },
                                  //   ),
                                  // );
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AddAddressStyles.primaryGreen,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Change',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        _buildAddressForm(
                          context.read<AddAddressBloc>(),
                          context,
                        ),
                      ],
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



  Widget _buildAddressForm(AddAddressBloc addAddressBloc, context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField('House No. & Floor', houseNoController, context),
          const SizedBox(height: 8),
          _buildInputField('Building & Block No.', buildingController, context),
          const SizedBox(height: 8),
          _buildInputField(
            'Landmark & Area name(Optional)',
            landmarkController,
            context,
          ),
          const SizedBox(height: 25),
          _buildAddressLabels(addAddressBloc),
          const SizedBox(height: 25),
          _buildSaveButton(addAddressBloc, context),
          const SizedBox(height: 43),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AddAddressStyles.labelStyle),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          cursorColor: appColor,
          decoration: InputDecoration(
            hintText: 'Enter Details',
            hintStyle: AddAddressStyles.inputStyle,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greyColor), // Default border
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColor), // Border when focused
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColor), // Border when error
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: appColor,
              ), // Border when focused & error
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildAddressLabels(AddAddressBloc addAddressBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Address Label',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AddAddressStyles.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildLabelButton('Home', addAddressBloc),
              const SizedBox(width: 20),
              _buildLabelButton('Work', addAddressBloc),
              const SizedBox(width: 20),
              _buildLabelButton('Other', addAddressBloc),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabelButton(String label, AddAddressBloc addAddressBloc) {
    final isSelected = selectedLabel == label;
    return SizedBox(
      height: 35,
      width: 100,
      child: OutlinedButton(
        onPressed: () {
          addAddressBloc.add(SelectLabelEvent(label: label));
        },
        style: AddAddressStyles.addressLabelButtonStyle.copyWith(
          backgroundColor:
              isSelected
                  ? WidgetStateProperty.all(Colors.green.shade200)
                  : WidgetStateProperty.all(Colors.transparent),
          foregroundColor:
              isSelected
                  ? WidgetStateProperty.all(Colors.white)
                  : WidgetStateProperty.all(AddAddressStyles.borderColor),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildSaveButton(AddAddressBloc addAddressBloc, context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (houseNoController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Enter House No. & Floor")),
            );
          } else if (selectedLabel == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please select Address Label")),
            );
          } else {
            isEdit
                ? addAddressBloc.add(
                  UpdateAddressEvent(
                    id: id ?? "",
                    userId: userId,
                    label: selectedLabel,
                    houseNo: houseNoController.text,
                    building: buildingController.text,
                    landMark: landmarkController.text,
                    area:
                        placemark.subLocality == ""
                            ? placemark.name.toString()
                            : placemark.subLocality.toString(),
                    city: placemark.locality.toString(),
                    state: placemark.administrativeArea.toString(),
                    pinCode: placemark.postalCode.toString(),
                    latitude: lat,
                    longitude: long,
                  ),
                )
                : addAddressBloc.add(
                  SaveAddressEvent(
                    userId: userId,
                    label: selectedLabel,
                    houseNo: houseNoController.text,
                    building: buildingController.text,
                    landMark: landmarkController.text,
                    area:
                        placemark.subLocality == ""
                            ? placemark.name.toString()
                            : placemark.subLocality.toString(),
                    city: placemark.locality.toString(),
                    state: placemark.administrativeArea.toString(),
                    pinCode: placemark.postalCode.toString(),
                    latitude: latitude,
                    longitude: longitude,
                  ),
                );
            AddAddressBloc().close();
          }
          // showSuccessDialog(context);
          // if (_formKey.currentState!.validate()) {
          //   // Handle save address
          // }
        },
        style: AddAddressStyles.saveButtonStyle,
        child: const Text(
          'Save Address',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// class AddAddress extends StatefulWidget {
//   final Placemark place;

//   const AddAddress({super.key, required this.place});

//   @override
//   State<AddAddress> createState() => _AddAddressState();
// }

// class _AddAddressState extends State<AddAddress> {
//   String selectedLabel = '';
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AddAddressStyles.backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios_new,
//               color: whitecolor,
//               size: 16,
//             )),
//         elevation: 0,
//         title: Text("Add Address Details"),
//       ),
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints:
//               const BoxConstraints(maxWidth: AddAddressStyles.maxWidth),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AddAddressStyles.defaultPadding,
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     _buildMapPreview(),
//                     const SizedBox(height: 18),
//                     _buildLocationInfo(place),
//                     const SizedBox(height: 22),
//                     _buildAddressForm(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMapPreview() {
//     return Container(
//       height: 323,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child:  ImageNetwork(url:
//           "https://cdn.builder.io/api/v1/image/assets/TEMP/08c56c190f2fda8733801f3fb8dd6154df55c0368b56a26bb54f2a751577ff14?placeholderIfAbsent=true&apiKey=479ee9553c984302af0d67c8f0a948e9",
//           fit: BoxFit.cover,
//           width: double.infinity,
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationInfo(Placemark place) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 place.subLocality ?? "",
//                 style: AddAddressStyles.locationTitleStyle,
//               ),
//               Text(
//                 "${place.name} ,${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}",
//                 style: AddAddressStyles.locationSubtitleStyle,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 49),
//         OutlinedButton(
//           onPressed: () {},
//           style: OutlinedButton.styleFrom(
//             side: const BorderSide(color: AddAddressStyles.primaryGreen),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(32),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
//           ),
//           child: const Text(
//             'Change',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAddressForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildInputField('House No. & Floor'),
//           const SizedBox(height: 8),
//           _buildInputField('Building & Block No.'),
//           const SizedBox(height: 8),
//           _buildInputField('Landmark & Area name(Optional)'),
//           const SizedBox(height: 25),
//           _buildAddressLabels(),
//           const SizedBox(height: 25),
//           _buildSaveButton(),
//           const SizedBox(height: 43),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputField(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: AddAddressStyles.labelStyle,
//         ),
//         const SizedBox(height: 4),
//         TextFormField(
//           decoration: InputDecoration(
//             hintText: 'Enter Details',
//             hintStyle: AddAddressStyles.inputStyle,
//             border: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(AddAddressStyles.borderRadius),
//               borderSide: const BorderSide(
//                 color: AddAddressStyles.borderColor,
//               ),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 10,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAddressLabels() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Add Address Label',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: AddAddressStyles.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             _buildLabelButton('Home'),
//             const SizedBox(width: 24),
//             _buildLabelButton('Work'),
//             const SizedBox(width: 24),
//             _buildLabelButton('Other'),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildLabelButton(String label) {
//     final isSelected = selectedLabel == label;
//     return SizedBox(
//       width: 100,
//       child: OutlinedButton(
//         onPressed: () {
//           // setState(() {
//           //   selectedLabel = label;
//           // });
//         },
//         style: AddAddressStyles.addressLabelButtonStyle.copyWith(
//           backgroundColor: isSelected
//               ? WidgetStateProperty.all(AddAddressStyles.primaryGreen)
//               : WidgetStateProperty.all(Colors.transparent),
//           foregroundColor: isSelected
//               ? WidgetStateProperty.all(Colors.white)
//               : WidgetStateProperty.all(AddAddressStyles.borderColor),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(fontSize: 12),
//         ),
//       ),
//     );
//   }

//   Widget _buildSaveButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           showSuccessDialog(context);
//           // if (_formKey.currentState!.validate()) {
//           //   // Handle save address
//           // }
//         },
//         style: AddAddressStyles.saveButtonStyle,
//         child: const Text(
//           'Save Address',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
