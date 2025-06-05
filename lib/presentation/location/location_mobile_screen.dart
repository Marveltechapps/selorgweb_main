import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/presentation/location/location_bloc.dart';
import 'package:selorgweb_main/presentation/location/location_event.dart';
import 'package:selorgweb_main/presentation/location/location_state.dart';
import 'package:selorgweb_main/presentation/location/yourlocation/your_location_screen.dart';

import 'package:selorgweb_main/utils/constant.dart';

class LocationMobileScreen extends StatelessWidget {
  final String screenType;
  const LocationMobileScreen({super.key, required this.screenType});

  static TextEditingController controller = TextEditingController();
  static List<SearchedLocationResponse> searchedLocations = [];
  static Timer? debounce;
  static bool isLocationshow = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(),
      child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is SearchedLocationSuccessState) {
            searchedLocations = state.searchedLocationResponse;
            // for (var element in state.searchedLocationResponse) {
            //   // debugPrint("Searched Location: ${element.}");
            // }
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
            Navigator.pop(context, location);
            // place =
            //     p.Placemark.fromGooglePlace(
            //           state.latLongLocationResponse.results?.first
            //               as Map<String, dynamic>,
            //         )
            //         as Placemark;
            debugPrint("works");
            // debugPrint(place.name);
          } else if (state is PlaceLocaitonState) {
            location = state.locationText;
            Navigator.pop(context, location);
          } else if (state is LocationContinueSuccessState) {
            context.read<LocationBloc>().add(
              GetLocationUsingLatLongFromApiEvent(
                latitude: state.latitude ?? "",
                longitude: state.longitude ?? "",
              ),
            );
          } else if (state is LocationContinueGetSuccessState) {
            context.read<LocationBloc>().add(
              GetLocationUsingLatLongFromApiTwoEvent(
                latitude: state.latitude ?? "",
                longitude: state.longitude ?? "",
              ),
            );
          } else if (state is LatLongSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return YourLocationScreen(
                    lat: state.latitude,
                    long: state.longitude,
                    screenType:
                        screenType == "address"
                            ? "listview"
                            : screenType == "search"
                            ? "search"
                            : screenType,
                  );
                },
              ),
            );
          } else if (state is LocationErrorState) {
            // Handle error state
            debugPrint("Error: ${state.error}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is LocationInitialState) {
            controller.clear();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(3, 71, 3, 1),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: whitecolor,
                  size: 16,
                ),
              ),
              title: Text(
                "Location",
                style: TextStyle(color: whitecolor, fontSize: 18),
              ),
            ),
            body: Column(
              children: [
                // GooglePlaceAutoCompleteTextField(
                //   textEditingController: controller,
                //   //countries: ["India"],
                //   textStyle: TextStyle(fontSize: 18, color: Colors.black),
                //   googleAPIKey: "AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ",
                //   inputDecoration: InputDecoration(
                //     hintText: "Search a new address",
                //     hintStyle: Theme.of(context).textTheme.labelMedium,
                //     border: OutlineInputBorder(),
                //   ),
                //   debounceTime: 800, // Delay in API calls
                //   isLatLngRequired: true,
                //   getPlaceDetailWithLatLng: (placeDetail) {
                //     debugPrint(
                //         "Latitude: ${placeDetail.lat}, Longitude: ${placeDetail.lng}");
                //   },

                //   itemClick: (prediction) {
                //     controller.text = prediction.description!;
                //     controller.selection = TextSelection.fromPosition(
                //       TextPosition(offset: prediction.description!.length),
                //     );
                //   },
                //   itemBuilder: (context, index, prediction) {
                //     return ListTile(
                //       title: Text(
                //         prediction.description!,
                //         style: TextStyle(fontSize: 18, color: Colors.black),
                //       ),
                //     );
                //   },
                // ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: controller,
                      cursorColor: appColor,
                      onChanged: (value) {
                        context.read<LocationBloc>().add(
                          SearchLocationEvent(searchText: value),
                        );
                      },
                      cursorHeight: 15,
                      decoration: InputDecoration(
                        hintText: "Search a new address",
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
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
                            controller.text.isNotEmpty
                                ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.clear();
                                      searchedLocations.clear();
                                      context.read<LocationBloc>().add(
                                        SearchLocationEvent(searchText: ""),
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
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
                if (controller.text.isNotEmpty)
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
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  searchedLocations[index].description!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                onTap: () {
                                  controller.text =
                                      searchedLocations[index].description!;
                                  context.read<LocationBloc>().add(
                                    PlaceLocaitonEvent(
                                      locationText:
                                          "${searchedLocations[index].structuredFormatting!.mainText} - ${searchedLocations[index].structuredFormatting!.secondaryText!.split(",").first}",
                                    ),
                                  );
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
                if (controller.text.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 20),
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, "/yourLocation");
                        context.read<LocationBloc>().add(
                          ContinueGetLocationEvent(),
                        );
                        //   Navigator.pop(context);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(locationIcon),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Current Location",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Using GPS",
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ],
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
