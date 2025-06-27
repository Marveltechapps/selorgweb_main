import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/model/banner/banner_product_response_model.dart';
import 'package:selorgweb_main/presentation/banner/banner_bloc.dart';
import 'package:selorgweb_main/presentation/banner/banner_event.dart';
import 'package:selorgweb_main/presentation/banner/banner_state.dart';
import 'package:selorgweb_main/presentation/banner/banner_state.dart'
    as bannerst;
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_state.dart';
// import 'package:selorgweb_main/presentation/search/search_screen.dart';
import 'package:selorgweb_main/utils/widgets/bottom_app_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_categories_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_image_widget.dart';
import 'package:selorgweb_main/utils/widgets/header_widget.dart';
// import 'package:selorgweb_main/presentation/search/search_screen.dart';
import 'package:selorgweb_main/utils/widgets/network_image.dart';
import 'package:selorgweb_main/presentation/home/home_bloc.dart';
import 'package:selorgweb_main/presentation/home/home_event.dart' as he;
import 'package:selorgweb_main/presentation/home/home_state.dart' as hs;
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/model/cart/cart_model.dart' as cart;

class BannerScreen extends StatelessWidget {
  final String bannerId;
  const BannerScreen({super.key, required this.bannerId});

  static BannerProductResponse bannerProductResponse = BannerProductResponse();
  static String errorMsg = "";
  static int varientIndex = 0;
  static int cartCount = 0;
  static int totalAmount = 0;
  static int selectedProductIndex = 0;

  static cart.CartResponse cartResponse = cart.CartResponse();

  void showVarientsDialog(
    BuildContext context,
    String name,
    int productIndex,
    BannerBloc bannerBloc,
  ) {
    showDialog(
      context: context,
      barrierDismissible: !(location == "No Location Found"),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 500, maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: BlocProvider.value(
                  value: bannerBloc,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return BlocBuilder<BannerBloc, BannerState>(
                        builder: (context, state) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                spacing: 20,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        name,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                      ),
                                      InkWell(
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
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                bannerProductResponse
                                                    .data![productIndex]
                                                    .variants!
                                                    .length,
                                            itemBuilder: (context, i) {
                                              return InkWell(
                                                onTap: () {
                                                  context
                                                      .read<BannerBloc>()
                                                      .add(
                                                        ChangeVarientItemEvent(
                                                          productIndex:
                                                              productIndex,
                                                          varientIndex: i,
                                                        ),
                                                      );
                                                  // Navigator.pop(context);
                                                  // context.read<BannerBloc>().add(
                                                  //     LabelVarientItemEvent(
                                                  //         productIndex: 0, varientIndex: i));
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                      ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 10,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: whitecolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          3,
                                                        ),
                                                    border: Border.all(
                                                      color: appColor.withAlpha(
                                                        (255 * 0.8).toInt(),
                                                      ),
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            bannerProductResponse
                                                                    .data![productIndex]
                                                                    .variants![i]
                                                                    .label ??
                                                                "",
                                                            style:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodySmall,
                                                          ),
                                                          Row(
                                                            children: [
                                                              RichText(
                                                                text: TextSpan(
                                                                  text: '₹ ',
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        Colors
                                                                            .black,
                                                                  ),
                                                                  children: <
                                                                    TextSpan
                                                                  >[
                                                                    TextSpan(
                                                                      text:
                                                                          bannerProductResponse
                                                                              .data![productIndex]
                                                                              .variants![i]
                                                                              .discountPrice
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                            '`Poppins`',
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                  text: '₹ ',
                                                                  style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        Colors
                                                                            .grey,
                                                                  ),
                                                                  children: <
                                                                    TextSpan
                                                                  >[
                                                                    TextSpan(
                                                                      text:
                                                                          bannerProductResponse
                                                                              .data![productIndex]
                                                                              .variants![i]
                                                                              .price
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration.lineThrough,
                                                                        fontSize:
                                                                            12,
                                                                        color:
                                                                            Colors.grey,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      bannerProductResponse
                                                                  .data![productIndex]
                                                                  .variants![i]
                                                                  .cartQuantity ==
                                                              0
                                                          ? SizedBox(
                                                            width: 100,
                                                            height: 30,
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    whitecolor,
                                                                shape: RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                    color:
                                                                        appColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        20,
                                                                      ),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                context.read<BannerBloc>().add(
                                                                  AddButtonPressedEvent(
                                                                    type:
                                                                        "dialog",
                                                                    index:
                                                                        productIndex,
                                                                    varientindex:
                                                                        i,
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                "Add",
                                                                style: GoogleFonts.poppins(
                                                                  color:
                                                                      appColor,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          : Container(
                                                            width: 100,
                                                            height: 30,
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 1,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color: appColor,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    20,
                                                                  ),
                                                              border: Border.all(
                                                                color: appColor,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      context
                                                                          .read<
                                                                            BannerBloc
                                                                          >()
                                                                          .add(
                                                                            RemoveButtonPressedEvent(
                                                                              type:
                                                                                  "dialog",
                                                                              index:
                                                                                  productIndex,
                                                                              varientindex:
                                                                                  i,
                                                                            ),
                                                                          );
                                                                    },
                                                                    child: SizedBox(
                                                                      height:
                                                                          30,
                                                                      child: const Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color:
                                                                            Colors.white,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 35,
                                                                  width: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      bannerProductResponse
                                                                          .data![productIndex]
                                                                          .variants![i]
                                                                          .cartQuantity
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.poppins(
                                                                        color:
                                                                            appColor,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      context
                                                                          .read<
                                                                            BannerBloc
                                                                          >()
                                                                          .add(
                                                                            AddButtonPressedEvent(
                                                                              type:
                                                                                  "dialog",
                                                                              index:
                                                                                  productIndex,
                                                                              varientindex:
                                                                                  i,
                                                                            ),
                                                                          );
                                                                    },
                                                                    child: SizedBox(
                                                                      height:
                                                                          30,
                                                                      child: Center(
                                                                        child: const Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
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
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BannerBloc()),
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
          return BlocConsumer<BannerBloc, BannerState>(
            listener: (context, state) {
              if (state is PraductSuccessState) {
                bannerProductResponse = state.bannerProductResponse;
              } else if (state is bannerst.VarientChangedState) {
                varientIndex = state.varientIndex;
                selectedProductIndex = state.productIndex;
              } else if (state is CartUpdateLocal) {
                context.read<CounterCubit>().increment(state.noOfItems);
              } else if (state is AddButtonPressedState) {
                if (state.type == "screen") {
                  bannerProductResponse
                      .data![state.index]
                      .variants![0]
                      .cartQuantity = (bannerProductResponse
                          .data![state.index]
                          .variants![0]
                          .cartQuantity!) +
                      1;
                  context.read<BannerBloc>().add(
                    AddItemApiEvent(
                      skuName:
                          bannerProductResponse.data![state.index].skuName ??
                          "",
                      userId: userId,
                      productId:
                          bannerProductResponse.data![state.index].productId ??
                          "",
                      quantity: 1,
                      variantLabel:
                          bannerProductResponse
                              .data![state.index]
                              .variants![varientIndex]
                              .label ??
                          "",
                      imageUrl:
                          bannerProductResponse
                              .data![state.index]
                              .variants![varientIndex]
                              .imageUrl ??
                          "",
                      price:
                          bannerProductResponse
                              .data![state.index]
                              .variants![varientIndex]
                              .price ??
                          0,
                      discountPrice:
                          bannerProductResponse
                              .data![state.index]
                              .variants![varientIndex]
                              .discountPrice ??
                          0,
                      deliveryInstructions: "",
                      addNotes: "",
                    ),
                  );
                } else if (state.type == "dialog") {
                  bannerProductResponse
                      .data![state.index]
                      .variants![state.varientindex]
                      .cartQuantity = (bannerProductResponse
                          .data![state.index]
                          .variants![state.varientindex]
                          .cartQuantity!) +
                      1;
                  context.read<BannerBloc>().add(
                    AddItemApiEvent(
                      skuName:
                          bannerProductResponse.data![state.index].skuName ??
                          "",
                      userId: userId,
                      productId:
                          bannerProductResponse.data![state.index].productId ??
                          "",
                      quantity: 1,
                      variantLabel:
                          bannerProductResponse
                              .data![state.index]
                              .variants![state.varientindex]
                              .label ??
                          "",
                      imageUrl:
                          bannerProductResponse
                              .data![state.index]
                              .variants![state.varientindex]
                              .imageUrl ??
                          "",
                      price:
                          bannerProductResponse
                              .data![state.index]
                              .variants![state.varientindex]
                              .price ??
                          0,
                      discountPrice:
                          bannerProductResponse
                              .data![state.index]
                              .variants![state.varientindex]
                              .discountPrice ??
                          0,
                      deliveryInstructions: "",
                      addNotes: "",
                    ),
                  );
                }
              } else if (state is AddedToCartState) {
                // context.read<ProductDetailBloc>().add(GetProductDetailEvent(
                //     mobileNo: phoneNumber, productId: productId));
                context.read<BannerBloc>().add(
                  GetCartCountLengthOnBannerEvent(userId: userId),
                );
              } else if (state is RemoveButtonPressedState) {
                if (state.type == "screen") {
                  bannerProductResponse
                      .data![state.index]
                      .variants![0]
                      .cartQuantity = (bannerProductResponse
                          .data![state.index]
                          .variants![0]
                          .cartQuantity!) -
                      1;
                  context.read<BannerBloc>().add(
                    RemoveItemApiEvent(
                      userId: userId,
                      productId:
                          bannerProductResponse.data![state.index].productId ??
                          "",
                      variantLabel:
                          bannerProductResponse
                              .data![state.index]
                              .variants![varientIndex]
                              .label ??
                          "",
                      quantity: 1,
                      deliveryTip: 0,
                      handlingcharges: 0,
                    ),
                  );
                } else if (state.type == "dialog") {
                  bannerProductResponse
                      .data![state.index]
                      .variants![state.varientindex]
                      .cartQuantity = (bannerProductResponse
                          .data![state.index]
                          .variants![state.varientindex]
                          .cartQuantity!) -
                      1;
                  context.read<BannerBloc>().add(
                    RemoveItemApiEvent(
                      userId: userId,
                      productId:
                          bannerProductResponse.data![state.index].productId ??
                          "",
                      variantLabel:
                          bannerProductResponse
                              .data![state.index]
                              .variants![state.varientindex]
                              .label ??
                          "",
                      quantity: 1,
                      deliveryTip: 0,
                      handlingcharges: 0,
                    ),
                  );
                }
              } else if (state is RemoveItemFromCartState) {
                // context.read<ProductDetailBloc>().add(GetProductDetailEvent(
                //     mobileNo: phoneNumber, productId: productId));
                context.read<BannerBloc>().add(
                  GetCartCountLengthOnBannerEvent(userId: userId),
                );
              } else if (state is ItemRemovedToCartState) {
                context.read<BannerBloc>().add(
                  GetCartCountLengthOnBannerEvent(userId: userId),
                );
              } else if (state is CartCountLengthOnBannerSuccessState) {
                // cartResponse = state.cartResponse;
                cartCount = state.countvalue;
                context.read<CounterCubit>().increment(cartCount);
                // totalAmount = state.cartResponse.billSummary!.itemTotal ?? 0;
              } else if (state is BannerErrorState) {
                errorMsg = state.errorMsg;
              }
            },
            builder: (context, state) {
              if (state is BannerInitialState) {
                bannerProductResponse.data = [];
                errorMsg = "";
                context.read<BannerBloc>().add(
                  GetProductDetailsEvent(bannerId: bannerId),
                );
                context.read<BannerBloc>().add(
                  GetCartCountLengthOnBannerEvent(userId: userId),
                );
              }
              return Scaffold(
                backgroundColor: appbackgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // double screenWidth = constraints.maxWidth;
                          double itemWidth = 200;
                          // screenWidth / 2 - 10; // Adjust for spacing
                          //  double itemHeight = itemWidth * 1.8;
                          return SingleChildScrollView(
                            child: Column(
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
                                SizedBox(height: 20),
                                bannerProductResponse.data!.isEmpty
                                    ? Center(
                                      child: Text(
                                        errorMsg,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                    : Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 1280,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              constraints.maxWidth < 991
                                                  ? 20
                                                  : 60,
                                        ),
                                        child: GridView.builder(
                                          // controller: _scrollController,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    constraints.maxWidth < 600
                                                        ? 3
                                                        : constraints.maxWidth <
                                                            991
                                                        ? 4
                                                        : 6,
                                                mainAxisSpacing: 20,
                                                crossAxisSpacing: 10,
                                                childAspectRatio: 0.65,
                                              ),
                                          itemCount:
                                              bannerProductResponse
                                                  .data!
                                                  .length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: itemWidth,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                spacing: 3,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        context.push(
                                                          Uri(
                                                            path:
                                                                '/productdetail',
                                                            queryParameters: {
                                                              'productId':
                                                                  bannerProductResponse
                                                                      .data![index]
                                                                      .productId ??
                                                                  "",
                                                              'screenType':
                                                                  'back',
                                                            },
                                                          ).toString(),
                                                        );
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    top: 12.0,
                                                                  ),
                                                              child: ImageNetworkWidget(
                                                                url:
                                                                    selectedProductIndex ==
                                                                            index
                                                                        ? bannerProductResponse.data![index].variants![varientIndex].imageUrl ??
                                                                            ""
                                                                        : bannerProductResponse.data![index].variants![0].imageUrl ??
                                                                            "",
                                                                fit:
                                                                    BoxFit
                                                                        .contain,
                                                                width:
                                                                    itemWidth, // Ensure the width is fixed
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical: 4,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                color: appColor,
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft:
                                                                      Radius.circular(
                                                                        20,
                                                                      ),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                        20,
                                                                      ),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                selectedProductIndex ==
                                                                        index
                                                                    ? bannerProductResponse
                                                                            .data![index]
                                                                            .variants![varientIndex]
                                                                            .offer ??
                                                                        ""
                                                                    : bannerProductResponse
                                                                            .data![index]
                                                                            .variants![0]
                                                                            .offer ??
                                                                        "",
                                                                style: const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          10,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          bannerProductResponse
                                                                  .data![index]
                                                                  .skuName ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                        ),
                                                        SizedBox(height: 6),
                                                        InkWell(
                                                          onTap: () {
                                                            showVarientsDialog(
                                                              context,
                                                              bannerProductResponse
                                                                      .data![index]
                                                                      .skuName ??
                                                                  "",
                                                              index,
                                                              context
                                                                  .read<
                                                                    BannerBloc
                                                                  >(),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 8,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: appColor
                                                                    .withAlpha(
                                                                      (255 * 0.4)
                                                                          .toInt(),
                                                                    ),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    4,
                                                                  ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    selectedProductIndex ==
                                                                            index
                                                                        ? bannerProductResponse.data![index].variants![varientIndex].label ??
                                                                            ""
                                                                        : bannerProductResponse.data![index].variants![0].label ??
                                                                            "",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  size: 15,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 6),
                                                        Row(
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                text: '₹ ',
                                                                style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                                children: <
                                                                  TextSpan
                                                                >[
                                                                  TextSpan(
                                                                    text:
                                                                        '${selectedProductIndex == index ? bannerProductResponse.data![index].variants![varientIndex].discountPrice ?? "" : bannerProductResponse.data![index].variants![0].discountPrice ?? ""}',
                                                                    style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(width: 6),
                                                            Text(
                                                              selectedProductIndex ==
                                                                      index
                                                                  ? bannerProductResponse
                                                                      .data![index]
                                                                      .variants![varientIndex]
                                                                      .price
                                                                      .toString()
                                                                  : bannerProductResponse
                                                                      .data![index]
                                                                      .variants![0]
                                                                      .price
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                  0xFF777777,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10.0,
                                                                    ),
                                                                child:
                                                                    (selectedProductIndex ==
                                                                                    index
                                                                                ? bannerProductResponse.data![index].variants![varientIndex].cartQuantity ??
                                                                                    0
                                                                                : bannerProductResponse.data![index].variants![0].cartQuantity ??
                                                                                    0) ==
                                                                            0
                                                                        ? InkWell(
                                                                          onTap: () {
                                                                            context
                                                                                .read<
                                                                                  BannerBloc
                                                                                >()
                                                                                .add(
                                                                                  ChangeVarientItemEvent(
                                                                                    productIndex:
                                                                                        index,
                                                                                    varientIndex:
                                                                                        selectedProductIndex ==
                                                                                                index
                                                                                            ? varientIndex
                                                                                            : 0,
                                                                                  ),
                                                                                );
                                                                            context
                                                                                .read<
                                                                                  BannerBloc
                                                                                >()
                                                                                .add(
                                                                                  AddButtonPressedEvent(
                                                                                    type:
                                                                                        "screen",
                                                                                    index:
                                                                                        index,
                                                                                    varientindex:
                                                                                        varientIndex,
                                                                                  ),
                                                                                );
                                                                          },
                                                                          child: Container(
                                                                            padding: const EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  1,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                              color:
                                                                                  whitecolor,
                                                                              borderRadius: BorderRadius.circular(
                                                                                20,
                                                                              ),
                                                                              border: Border.all(
                                                                                color:
                                                                                    appColor,
                                                                              ),
                                                                            ),
                                                                            height:
                                                                                27,
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  "Add",
                                                                                  textAlign:
                                                                                      TextAlign.center,
                                                                                  style: GoogleFonts.poppins(
                                                                                    color:
                                                                                        appColor,
                                                                                    fontSize:
                                                                                        12,
                                                                                    fontWeight:
                                                                                        FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                        : Container(
                                                                          padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                1,
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                appColor,
                                                                            borderRadius: BorderRadius.circular(
                                                                              20,
                                                                            ),
                                                                            border: Border.all(
                                                                              color:
                                                                                  appColor,
                                                                            ),
                                                                          ),
                                                                          height:
                                                                              27,
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Expanded(
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    context
                                                                                        .read<
                                                                                          BannerBloc
                                                                                        >()
                                                                                        .add(
                                                                                          ChangeVarientItemEvent(
                                                                                            productIndex:
                                                                                                index,
                                                                                            varientIndex:
                                                                                                selectedProductIndex ==
                                                                                                        index
                                                                                                    ? varientIndex
                                                                                                    : 0,
                                                                                          ),
                                                                                        );
                                                                                    context
                                                                                        .read<
                                                                                          BannerBloc
                                                                                        >()
                                                                                        .add(
                                                                                          RemoveButtonPressedEvent(
                                                                                            type:
                                                                                                "screen",
                                                                                            varientindex:
                                                                                                varientIndex,
                                                                                            index:
                                                                                                index,
                                                                                          ),
                                                                                        );
                                                                                  },
                                                                                  child: const Icon(
                                                                                    Icons.remove,
                                                                                    color:
                                                                                        Colors.white,
                                                                                    size:
                                                                                        16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                // margin:
                                                                                //     const EdgeInsets
                                                                                //         .symmetric(
                                                                                //         horizontal:
                                                                                //             16),
                                                                                //  padding: const EdgeInsets.symmetric(vertical: 2),
                                                                                width:
                                                                                    28,
                                                                                decoration: BoxDecoration(
                                                                                  color:
                                                                                      Colors.white,
                                                                                  //  borderRadius: BorderRadius.circular(4),
                                                                                ),
                                                                                child: Text(
                                                                                  selectedProductIndex ==
                                                                                          index
                                                                                      ? bannerProductResponse.data![index].variants![varientIndex].cartQuantity.toString()
                                                                                      : bannerProductResponse.data![index].variants![0].cartQuantity.toString(),
                                                                                  textAlign:
                                                                                      TextAlign.center,
                                                                                  style: GoogleFonts.poppins(
                                                                                    color:
                                                                                        appColor,
                                                                                    fontSize:
                                                                                        14,
                                                                                    fontWeight:
                                                                                        FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    context
                                                                                        .read<
                                                                                          BannerBloc
                                                                                        >()
                                                                                        .add(
                                                                                          ChangeVarientItemEvent(
                                                                                            productIndex:
                                                                                                index,
                                                                                            varientIndex:
                                                                                                selectedProductIndex ==
                                                                                                        index
                                                                                                    ? varientIndex
                                                                                                    : 0,
                                                                                          ),
                                                                                        );
                                                                                    context
                                                                                        .read<
                                                                                          BannerBloc
                                                                                        >()
                                                                                        .add(
                                                                                          AddButtonPressedEvent(
                                                                                            type:
                                                                                                "screen",
                                                                                            index:
                                                                                                index,
                                                                                            varientindex:
                                                                                                varientIndex,
                                                                                          ),
                                                                                        );
                                                                                  },
                                                                                  child: const Icon(
                                                                                    Icons.add,
                                                                                    color:
                                                                                        Colors.white,
                                                                                    size:
                                                                                        16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                SizedBox(height: 40),
                                BottomImageWidget(),
                                BottomCategoriesBarWidget(),
                                BottomAppBarWidget(),
                              ],
                            ),
                          );
                        },
                      ),
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
