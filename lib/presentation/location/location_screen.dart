import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/presentation/location/location_bloc.dart';
import 'package:selorgweb_main/presentation/location/location_event.dart';
import 'package:selorgweb_main/presentation/location/location_state.dart';
import 'package:selorgweb_main/presentation/location/yourlocation/your_location_screen.dart';

import '../../utils/constant.dart';

class LocationScreen extends StatelessWidget {
  final String screenType;
  const LocationScreen({super.key, required this.screenType});

  static TextEditingController controller = TextEditingController();
  static List<SearchedLocationResponse> searchedLocations = [];
  static Timer? debounce;
  static bool isLocationshow = false;
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
          } else if (state is LatLongSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return YourLocationScreen(
                    lat: state.latitude,
                    long: state.longitude,
                    screenType: screenType == "address" ? "listview" : "search",
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
          return Column(
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
              SizedBox(height: 0),
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
                    decoration: InputDecoration(
                      hintText: "Search a new address",
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.search, color: Colors.grey, size: 20),
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
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(fontSize: 20),
                  ),
                ),
              ),
              if (controller.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
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
                                  GetLatLonOnListEvent(
                                    placeId: searchedLocations[index].placeId!,
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
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, "/yourLocation");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return YourLocationScreen(
                              screenType:
                                  screenType == "dialog"
                                      ? "current"
                                      : screenType,
                            );
                          },
                        ),
                      );
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
          );
        },
      ),
    );
  }
}
