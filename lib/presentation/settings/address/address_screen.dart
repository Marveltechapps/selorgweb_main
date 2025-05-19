import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:selorgweb_main/model/addaddress/get_saved_address_response_model.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_screen.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_state.dart';
import 'package:selorgweb_main/presentation/location/location_screen.dart';
import 'package:selorgweb_main/presentation/settings/address/address_bloc.dart';
import 'package:selorgweb_main/presentation/settings/address/address_event.dart';
import 'package:selorgweb_main/presentation/settings/address/address_state.dart';
import 'package:selorgweb_main/widgets/success_dialog_widget.dart';
import 'package:selorgweb_main/utils/constant.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static GetSavedAddressResponse getSavedAddressResponse =
      GetSavedAddressResponse();

  static String successMsg = "";
  void showLocationMainAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: !(location == "No Location Found"),
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

                  LocationScreen(screenType: 'address'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showAddAddress(BuildContext context, int i) async{
    final result = await showDialog(
      context: context,
      barrierDismissible: !(location == "No Location Found"),
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
              child: SingleChildScrollView(
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
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    AddAddress(
                      id: getSavedAddressResponse.data![i].id ?? "",
                      label: getSavedAddressResponse.data![i].label,
                      houseNo:
                          getSavedAddressResponse.data![i].details!.houseNo,
                      building:
                          getSavedAddressResponse.data![i].details!.building,
                      landmark:
                          getSavedAddressResponse.data![i].details!.landmark,
                      latitude:
                          getSavedAddressResponse.data![i].coordinates!.latitude
                              .toString(),
                      longitude:
                          getSavedAddressResponse
                              .data![i]
                              .coordinates!
                              .longitude
                              .toString(),
                      isEdit: true,
                      place: Placemark(
                        subLocality:
                            getSavedAddressResponse.data![i].details!.area,
                        name: "",
                        administrativeArea:
                            getSavedAddressResponse.data![i].details!.state,
                        country: "",
                        isoCountryCode: "",
                        locality:
                            getSavedAddressResponse.data![i].details!.city,
                        postalCode:
                            getSavedAddressResponse.data![i].details!.pincode,
                        street: "",
                        subAdministrativeArea: "",
                        subThoroughfare: "",
                        thoroughfare: "",
                      ),
                      screenType: "editaddress",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if(result == true){
      context.read()<AddressBloc>().add(
              GetSavedAddressEvent(userId: userId),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return BlocProvider(
      create: (context) => AddressBloc(),
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressSuccessState) {
            debugPrint(
              'Address Edited or Added Successfully ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
            );
            getSavedAddressResponse = state.getSavedAddressResponse;
            debugPrint(getSavedAddressResponse.data![0].label);
            // context.read<AddressBloc>().add(
            //   (GetSavedAddressEvent(userId: userId)),
            // );
          } else if (state is AddAddressSaveSuccess) {
            debugPrint(
              'Address Edited or Added Successfully ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
            );
            // debugPrint(state.addAddressSaveResponse);
            context.read<AddressBloc>().add(
              (GetSavedAddressEvent(userId: userId)),
            );
          } else if (state is AddressDeletedSuccessState) {
            successMsg = state.deleteAddressResponse.message ?? "";
            showSuccessDialog(
              true,
              "Your address has been Deleted",
              "",
              "",
              "delete",
              context,
            );
            context.read<AddressBloc>().add(
              (GetSavedAddressEvent(userId: userId)),
            );

            // showSuccessDialog(true, successMsg, "" "", "", "", context);
          } else if (state is AddressErrorState) {
            getSavedAddressResponse.data = [];
          }
        },
        builder: (context, state) {
          if (state is AddressInitialState) {
            getSavedAddressResponse.data = [];
            context.read<AddressBloc>().add(
              (GetSavedAddressEvent(userId: userId)),
            );
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is AddressLoadingState,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: Column(
              children: [
                isMobile
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Saved Addresses',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF202020),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF034703),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            /* var res = */
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return LocationScreen(screenType: 'address');
                            //     },
                            //   ),
                            // );
                            showLocationMainAlertDialog(context);
                            //debugPrint(res);
                            if (!context.mounted) return;
                            context.read<AddressBloc>().add(
                              (GetSavedAddressEvent(userId: userId)),
                            );
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>YourLocationScreen(screenType: 'listview')));
                          },

                          child: Text(
                            'Add New Address',
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Saved Addresses',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF202020),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF034703),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>YourLocationScreen(screenType: 'listview')));
                            showLocationMainAlertDialog(context);
                            /* var res = */
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return LocationScreen(screenType: 'address');
                            //     },
                            //   ),
                            // );
                            //debugPrint(res);
                            if (!context.mounted) return;
                            context.read<AddressBloc>().add(
                              (GetSavedAddressEvent(userId: userId)),
                            );
                          },

                          child: Text(
                            'Add New Address',
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                SizedBox(height: 20),
                Divider(color: Color(0xFF034703), thickness: 0.5),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child:
                        getSavedAddressResponse.data!.isEmpty
                            ? Center(
                              child: Text(
                                "No Address Found",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            )
                            : ListView.builder(
                              shrinkWrap: true,
                              itemCount: getSavedAddressResponse.data!.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'icons/mingcute_location-line-dark.svg',
                                          width: 25,
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getSavedAddressResponse
                                                        .data![i]
                                                        .label ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF202020),
                                                ),
                                                maxLines: 1,
                                              ),
                                              Text(
                                                "${getSavedAddressResponse.data![i].details!.houseNo}, ${getSavedAddressResponse.data![i].details!.building}, ${getSavedAddressResponse.data![i].details!.landmark}, ${getSavedAddressResponse.data![i].details!.area}, ${getSavedAddressResponse.data![i].details!.city}, ${getSavedAddressResponse.data![i].details!.state}, ${getSavedAddressResponse.data![i].details!.pincode}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xFF444444),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // showAddAddress(context, i);
                                            // var res = await Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) {
                                            //       return AddAddress(
                                            //         id:
                                            //             getSavedAddressResponse
                                            //                 .data![i]
                                            //                 .id ??
                                            //             "",
                                            //         label:
                                            //             getSavedAddressResponse
                                            //                 .data![i]
                                            //                 .label,
                                            //         houseNo:
                                            //             getSavedAddressResponse
                                            //                 .data![i]
                                            //                 .details!
                                            //                 .houseNo,
                                            //         building:
                                            //             getSavedAddressResponse
                                            //                 .data![i]
                                            //                 .details!
                                            //                 .building,
                                            //         landmark:
                                            //             getSavedAddressResponse
                                            //                 .data![i]
                                            //                 .details!
                                            //                 .landmark,
                                            //         latitude:
                                            //             getSavedAddressResponse
                                            //                 .data![i]
                                            //                 .coordinates!
                                            //                 .latitude
                                            //                 .toString(),
                                            //         longitude:
                                            //             getSavedAddressResponse
                                            //                 .data![i]
                                            //                 .coordinates!
                                            //                 .longitude
                                            //                 .toString(),
                                            //         isEdit: true,
                                            //         place: Placemark(
                                            //           subLocality:
                                            //               getSavedAddressResponse
                                            //                   .data![i]
                                            //                   .details!
                                            //                   .area,
                                            //           name: "",
                                            //           administrativeArea:
                                            //               getSavedAddressResponse
                                            //                   .data![i]
                                            //                   .details!
                                            //                   .state,
                                            //           country: "",
                                            //           isoCountryCode: "",
                                            //           locality:
                                            //               getSavedAddressResponse
                                            //                   .data![i]
                                            //                   .details!
                                            //                   .city,
                                            //           postalCode:
                                            //               getSavedAddressResponse
                                            //                   .data![i]
                                            //                   .details!
                                            //                   .pincode,
                                            //           street: "",
                                            //           subAdministrativeArea: "",
                                            //           subThoroughfare: "",
                                            //           thoroughfare: "",
                                            //         ),
                                            //         screenType: "editaddress",
                                            //       );
                                            //     },
                                            //   ),
                                            // );
                                            final result = await showDialog(
      context: context,
      barrierDismissible: !(location == "No Location Found"),
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
              child: SingleChildScrollView(
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
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    AddAddress(
                      id: getSavedAddressResponse.data![i].id ?? "",
                      label: getSavedAddressResponse.data![i].label,
                      houseNo:
                          getSavedAddressResponse.data![i].details!.houseNo,
                      building:
                          getSavedAddressResponse.data![i].details!.building,
                      landmark:
                          getSavedAddressResponse.data![i].details!.landmark,
                      latitude:
                          getSavedAddressResponse.data![i].coordinates!.latitude
                              .toString(),
                      longitude:
                          getSavedAddressResponse
                              .data![i]
                              .coordinates!
                              .longitude
                              .toString(),
                      isEdit: true,
                      place: Placemark(
                        subLocality:
                            getSavedAddressResponse.data![i].details!.area,
                        name: "",
                        administrativeArea:
                            getSavedAddressResponse.data![i].details!.state,
                        country: "",
                        isoCountryCode: "",
                        locality:
                            getSavedAddressResponse.data![i].details!.city,
                        postalCode:
                            getSavedAddressResponse.data![i].details!.pincode,
                        street: "",
                        subAdministrativeArea: "",
                        subThoroughfare: "",
                        thoroughfare: "",
                      ),
                      screenType: "editaddress",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

                                            if (result == "success") {
                                            if (!context.mounted) return;
                                            context.read<AddressBloc>().add(
                                              (GetSavedAddressEvent(
                                                userId: userId,
                                              )),
                                            );
                                            }
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Color(0xFF034703),
                                            size: 25,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            context.read<AddressBloc>().add(
                                              DeleteSavedAddressEvent(
                                                area:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .area ??
                                                    "",
                                                building:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .building ??
                                                    "",
                                                city:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .city ??
                                                    "",
                                                houseNo:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .houseNo ??
                                                    "",
                                                label:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .label ??
                                                    "",
                                                landMark:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .landmark ??
                                                    "",
                                                state:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .state ??
                                                    "",
                                                pinCode:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .pincode ??
                                                    "",
                                                latitude:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .coordinates!
                                                        .latitude
                                                        .toString(),
                                                longitude:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .coordinates!
                                                        .longitude
                                                        .toString(),
                                                id:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .id ??
                                                    "",
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.delete_rounded,
                                            color: Color(0xFF034703),
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
