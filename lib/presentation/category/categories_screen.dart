import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/presentation/category/category_bloc.dart';
import 'package:selorgweb_main/presentation/category/category_event.dart';
import 'package:selorgweb_main/presentation/category/category_state.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_main_screen.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/presentation/home/home_bloc.dart';
import 'package:selorgweb_main/presentation/home/home_event.dart' as he;
import 'package:selorgweb_main/presentation/home/home_state.dart' as hs;
import 'package:selorgweb_main/utils/widgets/bottom_app_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_categories_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_image_widget.dart';
import 'package:selorgweb_main/utils/widgets/header_widget.dart';
import 'package:selorgweb_main/utils/widgets/network_image.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static List<Category> categories = [];
  static MainCategory mainCategory = MainCategory();

  static List<SearchedLocationResponse> searchedLocations = [];

  static TextEditingController searchLocationController =
      TextEditingController();

  void showSearchLocationAlertDialog(BuildContext context, HomeBloc homebloc) {
    showDialog(
      context: context,
      barrierDismissible: !(location == "No Location Found"),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: homebloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<HomeBloc, hs.HomeState>(
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
                                          he.SearchLocationEvent(
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
                                                      context.read<HomeBloc>().add(
                                                        he.SearchLocationEvent(
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
                                                  context.read<HomeBloc>().add(
                                                    he.PlaceLocaitonEvent(
                                                      locationText:
                                                          "${searchedLocations[index].structuredFormatting!.mainText} - ${searchedLocations[index].structuredFormatting!.secondaryText!.split(",").first}",
                                                    ),
                                                  );
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
                                        homebloc.add(
                                          he.ContinueLocationEvent(),
                                        );
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

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width < 991;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: BlocConsumer<HomeBloc, hs.HomeState>(
        listener: (context, state) {
          if (state is hs.SearchedLocationSuccessState) {
            searchedLocations = state.searchedLocationResponse;
          } else if (state is hs.LocationContinueSuccessState) {
            context.read<HomeBloc>().add(
              he.GetLocationUsingLatLongFromApiEvent(
                latitude: state.latitude ?? "",
                longitude: state.longitude ?? "",
              ),
            );
          } else if (state is hs.LatLongAddressSuccessState) {
            location =
                "${state.latLongLocationResponse.results![0].addressComponents![1].shortName} - ${state.latLongLocationResponse.results![0].addressComponents![3].shortName}";
            debugPrint(location);
          } else if (state is hs.PlaceLocaitonState) {
            location = state.locationText;
          }
        },
        builder: (context, state) {
          return BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is MainCategoryLoadedState) {
                debugPrint("mainCategoryLoaded");
                mainCategory = state.mainCategory;
              } else if (state is CategoryLoadedState) {
                debugPrint("CategoryLoadedState");
                categories = state.categories;
              } else if (state is CategoryErrorState) {
                debugPrint("CategoryErrorState");
              }
            },
            builder: (context, state) {
              if (state is CategoryInitialState) {
                debugPrint("CategoryInitialState");
                context.read<CategoryBloc>().add(GetMainCategoryDataEvent());
                context.read<CategoryBloc>().add(GetCategoryDataEvent());
              }
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      HeaderWidget(
                        isHomeScreen: false,
                        onClick: () {
                          showSearchLocationAlertDialog(
                            context,
                            context.read<HomeBloc>(),
                          );
                        },
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: isMobile ? 20 : 60,
                      //   ),
                      //   child: Column(
                      //     spacing: 20,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Explore by Categories',
                      //             style: GoogleFonts.poppins(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w700,
                      //               color: blackColor,
                      //             ),
                      //           ),
                      //           // if (mainCategory.data != null)
                      //           // InkWell(
                      //           //   onTap: () {
                      //           //     Navigator.push(
                      //           //       context,
                      //           //       MaterialPageRoute(
                      //           //         builder: (context) {
                      //           //           return CategoriesScreen();
                      //           //         },
                      //           //       ),
                      //           //     );
                      //           //   },
                      //           //   child: Row(
                      //           //     children: [
                      //           //       Text(
                      //           //         'See All',
                      //           //         style: GoogleFonts.poppins(
                      //           //           fontSize: 13,
                      //           //           fontWeight: FontWeight.w600,
                      //           //           color: appColor,
                      //           //         ),
                      //           //       ),
                      //           //       const SizedBox(width: 6),
                      //           //       Icon(
                      //           //         Icons.arrow_forward_ios_rounded,
                      //           //         size: 14,
                      //           //         color: appColor,
                      //           //       ),
                      //           //     ],
                      //           //   ),
                      //           // ),
                      //         ],
                      //       ),
                      //       // Row(
                      //       //   spacing: 16,
                      //       //   children: [
                      //       //     if (mainCategory.data != null)
                      //       //       for (
                      //       //         int i = 0;
                      //       //         i < mainCategory.data!.length;
                      //       //         i++
                      //       //       )
                      //       //         Expanded(
                      //       //           child: InkWell(
                      //       //             onTap: () {
                      //       //               // Navigator.push(
                      //       //               //   context,
                      //       //               //   MaterialPageRoute(
                      //       //               //     builder:
                      //       //               //         (context) =>
                      //       //               //             ProductListMenuScreen(
                      //       //               //               title:
                      //       //               //                   mainCategory
                      //       //               //                       .data![i]
                      //       //               //                       .name ??
                      //       //               //                   "",
                      //       //               //               id:
                      //       //               //                   mainCategory
                      //       //               //                       .data![i]
                      //       //               //                       .id ??
                      //       //               //                   "",
                      //       //               //               isMainCategory:
                      //       //               //                   true,
                      //       //               //               mainCatId:
                      //       //               //                   mainCategory
                      //       //               //                       .data![i]
                      //       //               //                       .id ??
                      //       //               //                   "",
                      //       //               //               isCategory: false,
                      //       //               //               catId: "",
                      //       //               //             ),
                      //       //               //   ),
                      //       //               // );
                      //       //             },
                      //       //             child: Column(
                      //       //               children: [
                      //       //                 Container(
                      //       //                   height: 130,
                      //       //                   decoration: BoxDecoration(
                      //       //                     color: const Color(0xFFE5EEC3),
                      //       //                     borderRadius:
                      //       //                         BorderRadius.circular(5),
                      //       //                     boxShadow: [
                      //       //                       BoxShadow(
                      //       //                         color: greyColor,
                      //       //                         blurRadius: 4,
                      //       //                         offset: const Offset(0, 0),
                      //       //                       ),
                      //       //                     ],
                      //       //                   ),
                      //       //                   // child: Center(
                      //       //                   //   child: Image.network(
                      //       //                   //     mainCategory
                      //       //                   //             .data![i]
                      //       //                   //             .imageUrl ??
                      //       //                   //         "",
                      //       //                   //     fit: BoxFit.contain,
                      //       //                   //   ),
                      //       //                   // ),
                      //       //                 ),
                      //       //                 const SizedBox(height: 8),
                      //       //                 Text(
                      //       //                   mainCategory.data![i].name ?? "",
                      //       //                   textAlign: TextAlign.center,
                      //       //                   style: const TextStyle(
                      //       //                     fontSize: 13,
                      //       //                     fontWeight: FontWeight.w600,
                      //       //                     color: Color(0xFF222222),
                      //       //                   ),
                      //       //                 ),
                      //       //               ],
                      //       //             ),
                      //       //           ),
                      //       //         ),
                      //       //   ],
                      //       // ),
                      //       isTablet
                      //           ? Wrap(
                      //             crossAxisAlignment: WrapCrossAlignment.start,
                      //             spacing: 20,
                      //             runSpacing: 20,
                      //             children: [
                      //               SizedBox(
                      //                 // height: 150,
                      //                 // width: 130,
                      //                 //  color: redColor,
                      //                 child: Row(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   spacing: 16,
                      //                   children: [
                      //                     if (mainCategory.data != null)
                      //                       for (
                      //                         int i = 0;
                      //                         i < mainCategory.data!.length;
                      //                         i++
                      //                       )
                      //                         Expanded(
                      //                           child: InkWell(
                      //                             onTap: () {
                      //                               title =
                      //                                   mainCategory
                      //                                       .data![i]
                      //                                       .name ??
                      //                                   "";
                      //                               id =
                      //                                   mainCategory
                      //                                       .data![i]
                      //                                       .id ??
                      //                                   "";
                      //                               isMainCategory = true;
                      //                               mainCatId =
                      //                                   mainCategory
                      //                                       .data![i]
                      //                                       .id ??
                      //                                   "";
                      //                               isCategory = false;
                      //                               catId = "";
                      //                               Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder:
                      //                                       (
                      //                                         context,
                      //                                       ) => ProductListMenuScreen(
                      //                                         title:
                      //                                             mainCategory
                      //                                                 .data![i]
                      //                                                 .name ??
                      //                                             "",
                      //                                         id:
                      //                                             mainCategory
                      //                                                 .data![i]
                      //                                                 .id ??
                      //                                             "",
                      //                                         isMainCategory:
                      //                                             true,
                      //                                         mainCatId:
                      //                                             mainCategory
                      //                                                 .data![i]
                      //                                                 .id ??
                      //                                             "",
                      //                                         isCategory: false,
                      //                                         catId: "",
                      //                                       ),
                      //                                 ),
                      //                               );
                      //                             },
                      //                             child: Column(
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .stretch,
                      //                               children: [
                      //                                 Container(
                      //                                   height: 130,
                      //                                   width: null,
                      //                                   decoration: BoxDecoration(
                      //                                     color: const Color(
                      //                                       0xFFE5EEC3,
                      //                                     ),
                      //                                     borderRadius:
                      //                                         BorderRadius.circular(
                      //                                           5,
                      //                                         ),
                      //                                     boxShadow: [
                      //                                       BoxShadow(
                      //                                         color: greyColor,
                      //                                         blurRadius: 3,
                      //                                         offset:
                      //                                             const Offset(
                      //                                               0,
                      //                                               1,
                      //                                             ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                   child: Column(
                      //                                     mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .center,
                      //                                     children: [
                      //                                       ImageNetworkWidget(
                      //                                         url:
                      //                                             mainCategory
                      //                                                 .data![i]
                      //                                                 .imageUrl ??
                      //                                             "",
                      //                                         height: 100,
                      //                                         width:
                      //                                             double.infinity,
                      //                                         fit: BoxFit.contain,
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ),
                      //                                 SizedBox(height: 10),
                      //                                 Text(
                      //                                   mainCategory
                      //                                           .data![i]
                      //                                           .name ??
                      //                                       "",
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   style: TextStyle(
                      //                                     fontSize: 14,
                      //                                     fontWeight:
                      //                                         FontWeight.w600,
                      //                                     color: Color(
                      //                                       0xFF222222,
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 // height: 150,
                      //                 // width: 130,
                      //                 // color: redColor,
                      //                 child: Row(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   spacing: 20,
                      //                   children: [
                      //                     if (categories.isNotEmpty)
                      //                       for (int i = 0; i < 3; i++)
                      //                         Expanded(
                      //                           child: InkWell(
                      //                             onTap: () {
                      //                               title =
                      //                                   categories[i].name ?? "";
                      //                               id = categories[i].id ?? "";
                      //                               isMainCategory = false;
                      //                               mainCatId = "";
                      //                               isCategory = true;
                      //                               catId =
                      //                                   categories[i].id ?? "";
                      //                               Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder:
                      //                                       (
                      //                                         context,
                      //                                       ) => ProductListMenuScreen(
                      //                                         title:
                      //                                             categories[i]
                      //                                                 .name ??
                      //                                             "",
                      //                                         id:
                      //                                             categories[i]
                      //                                                 .id ??
                      //                                             "",
                      //                                         isMainCategory:
                      //                                             false,
                      //                                         mainCatId: "",
                      //                                         isCategory: true,
                      //                                         catId:
                      //                                             categories[i]
                      //                                                 .id ??
                      //                                             "",
                      //                                       ),
                      //                                 ),
                      //                               );
                      //                             },
                      //                             child: Column(
                      //                               children: [
                      //                                 Container(
                      //                                   height: 130,
                      //                                   width: null,
                      //                                   decoration: BoxDecoration(
                      //                                     color: const Color(
                      //                                       0xFFE5EEC3,
                      //                                     ),
                      //                                     borderRadius:
                      //                                         BorderRadius.circular(
                      //                                           5,
                      //                                         ),
                      //                                     boxShadow: [
                      //                                       BoxShadow(
                      //                                         color: greyColor,
                      //                                         blurRadius: 3,
                      //                                         offset:
                      //                                             const Offset(
                      //                                               0,
                      //                                               1,
                      //                                             ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                   child: Column(
                      //                                     mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .center,
                      //                                     children: [
                      //                                       ImageNetworkWidget(
                      //                                         url:
                      //                                             categories[i]
                      //                                                 .imageUrl ??
                      //                                             "",
                      //                                         height: 100,
                      //                                         width:
                      //                                             double.infinity,
                      //                                         fit: BoxFit.contain,
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ),
                      //                                 SizedBox(height: 10),
                      //                                 Text(
                      //                                   categories[i].name ?? "",
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   style: const TextStyle(
                      //                                     fontSize: 14,
                      //                                     fontWeight:
                      //                                         FontWeight.w600,
                      //                                     color: Color(
                      //                                       0xFF222222,
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           )
                      //           : Row(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             spacing: 20,
                      //             children: [
                      //               Expanded(
                      //                 child: SizedBox(
                      //                   // height: 150,
                      //                   // width: 130,
                      //                   //  color: redColor,
                      //                   child: Row(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     spacing: 16,
                      //                     children: [
                      //                       if (mainCategory.data != null)
                      //                         for (
                      //                           int i = 0;
                      //                           i < mainCategory.data!.length;
                      //                           i++
                      //                         )
                      //                           Expanded(
                      //                             child: InkWell(
                      //                               onTap: () {
                      //                                 title =
                      //                                     mainCategory
                      //                                         .data![i]
                      //                                         .name ??
                      //                                     "";
                      //                                 id =
                      //                                     mainCategory
                      //                                         .data![i]
                      //                                         .id ??
                      //                                     "";
                      //                                 isMainCategory = true;
                      //                                 mainCatId =
                      //                                     mainCategory
                      //                                         .data![i]
                      //                                         .id ??
                      //                                     "";
                      //                                 isCategory = false;
                      //                                 catId = "";
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(
                      //                                     builder:
                      //                                         (
                      //                                           context,
                      //                                         ) => ProductListMenuScreen(
                      //                                           title:
                      //                                               mainCategory
                      //                                                   .data![i]
                      //                                                   .name ??
                      //                                               "",
                      //                                           id:
                      //                                               mainCategory
                      //                                                   .data![i]
                      //                                                   .id ??
                      //                                               "",
                      //                                           isMainCategory:
                      //                                               true,
                      //                                           mainCatId:
                      //                                               mainCategory
                      //                                                   .data![i]
                      //                                                   .id ??
                      //                                               "",
                      //                                           isCategory: false,
                      //                                           catId: "",
                      //                                         ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                               child: Column(
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .stretch,
                      //                                 children: [
                      //                                   Container(
                      //                                     height: 130,
                      //                                     width: null,
                      //                                     decoration: BoxDecoration(
                      //                                       color: const Color(
                      //                                         0xFFE5EEC3,
                      //                                       ),
                      //                                       borderRadius:
                      //                                           BorderRadius.circular(
                      //                                             5,
                      //                                           ),
                      //                                       boxShadow: [
                      //                                         BoxShadow(
                      //                                           color: greyColor,
                      //                                           blurRadius: 3,
                      //                                           offset:
                      //                                               const Offset(
                      //                                                 0,
                      //                                                 1,
                      //                                               ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                     child: Column(
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         ImageNetworkWidget(
                      //                                           url:
                      //                                               mainCategory
                      //                                                   .data![i]
                      //                                                   .imageUrl ??
                      //                                               "",
                      //                                           height: 100,
                      //                                           width:
                      //                                               double.infinity,
                      //                                           fit: BoxFit.contain,
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(height: 10),
                      //                                   Text(
                      //                                     mainCategory
                      //                                             .data![i]
                      //                                             .name ??
                      //                                         "",
                      //                                     textAlign:
                      //                                         TextAlign.center,
                      //                                     style: TextStyle(
                      //                                       fontSize: 14,
                      //                                       fontWeight:
                      //                                           FontWeight.w600,
                      //                                       color: Color(
                      //                                         0xFF222222,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: SizedBox(
                      //                   // height: 150,
                      //                   // width: 130,
                      //                   // color: redColor,
                      //                   child: Row(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     spacing: 20,
                      //                     children: [
                      //                       if (categories.isNotEmpty)
                      //                         for (int i = 0; i < 3; i++)
                      //                           Expanded(
                      //                             child: InkWell(
                      //                               onTap: () {
                      //                                 title =
                      //                                     categories[i].name ?? "";
                      //                                 id = categories[i].id ?? "";
                      //                                 isMainCategory = false;
                      //                                 mainCatId = "";
                      //                                 isCategory = true;
                      //                                 catId =
                      //                                     categories[i].id ?? "";
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(
                      //                                     builder:
                      //                                         (
                      //                                           context,
                      //                                         ) => ProductListMenuScreen(
                      //                                           title:
                      //                                               categories[i]
                      //                                                   .name ??
                      //                                               "",
                      //                                           id:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                           isMainCategory:
                      //                                               false,
                      //                                           mainCatId: "",
                      //                                           isCategory: true,
                      //                                           catId:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                         ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                               child: Column(
                      //                                 children: [
                      //                                   Container(
                      //                                     height: 130,
                      //                                     width: null,
                      //                                     decoration: BoxDecoration(
                      //                                       color: const Color(
                      //                                         0xFFE5EEC3,
                      //                                       ),
                      //                                       borderRadius:
                      //                                           BorderRadius.circular(
                      //                                             5,
                      //                                           ),
                      //                                       boxShadow: [
                      //                                         BoxShadow(
                      //                                           color: greyColor,
                      //                                           blurRadius: 3,
                      //                                           offset:
                      //                                               const Offset(
                      //                                                 0,
                      //                                                 1,
                      //                                               ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                     child: Column(
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         ImageNetworkWidget(
                      //                                           url:
                      //                                               categories[i]
                      //                                                   .imageUrl ??
                      //                                               "",
                      //                                           height: 100,
                      //                                           width:
                      //                                               double.infinity,
                      //                                           fit: BoxFit.contain,
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(height: 10),
                      //                                   Text(
                      //                                     categories[i].name ?? "",
                      //                                     textAlign:
                      //                                         TextAlign.center,
                      //                                     style: const TextStyle(
                      //                                       fontSize: 14,
                      //                                       fontWeight:
                      //                                           FontWeight.w600,
                      //                                       color: Color(
                      //                                         0xFF222222,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //       isTablet
                      //           ? Wrap(
                      //             crossAxisAlignment: WrapCrossAlignment.start,
                      //             spacing: 20,
                      //             runSpacing: 20,
                      //             children: [
                      //               Expanded(
                      //                 child: SizedBox(
                      //                   // height: 150,
                      //                   // width: 130,
                      //                   //   color: redColor,
                      //                   child: Row(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     spacing: 20,
                      //                     children: [
                      //                       if (categories.isNotEmpty)
                      //                         for (int i = 3; i < 6; i++)
                      //                           Expanded(
                      //                             child: InkWell(
                      //                               onTap: () {
                      //                                 title =
                      //                                     categories[i].name ?? "";
                      //                                 id = categories[i].id ?? "";
                      //                                 isMainCategory = false;
                      //                                 mainCatId = "";
                      //                                 isCategory = true;
                      //                                 catId =
                      //                                     categories[i].id ?? "";
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(
                      //                                     builder:
                      //                                         (
                      //                                           context,
                      //                                         ) => ProductListMenuScreen(
                      //                                           title:
                      //                                               categories[i]
                      //                                                   .name ??
                      //                                               "",
                      //                                           id:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                           isMainCategory:
                      //                                               false,
                      //                                           mainCatId: "",
                      //                                           isCategory: true,
                      //                                           catId:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                         ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                               child: Column(
                      //                                 children: [
                      //                                   Container(
                      //                                     height: 130,
                      //                                     // width: 130,
                      //                                     decoration: BoxDecoration(
                      //                                       color: const Color(
                      //                                         0xFFE5EEC3,
                      //                                       ),
                      //                                       borderRadius:
                      //                                           BorderRadius.circular(
                      //                                             5,
                      //                                           ),
                      //                                       boxShadow: [
                      //                                         BoxShadow(
                      //                                           color: greyColor,
                      //                                           blurRadius: 3,
                      //                                           offset:
                      //                                               const Offset(
                      //                                                 0,
                      //                                                 1,
                      //                                               ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                     child: Column(
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         ImageNetworkWidget(
                      //                                           url:
                      //                                               categories[i]
                      //                                                   .imageUrl ??
                      //                                               "",
                      //                                           height: 100,
                      //                                           width:
                      //                                               double.infinity,
                      //                                           fit: BoxFit.contain,
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(height: 10),
                      //                                   Text(
                      //                                     categories[i].name ?? "",
                      //                                     textAlign:
                      //                                         TextAlign.center,
                      //                                     style: const TextStyle(
                      //                                       fontSize: 14,
                      //                                       fontWeight:
                      //                                           FontWeight.w600,
                      //                                       color: Color(
                      //                                         0xFF222222,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: SizedBox(
                      //                   // height: 150,
                      //                   // width: 130,
                      //                   //   color: redColor,
                      //                   child: Row(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     spacing: 20,
                      //                     children: [
                      //                       if (categories.isNotEmpty)
                      //                         for (
                      //                           int i = 6;
                      //                           i < categories.length;
                      //                           i++
                      //                         )
                      //                           Expanded(
                      //                             child: InkWell(
                      //                               onTap: () {
                      //                                 title =
                      //                                     categories[i].name ?? "";
                      //                                 id = categories[i].id ?? "";
                      //                                 isMainCategory = false;
                      //                                 mainCatId = "";
                      //                                 isCategory = true;
                      //                                 catId =
                      //                                     categories[i].id ?? "";
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(
                      //                                     builder:
                      //                                         (
                      //                                           context,
                      //                                         ) => ProductListMenuScreen(
                      //                                           title:
                      //                                               categories[i]
                      //                                                   .name ??
                      //                                               "",
                      //                                           id:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                           isMainCategory:
                      //                                               false,
                      //                                           mainCatId: "",
                      //                                           isCategory: true,
                      //                                           catId:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                         ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                               child: Column(
                      //                                 children: [
                      //                                   Container(
                      //                                     height: 130,
                      //                                     // width: 130,
                      //                                     decoration: BoxDecoration(
                      //                                       color: const Color(
                      //                                         0xFFE5EEC3,
                      //                                       ),
                      //                                       borderRadius:
                      //                                           BorderRadius.circular(
                      //                                             5,
                      //                                           ),
                      //                                       boxShadow: [
                      //                                         BoxShadow(
                      //                                           color: greyColor,
                      //                                           blurRadius: 3,
                      //                                           offset:
                      //                                               const Offset(
                      //                                                 0,
                      //                                                 1,
                      //                                               ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                     child: Column(
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         ImageNetworkWidget(
                      //                                           url:
                      //                                               categories[i]
                      //                                                   .imageUrl ??
                      //                                               "",
                      //                                           height: 100,
                      //                                           width:
                      //                                               double.infinity,
                      //                                           fit: BoxFit.contain,
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(height: 10),
                      //                                   Text(
                      //                                     categories[i].name ?? "",
                      //                                     textAlign:
                      //                                         TextAlign.center,
                      //                                     style: const TextStyle(
                      //                                       fontSize: 14,
                      //                                       fontWeight:
                      //                                           FontWeight.w600,
                      //                                       color: Color(
                      //                                         0xFF222222,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           )
                      //           : Row(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             spacing: 20,
                      //             children: [
                      //               Expanded(
                      //                 child: SizedBox(
                      //                   // height: 150,
                      //                   width: 130,
                      //                   //   color: redColor,
                      //                   child: Row(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     spacing: 20,
                      //                     children: [
                      //                       if (categories.isNotEmpty)
                      //                         for (int i = 3; i < 6; i++)
                      //                           Expanded(
                      //                             child: InkWell(
                      //                               onTap: () {
                      //                                 title =
                      //                                     categories[i].name ?? "";
                      //                                 id = categories[i].id ?? "";
                      //                                 isMainCategory = false;
                      //                                 mainCatId = "";
                      //                                 isCategory = true;
                      //                                 catId =
                      //                                     categories[i].id ?? "";
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(
                      //                                     builder:
                      //                                         (
                      //                                           context,
                      //                                         ) => ProductListMenuScreen(
                      //                                           title:
                      //                                               categories[i]
                      //                                                   .name ??
                      //                                               "",
                      //                                           id:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                           isMainCategory:
                      //                                               false,
                      //                                           mainCatId: "",
                      //                                           isCategory: true,
                      //                                           catId:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                         ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                               child: Column(
                      //                                 children: [
                      //                                   Container(
                      //                                     height: 130,
                      //                                     // width: 130,
                      //                                     decoration: BoxDecoration(
                      //                                       color: const Color(
                      //                                         0xFFE5EEC3,
                      //                                       ),
                      //                                       borderRadius:
                      //                                           BorderRadius.circular(
                      //                                             5,
                      //                                           ),
                      //                                       boxShadow: [
                      //                                         BoxShadow(
                      //                                           color: greyColor,
                      //                                           blurRadius: 3,
                      //                                           offset:
                      //                                               const Offset(
                      //                                                 0,
                      //                                                 1,
                      //                                               ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                     child: Column(
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         ImageNetworkWidget(
                      //                                           url:
                      //                                               categories[i]
                      //                                                   .imageUrl ??
                      //                                               "",
                      //                                           height: 100,
                      //                                           width:
                      //                                               double.infinity,
                      //                                           fit: BoxFit.contain,
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(height: 10),
                      //                                   Text(
                      //                                     categories[i].name ?? "",
                      //                                     textAlign:
                      //                                         TextAlign.center,
                      //                                     style: const TextStyle(
                      //                                       fontSize: 14,
                      //                                       fontWeight:
                      //                                           FontWeight.w600,
                      //                                       color: Color(
                      //                                         0xFF222222,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: SizedBox(
                      //                   // height: 150,
                      //                   width: 130,
                      //                   //   color: redColor,
                      //                   child: Row(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     spacing: 20,
                      //                     children: [
                      //                       if (categories.isNotEmpty)
                      //                         for (
                      //                           int i = 6;
                      //                           i < categories.length;
                      //                           i++
                      //                         )
                      //                           Expanded(
                      //                             child: InkWell(
                      //                               onTap: () {
                      //                                 title =
                      //                                     categories[i].name ?? "";
                      //                                 id = categories[i].id ?? "";
                      //                                 isMainCategory = false;
                      //                                 mainCatId = "";
                      //                                 isCategory = true;
                      //                                 catId =
                      //                                     categories[i].id ?? "";
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(
                      //                                     builder:
                      //                                         (
                      //                                           context,
                      //                                         ) => ProductListMenuScreen(
                      //                                           title:
                      //                                               categories[i]
                      //                                                   .name ??
                      //                                               "",
                      //                                           id:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                           isMainCategory:
                      //                                               false,
                      //                                           mainCatId: "",
                      //                                           isCategory: true,
                      //                                           catId:
                      //                                               categories[i]
                      //                                                   .id ??
                      //                                               "",
                      //                                         ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                               child: Column(
                      //                                 children: [
                      //                                   Container(
                      //                                     height: 130,
                      //                                     // width: 130,
                      //                                     decoration: BoxDecoration(
                      //                                       color: const Color(
                      //                                         0xFFE5EEC3,
                      //                                       ),
                      //                                       borderRadius:
                      //                                           BorderRadius.circular(
                      //                                             5,
                      //                                           ),
                      //                                       boxShadow: [
                      //                                         BoxShadow(
                      //                                           color: greyColor,
                      //                                           blurRadius: 3,
                      //                                           offset:
                      //                                               const Offset(
                      //                                                 0,
                      //                                                 1,
                      //                                               ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                     child: Column(
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         ImageNetworkWidget(
                      //                                           url:
                      //                                               categories[i]
                      //                                                   .imageUrl ??
                      //                                               "",
                      //                                           height: 100,
                      //                                           width:
                      //                                               double.infinity,
                      //                                           fit: BoxFit.contain,
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(height: 10),
                      //                                   Text(
                      //                                     categories[i].name ?? "",
                      //                                     textAlign:
                      //                                         TextAlign.center,
                      //                                     style: const TextStyle(
                      //                                       fontSize: 14,
                      //                                       fontWeight:
                      //                                           FontWeight.w600,
                      //                                       color: Color(
                      //                                         0xFF222222,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 150,
                        ),
                        child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Explore by Categories',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: blackColor,
                                  ),
                                ),
                                // if (mainCategory.data != null)
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) {
                                //           return CategoriesScreen();
                                //         },
                                //       ),
                                //     );
                                //   },
                                //   child: Row(
                                //     children: [
                                //       Text(
                                //         'See All',
                                //         style: GoogleFonts.poppins(
                                //           fontSize: 13,
                                //           fontWeight: FontWeight.w600,
                                //           color: appColor,
                                //         ),
                                //       ),
                                //       const SizedBox(width: 6),
                                //       Icon(
                                //         Icons.arrow_forward_ios_rounded,
                                //         size: 14,
                                //         color: appColor,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            isTablet
                                ? Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    SizedBox(
                                      // height: 150,
                                      // width: 130,
                                      //  color: redColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 16,
                                        children: [
                                          if (mainCategory.data != null)
                                            for (
                                              int i = 0;
                                              i < mainCategory.data!.length;
                                              i++
                                            )
                                              Expanded(
                                                child: InkWell(
                                                  hoverColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    title =
                                                        mainCategory
                                                            .data![i]
                                                            .name ??
                                                        "";
                                                    id =
                                                        mainCategory
                                                            .data![i]
                                                            .id ??
                                                        "";
                                                    isMainCategory = true;
                                                    mainCatId =
                                                        mainCategory
                                                            .data![i]
                                                            .id ??
                                                        "";
                                                    isCategory = false;
                                                    catId = "";
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => ProductListMainScreen(
                                                              title:
                                                                  mainCategory
                                                                      .data![i]
                                                                      .name ??
                                                                  "",
                                                              id:
                                                                  mainCategory
                                                                      .data![i]
                                                                      .id ??
                                                                  "",
                                                              isMainCategory:
                                                                  true,
                                                              mainCatId:
                                                                  mainCategory
                                                                      .data![i]
                                                                      .id ??
                                                                  "",
                                                              isCategory: false,
                                                              catId: "",
                                                            ),
                                                      ),
                                                    ).then((value) {
                                                      // if (!context
                                                      //     .mounted) {
                                                      //   return;
                                                      // }
                                                      // context
                                                      //     .read<
                                                      //       HomeBloc
                                                      //     >()
                                                      //     .add(
                                                      //       GetCartCountEvent(
                                                      //         userId:
                                                      //             userId,
                                                      //       ),
                                                      //     );
                                                      // // context
                                                      // //     .read<CounterCubit>()
                                                      // //     .decrement(cartCount);
                                                      // context
                                                      //     .read<
                                                      //       CounterCubit
                                                      //     >()
                                                      //     .increment(
                                                      //       cartCount,
                                                      //     );
                                                      // noOfIteminCart =
                                                      //     cartCount;
                                                    });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Container(
                                                        height: 130,
                                                        width: null,
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFFE5EEC3,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: greyColor,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                    0,
                                                                    1,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ImageNetworkWidget(
                                                              url:
                                                                  mainCategory
                                                                      .data![i]
                                                                      .imageUrl ??
                                                                  "",
                                                              height: 100,
                                                              width:
                                                                  double
                                                                      .infinity,
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        mainCategory
                                                                .data![i]
                                                                .name ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                            0xFF222222,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      // height: 150,
                                      // width: 130,
                                      // color: redColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 20,
                                        children: [
                                          if (categories.isNotEmpty)
                                            for (
                                              int i = 0;
                                              i <
                                                  (categories.length > 3
                                                      ? 3
                                                      : categories.length);
                                              i++
                                            )
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    debugPrint(
                                                      categories[i].name ?? "",
                                                    );
                                                    title =
                                                        categories[i].name ??
                                                        "";
                                                    id = categories[i].id ?? "";
                                                    isMainCategory = false;
                                                    mainCatId = "";
                                                    isCategory = true;
                                                    catId =
                                                        categories[i].id ?? "";
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => ProductListMainScreen(
                                                              title:
                                                                  categories[i]
                                                                      .name ??
                                                                  "",
                                                              id:
                                                                  categories[i]
                                                                      .id ??
                                                                  "",
                                                              isMainCategory:
                                                                  false,
                                                              mainCatId: "",
                                                              isCategory: true,
                                                              catId:
                                                                  categories[i]
                                                                      .id ??
                                                                  "",
                                                            ),
                                                      ),
                                                    ).then((value) {
                                                      // if (!context
                                                      //     .mounted) {
                                                      //   return;
                                                      // }
                                                      // context
                                                      //     .read<
                                                      //       HomeBloc
                                                      //     >()
                                                      //     .add(
                                                      //       GetCartCountEvent(
                                                      //         userId:
                                                      //             userId,
                                                      //       ),
                                                      //     );
                                                      // // context
                                                      // //     .read<CounterCubit>()
                                                      // //     .decrement(cartCount);
                                                      // context
                                                      //     .read<
                                                      //       CounterCubit
                                                      //     >()
                                                      //     .increment(
                                                      //       cartCount,
                                                      //     );
                                                      // noOfIteminCart =
                                                      //     cartCount;
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 130,
                                                        width: null,
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFFE5EEC3,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: greyColor,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                    0,
                                                                    1,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ImageNetworkWidget(
                                                              url:
                                                                  categories[i]
                                                                      .imageUrl ??
                                                                  "",
                                                              height: 100,
                                                              width:
                                                                  double
                                                                      .infinity,
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        categories[i].name ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                            0xFF222222,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 20,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        // height: 150,
                                        // width: 130,
                                        //  color: redColor,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 16,
                                          children: [
                                            if (mainCategory.data != null)
                                              for (
                                                int i = 0;
                                                i < mainCategory.data!.length;
                                                i++
                                              )
                                                Expanded(
                                                  child: InkWell(
                                                    hoverColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      debugPrint("0000000000");
                                                      title =
                                                          mainCategory
                                                              .data![i]
                                                              .name ??
                                                          "";
                                                      id =
                                                          mainCategory
                                                              .data![i]
                                                              .id ??
                                                          "";
                                                      isMainCategory = true;
                                                      mainCatId =
                                                          mainCategory
                                                              .data![i]
                                                              .id ??
                                                          "";
                                                      isCategory = false;
                                                      catId = "";
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                context,
                                                              ) => ProductListMainScreen(
                                                                title:
                                                                    mainCategory
                                                                        .data![i]
                                                                        .name ??
                                                                    "",
                                                                id:
                                                                    mainCategory
                                                                        .data![i]
                                                                        .id ??
                                                                    "",
                                                                isMainCategory:
                                                                    true,
                                                                mainCatId:
                                                                    mainCategory
                                                                        .data![i]
                                                                        .id ??
                                                                    "",
                                                                isCategory:
                                                                    false,
                                                                catId: "",
                                                              ),
                                                        ),
                                                      ).then((value) {
                                                        // if (!context
                                                        //     .mounted) {
                                                        //   return;
                                                        // }
                                                        // context
                                                        //     .read<
                                                        //       HomeBloc
                                                        //     >()
                                                        //     .add(
                                                        //       GetCartCountEvent(
                                                        //         userId:
                                                        //             userId,
                                                        //       ),
                                                        //     );
                                                        // // context
                                                        // //     .read<CounterCubit>()
                                                        // //     .decrement(cartCount);
                                                        // context
                                                        //     .read<
                                                        //       CounterCubit
                                                        //     >()
                                                        //     .increment(
                                                        //       cartCount,
                                                        //     );
                                                        // noOfIteminCart =
                                                        //     cartCount;
                                                      });
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Container(
                                                          height: 130,
                                                          width: null,
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFE5EEC3,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    greyColor,
                                                                blurRadius: 3,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      1,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ImageNetworkWidget(
                                                                url:
                                                                    mainCategory
                                                                        .data![i]
                                                                        .imageUrl ??
                                                                    "",
                                                                height: 100,
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          mainCategory
                                                                  .data![i]
                                                                  .name ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                              0xFF222222,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // height: 150,
                                        // width: 130,
                                        // color: redColor,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 20,
                                          children: [
                                            if (categories.isNotEmpty)
                                              for (int i = 0; i < 3; i++)
                                                Expanded(
                                                  child: InkWell(
                                                    hoverColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      debugPrint(
                                                        categories[i].name ??
                                                            "",
                                                      );
                                                      title =
                                                          categories[i].name ??
                                                          "";
                                                      id =
                                                          categories[i].id ??
                                                          "";
                                                      isMainCategory = false;
                                                      mainCatId = "";
                                                      isCategory = true;
                                                      catId =
                                                          categories[i].id ??
                                                          "";
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                context,
                                                              ) => ProductListMainScreen(
                                                                title:
                                                                    categories[i]
                                                                        .name ??
                                                                    "",
                                                                id:
                                                                    categories[i]
                                                                        .id ??
                                                                    "",
                                                                isMainCategory:
                                                                    false,
                                                                mainCatId: "",
                                                                isCategory:
                                                                    true,
                                                                catId:
                                                                    categories[i]
                                                                        .id ??
                                                                    "",
                                                              ),
                                                        ),
                                                      ).then((value) {
                                                        // if (!context
                                                        //     .mounted) {
                                                        //   return;
                                                        // }
                                                        // context
                                                        //     .read<
                                                        //       HomeBloc
                                                        //     >()
                                                        //     .add(
                                                        //       GetCartCountEvent(
                                                        //         userId:
                                                        //             userId,
                                                        //       ),
                                                        //     );
                                                        // // context
                                                        // //     .read<CounterCubit>()
                                                        // //     .decrement(cartCount);
                                                        // context
                                                        //     .read<
                                                        //       CounterCubit
                                                        //     >()
                                                        //     .increment(
                                                        //       cartCount,
                                                        //     );
                                                        // noOfIteminCart =
                                                        //     cartCount;
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 130,
                                                          width: null,
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFE5EEC3,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    greyColor,
                                                                blurRadius: 3,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      1,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ImageNetworkWidget(
                                                                url:
                                                                    categories[i]
                                                                        .imageUrl ??
                                                                    "",
                                                                height: 100,
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          categories[i].name ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                  0xFF222222,
                                                                ),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            isTablet
                                ? Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    SizedBox(
                                      // height: 150,
                                      // width: 130,
                                      //   color: redColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 20,
                                        children: [
                                          if (categories.isNotEmpty)
                                            for (int i = 3; i < 6; i++)
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    debugPrint(
                                                      categories[i].name ?? "",
                                                    );
                                                    title =
                                                        categories[i].name ??
                                                        "";
                                                    id = categories[i].id ?? "";
                                                    isMainCategory = false;
                                                    mainCatId = "";
                                                    isCategory = true;
                                                    catId =
                                                        categories[i].id ?? "";
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => ProductListMainScreen(
                                                              title:
                                                                  categories[i]
                                                                      .name ??
                                                                  "",
                                                              id:
                                                                  categories[i]
                                                                      .id ??
                                                                  "",
                                                              isMainCategory:
                                                                  false,
                                                              mainCatId: "",
                                                              isCategory: true,
                                                              catId:
                                                                  categories[i]
                                                                      .id ??
                                                                  "",
                                                            ),
                                                      ),
                                                    ).then((value) {
                                                      // if (!context
                                                      //     .mounted) {
                                                      //   return;
                                                      // }
                                                      // context
                                                      //     .read<
                                                      //       HomeBloc
                                                      //     >()
                                                      //     .add(
                                                      //       GetCartCountEvent(
                                                      //         userId:
                                                      //             userId,
                                                      //       ),
                                                      //     );
                                                      // // context
                                                      // //     .read<CounterCubit>()
                                                      // //     .decrement(cartCount);
                                                      // context
                                                      //     .read<
                                                      //       CounterCubit
                                                      //     >()
                                                      //     .increment(
                                                      //       cartCount,
                                                      //     );
                                                      // noOfIteminCart =
                                                      //     cartCount;
                                                    });
                                                  },
                                                  hoverColor:
                                                      Colors.transparent,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 130,
                                                        // width: 130,
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFFE5EEC3,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: greyColor,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                    0,
                                                                    1,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ImageNetworkWidget(
                                                              url:
                                                                  categories[i]
                                                                      .imageUrl ??
                                                                  "",
                                                              height: 100,
                                                              width:
                                                                  double
                                                                      .infinity,
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        categories[i].name ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                            0xFF222222,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      // height: 150,
                                      // width: 130,
                                      //   color: redColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 20,
                                        children: [
                                          if (categories.isNotEmpty)
                                            for (
                                              int i = 6;
                                              i < categories.length;
                                              i++
                                            )
                                              Expanded(
                                                child: InkWell(
                                                  hoverColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    debugPrint(
                                                      categories[i].name ?? "",
                                                    );
                                                    title =
                                                        categories[i].name ??
                                                        "";
                                                    id = categories[i].id ?? "";
                                                    isMainCategory = false;
                                                    mainCatId = "";
                                                    isCategory = true;
                                                    catId =
                                                        categories[i].id ?? "";
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => ProductListMainScreen(
                                                              title:
                                                                  categories[i]
                                                                      .name ??
                                                                  "",
                                                              id:
                                                                  categories[i]
                                                                      .id ??
                                                                  "",
                                                              isMainCategory:
                                                                  false,
                                                              mainCatId: "",
                                                              isCategory: true,
                                                              catId:
                                                                  categories[i]
                                                                      .id ??
                                                                  "",
                                                            ),
                                                      ),
                                                    ).then((value) {
                                                      // if (!context
                                                      //     .mounted) {
                                                      //   return;
                                                      // }
                                                      // context
                                                      //     .read<
                                                      //       HomeBloc
                                                      //     >()
                                                      //     .add(
                                                      //       GetCartCountEvent(
                                                      //         userId:
                                                      //             userId,
                                                      //       ),
                                                      //     );
                                                      // // context
                                                      // //     .read<CounterCubit>()
                                                      // //     .decrement(cartCount);
                                                      // context
                                                      //     .read<
                                                      //       CounterCubit
                                                      //     >()
                                                      //     .increment(
                                                      //       cartCount,
                                                      //     );
                                                      // noOfIteminCart =
                                                      //     cartCount;
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 130,
                                                        // width: 130,
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFFE5EEC3,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: greyColor,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                    0,
                                                                    1,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ImageNetworkWidget(
                                                              url:
                                                                  categories[i]
                                                                      .imageUrl ??
                                                                  "",
                                                              height: 100,
                                                              width:
                                                                  double
                                                                      .infinity,
                                                              fit:
                                                                  BoxFit
                                                                      .contain,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        categories[i].name ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                            0xFF222222,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 20,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        // height: 150,
                                        width: 130,
                                        //   color: redColor,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 20,
                                          children: [
                                            if (categories.isNotEmpty)
                                              for (int i = 3; i < 6; i++)
                                                Expanded(
                                                  child: InkWell(
                                                    hoverColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      debugPrint(
                                                        categories[i].name ??
                                                            "",
                                                      );
                                                      title =
                                                          categories[i].name ??
                                                          "";
                                                      id =
                                                          categories[i].id ??
                                                          "";
                                                      isMainCategory = false;
                                                      mainCatId = "";
                                                      isCategory = true;
                                                      catId =
                                                          categories[i].id ??
                                                          "";
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                context,
                                                              ) => ProductListMainScreen(
                                                                title:
                                                                    categories[i]
                                                                        .name ??
                                                                    "",
                                                                id:
                                                                    categories[i]
                                                                        .id ??
                                                                    "",
                                                                isMainCategory:
                                                                    false,
                                                                mainCatId: "",
                                                                isCategory:
                                                                    true,
                                                                catId:
                                                                    categories[i]
                                                                        .id ??
                                                                    "",
                                                              ),
                                                        ),
                                                      ).then((value) {
                                                        // if (!context
                                                        //     .mounted) {
                                                        //   return;
                                                        // }
                                                        // context
                                                        //     .read<
                                                        //       HomeBloc
                                                        //     >()
                                                        //     .add(
                                                        //       GetCartCountEvent(
                                                        //         userId:
                                                        //             userId,
                                                        //       ),
                                                        //     );
                                                        // // context
                                                        // //     .read<CounterCubit>()
                                                        // //     .decrement(cartCount);
                                                        // context
                                                        //     .read<
                                                        //       CounterCubit
                                                        //     >()
                                                        //     .increment(
                                                        //       cartCount,
                                                        //     );
                                                        // noOfIteminCart =
                                                        //     cartCount;
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 130,
                                                          // width: 130,
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFE5EEC3,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    greyColor,
                                                                blurRadius: 3,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      1,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ImageNetworkWidget(
                                                                url:
                                                                    categories[i]
                                                                        .imageUrl ??
                                                                    "",
                                                                height: 100,
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          categories[i].name ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                  0xFF222222,
                                                                ),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // height: 150,
                                        width: 130,
                                        //   color: redColor,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 20,
                                          children: [
                                            if (categories.isNotEmpty)
                                              for (
                                                int i = 6;
                                                i < categories.length;
                                                i++
                                              )
                                                Expanded(
                                                  child: InkWell(
                                                    hoverColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      title =
                                                          categories[i].name ??
                                                          "";
                                                      id =
                                                          categories[i].id ??
                                                          "";
                                                      isMainCategory = false;
                                                      mainCatId = "";
                                                      isCategory = true;
                                                      catId =
                                                          categories[i].id ??
                                                          "";
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                context,
                                                              ) => ProductListMainScreen(
                                                                title:
                                                                    categories[i]
                                                                        .name ??
                                                                    "",
                                                                id:
                                                                    categories[i]
                                                                        .id ??
                                                                    "",
                                                                isMainCategory:
                                                                    false,
                                                                mainCatId: "",
                                                                isCategory:
                                                                    true,
                                                                catId:
                                                                    categories[i]
                                                                        .id ??
                                                                    "",
                                                              ),
                                                        ),
                                                      ).then((value) {
                                                        // if (!context
                                                        //     .mounted) {
                                                        //   return;
                                                        // }
                                                        // context
                                                        //     .read<
                                                        //       HomeBloc
                                                        //     >()
                                                        //     .add(
                                                        //       GetCartCountEvent(
                                                        //         userId:
                                                        //             userId,
                                                        //       ),
                                                        //     );
                                                        // // context
                                                        // //     .read<CounterCubit>()
                                                        // //     .decrement(cartCount);
                                                        // context
                                                        //     .read<
                                                        //       CounterCubit
                                                        //     >()
                                                        //     .increment(
                                                        //       cartCount,
                                                        //     );
                                                        // noOfIteminCart =
                                                        //     cartCount;
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 130,
                                                          // width: 130,
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFE5EEC3,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    greyColor,
                                                                blurRadius: 3,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      1,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ImageNetworkWidget(
                                                                url:
                                                                    categories[i]
                                                                        .imageUrl ??
                                                                    "",
                                                                height: 100,
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          categories[i].name ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                  0xFF222222,
                                                                ),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      BottomImageWidget(),
                      BottomCategoriesBarWidget(),
                      BottomAppBarWidget(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
