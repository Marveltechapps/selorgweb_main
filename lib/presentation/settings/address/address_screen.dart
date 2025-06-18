import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:selorgweb_main/model/addaddress/get_saved_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_screen.dart';
import 'package:selorgweb_main/presentation/location/addaddress/add_address_state.dart';
import 'package:selorgweb_main/presentation/location/location_main_screen.dart';
import 'package:selorgweb_main/presentation/settings/address/address_bloc.dart';
import 'package:selorgweb_main/presentation/settings/address/address_event.dart';
import 'package:selorgweb_main/presentation/settings/address/address_state.dart';
import 'package:selorgweb_main/utils/widgets/success_dialog_widget.dart';
import 'package:selorgweb_main/utils/constant.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static GetSavedAddressResponse getSavedAddressResponse =
      GetSavedAddressResponse();

  static String successMsg = "";

  static List<SearchedLocationResponse> searchedLocations = [];

  static TextEditingController searchLocationController =
      TextEditingController();

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

                  LocationMainScreen(screenType: 'address'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showSearchLocationAlertDialog(
    BuildContext context,
    AddressBloc homebloc,
  ) {
    showDialog(
      context: context,
      barrierDismissible: !(location == "No Location Found"),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: homebloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 500,
                            maxWidth: 500,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 30,
                            ),
                            child: Column(
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

                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: searchLocationController,
                                      cursorColor: appColor,
                                      cursorHeight: 15,
                                      onChanged: (value) {
                                        homebloc.add(
                                          SearchLocationEvent(
                                            searchText: value,
                                          ),
                                        );
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Search a new address",
                                        hintStyle:
                                            Theme.of(
                                              context,
                                            ).textTheme.labelMedium,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                          minWidth: 40,
                                          minHeight: 40,
                                        ),
                                        suffixIcon:
                                            searchLocationController
                                                    .text
                                                    .isNotEmpty
                                                ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      searchLocationController
                                                          .clear();
                                                      searchedLocations.clear();
                                                      context
                                                          .read<AddressBloc>()
                                                          .add(
                                                            SearchLocationEvent(
                                                              searchText: "",
                                                            ),
                                                          );
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                  ),
                                                )
                                                : null,
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 12,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.displayMedium,
                                    ),
                                  ),
                                ),
                                if (searchLocationController.text.isNotEmpty)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: searchedLocations.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  searchedLocations[index]
                                                          .structuredFormatting!
                                                          .mainText ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  searchedLocations[index]
                                                      .description!,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                onTap: () {
                                                  searchLocationController
                                                          .text =
                                                      searchedLocations[index]
                                                          .description!;
                                                  // context.read<AddressBloc>().add(
                                                  //   PlaceLocaitonEvent(
                                                  //     locationText:
                                                  //         "${searchedLocations[index].structuredFormatting!.mainText} - ${searchedLocations[index].structuredFormatting!.secondaryText!.split(",").first}",
                                                  //   ),
                                                  // );
                                                  Navigator.pop(context);
                                                  // context.read<LocationBloc>().add(
                                                  //     GetLatLonEvent(
                                                  //         latitude:
                                                  //             searchedLocations[index].lat!,
                                                  //         longitude:
                                                  //             searchedLocations[index].lon!));
                                                },
                                              ),
                                              Divider(),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (searchLocationController.text.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 40.0,
                                      top: 20,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        homebloc.add(ContinueLocationEvent());
                                        Navigator.pop(context);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return YourLocationScreen(
                                        //         screenType:
                                        //             screenType == "dialog"
                                        //                 ? "current"
                                        //                 : screenType,
                                        //       );
                                        //     },
                                        //   ),
                                        // );
                                      },
                                      child: Row(
                                        spacing: 8,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(locationIcon),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Current Location",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Using GPS",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void showAddAddress(BuildContext context, int i, bool isEdit) async {
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

    if (result == true) {
      if (!context.mounted) return;
      context.read()<AddressBloc>().add(GetSavedAddressEvent(userId: userId));
    }
  }

  static Placemark? placemark;
  static String latitude = "";
  static String longitude = "";

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AddressBloc())],
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressSuccessState) {
            debugPrint(
              'Address Edited or Added Successfully ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
            );
            getSavedAddressResponse = state.getSavedAddressResponse;
            debugPrint(getSavedAddressResponse.toString());
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
          } else if (state is SearchedLocationSuccessState) {
            debugPrint('state returns');
            debugPrint(state.searchedLocationResponse[0].toJson().toString());
            searchedLocations = state.searchedLocationResponse;
          } else if (state is AddressDeletedSuccessState) {
            successMsg = state.deleteAddressResponse.message ?? "";
            showSuccessDialog(
              true,
              "Your address has been Deleted",
              "",
              "",
              "save",
              context,
            );
            context.read<AddressBloc>().add(
              (GetSavedAddressEvent(userId: userId)),
            );

            // showSuccessDialog(true, successMsg, "" "", "", "", context);
          } else if (state is LocationSuccessStateFromAPi) {
            placemark = state.place;
            latitude = state.latitude!;
            longitude = state.longitude!;
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
            context.read<AddressBloc>().add(
              (GetLocationUsingLatLongFromApiEvent()),
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
                            backgroundColor: appColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            // showSearchLocationAlertDialog(
                            //   context,
                            //   context.read<AddressBloc>(),
                            // );
                            // searchLocationController.clear();

                            final result = await showDialog(
                              context: context,
                              barrierDismissible:
                                  !(location == "No Location Found"),
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 500,
                                      maxWidth: 500,
                                      minHeight: 500,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 8,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          spacing: 10,
                                          mainAxisSize: MainAxisSize.min,

                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap:
                                                    () =>
                                                        Navigator.pop(context),
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
                                              id: "",
                                              label: "",
                                              houseNo: "",
                                              building: "",
                                              landmark: "",
                                              latitude: latitude,
                                              longitude: longitude,
                                              isEdit: false,
                                              place: placemark!,
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
                                (GetSavedAddressEvent(userId: userId)),
                              );
                            }
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
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF202020),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 14,
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: appColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            // showSearchLocationAlertDialog(
                            //   context,
                            //   AddressBloc(),
                            // );
                            // searchLocationController.clear();

                            final result = await showDialog(
                              context: context,
                              barrierDismissible:
                                  !(location == "No Location Found"),
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 8,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          spacing: 10,
                                          mainAxisSize: MainAxisSize.min,

                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap:
                                                    () =>
                                                        Navigator.pop(context),
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
                                              id: "",
                                              label: "",
                                              houseNo: "",
                                              building: "",
                                              landmark: "",
                                              latitude: latitude,
                                              longitude: longitude,
                                              isEdit: false,
                                              place: placemark ?? Placemark(),
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
                                (GetSavedAddressEvent(userId: userId)),
                              );
                            }
                          },

                          child: Text(
                            'Add New Address',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                SizedBox(height: 10),
                Divider(color: greyColor, thickness: 0.5),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
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
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'icons/mingcute_location-line-dark.svg',
                                            width: 24,
                                            colorFilter: ColorFilter.mode(
                                              appColor,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          SizedBox(
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
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF202020),
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  "//${getSavedAddressResponse.data![i].details!.houseNo}, ${getSavedAddressResponse.data![i].details!.building}, ${getSavedAddressResponse.data![i].details!.landmark}, ${getSavedAddressResponse.data![i].details!.area}, ${getSavedAddressResponse.data![i].details!.city}, ${getSavedAddressResponse.data![i].details!.state}, ${getSavedAddressResponse.data![i].details!.pincode}",
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
                                                barrierDismissible:
                                                    !(location ==
                                                        "No Location Found"),
                                                builder: (
                                                  BuildContext context,
                                                ) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                            maxHeight: 500,
                                                            maxWidth: 500,
                                                            minHeight: 500,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 8,
                                                            ),
                                                        child: SingleChildScrollView(
                                                          child: Column(
                                                            spacing: 10,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,

                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: InkWell(
                                                                  onTap:
                                                                      () => Navigator.pop(
                                                                        context,
                                                                      ),
                                                                  child: CircleAvatar(
                                                                    radius: 14,
                                                                    backgroundColor:
                                                                        appColor,
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      size: 16,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              AddAddress(
                                                                id:
                                                                    getSavedAddressResponse
                                                                        .data![i]
                                                                        .id ??
                                                                    "",
                                                                label:
                                                                    getSavedAddressResponse
                                                                        .data![i]
                                                                        .label,
                                                                houseNo:
                                                                    getSavedAddressResponse
                                                                        .data![i]
                                                                        .details!
                                                                        .houseNo,
                                                                building:
                                                                    getSavedAddressResponse
                                                                        .data![i]
                                                                        .details!
                                                                        .building,
                                                                landmark:
                                                                    getSavedAddressResponse
                                                                        .data![i]
                                                                        .details!
                                                                        .landmark,
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
                                                                isEdit: true,
                                                                place: Placemark(
                                                                  subLocality:
                                                                      getSavedAddressResponse
                                                                          .data![i]
                                                                          .details!
                                                                          .area,
                                                                  name: "",
                                                                  administrativeArea:
                                                                      getSavedAddressResponse
                                                                          .data![i]
                                                                          .details!
                                                                          .state,
                                                                  country: "",
                                                                  isoCountryCode:
                                                                      "",
                                                                  locality:
                                                                      getSavedAddressResponse
                                                                          .data![i]
                                                                          .details!
                                                                          .city,
                                                                  postalCode:
                                                                      getSavedAddressResponse
                                                                          .data![i]
                                                                          .details!
                                                                          .pincode,
                                                                  street: "",
                                                                  subAdministrativeArea:
                                                                      "",
                                                                  subThoroughfare:
                                                                      "",
                                                                  thoroughfare:
                                                                      "",
                                                                ),
                                                                screenType:
                                                                    "editaddress",
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
                                              color: appColor,
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
                                              color: appColor,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
