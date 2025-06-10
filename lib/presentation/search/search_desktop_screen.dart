import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/model/home/search_response_model.dart';
import 'package:selorgweb_main/presentation/cart/cart_screen.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_screen.dart';
import 'package:selorgweb_main/presentation/search/search_bloc.dart';
import 'package:selorgweb_main/presentation/search/search_event.dart';
import 'package:selorgweb_main/presentation/search/search_state.dart';
import 'package:selorgweb_main/presentation/settings/setting_main_screen.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/utils/widgets/network_image.dart';

class SearchDesktopScreen extends StatelessWidget {
  final String searchTitle;
  const SearchDesktopScreen({super.key, required this.searchTitle});

  static TextEditingController searchController = TextEditingController();
  static SearchResponse searchResponse = SearchResponse();
  static int variantindex = 0;
  static String nodata = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccessState) {
            searchResponse = state.searchResults;
          } else if (state is CloseState) {
            searchController.clear();
            searchResponse = SearchResponse();
          } else if (state is AddButtonClickedState) {
            if (state.type == "screen") {
              searchResponse.data![state.index].variants![0].cartQuantity =
                  searchResponse.data![state.index].variants![0].cartQuantity! +
                  1;
              context.read<SearchBloc>().add(
                ItemAddToCartApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  quantity: 1,
                  variantLabel:
                      searchResponse.data![state.index].variants![0].label
                          .toString(),
                  imageUrl:
                      searchResponse.data![state.index].variants![0].imageUrl
                          .toString(),
                  price:
                      searchResponse.data![state.index].variants![0].price ?? 0,
                  discountPrice:
                      searchResponse
                          .data![state.index]
                          .variants![0]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else {
              searchResponse
                  .data![state.index]
                  .variants![variantindex]
                  .cartQuantity = searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .cartQuantity! +
                  1;

              context.read<SearchBloc>().add(
                ItemAddToCartApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  quantity: 1,
                  variantLabel:
                      searchResponse
                          .data![state.index]
                          .variants![variantindex]
                          .label
                          .toString(),
                  imageUrl:
                      searchResponse
                          .data![state.index]
                          .variants![variantindex]
                          .imageUrl
                          .toString(),
                  price:
                      searchResponse
                          .data![state.index]
                          .variants![variantindex]
                          .price ??
                      0,
                  discountPrice:
                      searchResponse
                          .data![state.index]
                          .variants![variantindex]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            }
          } else if (state is AddedItemToCartState) {
            // context.read<ProductBloc>().add(CartLengthEvent(userId: userId));
            // context.read<SearchBloc>().add(ProductStyleEvent(
            //     mobilNo: phoneNumber,
            //     userId: userId,
            //     isMainCategory: isMainCategory,
            //     mainCatId: mainCatId,
            //     isSubCategory: true,
            //     subCatId: subCatList[isSelected].id ?? "",
            //     page: page));
          } else if (state is RemoveButtonClickedState) {
            if (state.type == "screen") {
              searchResponse.data![state.index].variants![0].cartQuantity =
                  searchResponse.data![state.index].variants![0].cartQuantity! -
                  1;

              context.read<SearchBloc>().add(
                ItemRemoveFromApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  variantLabel:
                      searchResponse.data![state.index].variants![0].label
                          .toString(),
                  quantity: 1,
                  handlingCharges: 0,
                  deliveryTip: 0,
                ),
              );
            } else {
              searchResponse
                  .data![state.index]
                  .variants![variantindex]
                  .cartQuantity = searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .cartQuantity! -
                  1;
              context.read<SearchBloc>().add(
                ItemRemoveFromApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  variantLabel:
                      searchResponse
                          .data![state.index]
                          .variants![variantindex]
                          .label
                          .toString(),
                  quantity: 1,
                  handlingCharges: 0,
                  deliveryTip: 0,
                ),
              );
            }
          } else if (state is ItemRemovedCartState) {
            // context.read<ProductBloc>().add(CartLengthEvent(userId: userId));
            // context.read<ProductBloc>().add(ProductStyleEvent(
            //     mobilNo: phoneNumber,
            //     userId: userId,
            //     isMainCategory: isMainCategory,
            //     mainCatId: mainCatId,
            //     isSubCategory: true,
            //     subCatId: subCatList[isSelected].id ?? "",
            //     page: page));
          } else if (state is VarientChangedState) {
            // productIndex = state.productIndex;
            variantindex = state.varientIndex;
            // selectedProductIndexes = state.productIndex;

            // debugPrint(
            //     '${productStyleResponse.data![productIndex].variants![productVarientIndex].cartQuantity} - ${productStyleResponse.data![productIndex].variants![productVarientIndex].label}');
          } else if (state is SearchErrorState) {
            searchResponse = SearchResponse();
            nodata = "Could not find any products for";
          }
        },
        builder: (context, state) {
          if (state is SearchInitialState) {
            searchController.clear();
            searchResponse = SearchResponse();
            searchController.text = searchTitle;
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150,
                      vertical: 7,
                    ),
                    color: const Color(0xFF052E16),
                    height: 112,
                    child: FittedBox(
                      child: Row(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context.go('/');
                                },
                                child: SvgPicture.asset(
                                  appTextImage,
                                  height: 20,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 40,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                color: Colors.white,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      location,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width / 3,
                          //   height: 40,
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 36,
                          //     vertical: 8,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: TextFormField(
                          //           decoration: InputDecoration(
                          //             // border: OutlineInputBorder(
                          //             //   borderRadius: BorderRadius.circular(12),
                          //             //   borderSide: BorderSide(
                          //             //     color: Color(0xFFAAAAAA),
                          //             //   ),
                          //             // ),
                          //             // enabledBorder: OutlineInputBorder(
                          //             //   borderRadius: BorderRadius.circular(12),
                          //             //   borderSide: BorderSide(
                          //             //     color: Color(0xFFAAAAAA),
                          //             //     width: 1.0,
                          //             //   ),
                          //             // ),
                          //             // focusedBorder: OutlineInputBorder(
                          //             //   borderRadius: BorderRadius.circular(12),
                          //             //   borderSide: BorderSide(
                          //             //     color: Color(
                          //             //       0xFFAAAAAA,
                          //             //     ), // Change this to whatever highlight color you want
                          //             //     width: 2.0,
                          //             //   ),
                          //             // ),
                          //             // helperText: 'Add your special notes on your order',
                          //             hintText:
                          //                 'Add your special notes on your order',
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            // height: 40,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: searchController,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    onChanged: (value) {
                                      context.read<SearchBloc>().add(
                                        SearchApiEvent(searchText: value),
                                      );
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: whiteColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintText: 'Search your products....',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SettingMainScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'My Account',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 28),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CartScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 127,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.black),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 4,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'My Cart',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF052E16),
                                        ),
                                      ),
                                      // if (count != 0)
                                      //   Container(
                                      //     decoration: BoxDecoration(
                                      //       color: appColor,
                                      //       shape: BoxShape.circle,
                                      //     ),
                                      //     alignment: Alignment.center,
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.all(6.0),
                                      //       child: Text(
                                      //         count.toString(),
                                      //         style: TextStyle(color: Colors.white),
                                      //       ),
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double itemWidth = 200;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            searchResponse.data == null
                                ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  child: Center(
                                    child: Text(
                                      "No products found",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                                : Container(
                                  constraints: BoxConstraints(maxWidth: 1280),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 150,
                                      vertical: 7,
                                    ),
                                    child: GridView.builder(
                                      // controller: _scrollController,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                constraints.maxWidth < 600
                                                    ? 2
                                                    : constraints.maxWidth < 991
                                                    ? 3
                                                    : 5,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 0.65,
                                          ),
                                      itemCount: searchResponse.data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: itemWidth,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Column(
                                            spacing: 3,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return ProductDetailsScreen(
                                                            productId:
                                                                searchResponse
                                                                    .data![index]
                                                                    .id ??
                                                                "",
                                                            screenType: "back",
                                                          );
                                                        },
                                                      ),
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
                                                                searchResponse
                                                                    .data![index]
                                                                    .variants![0]
                                                                    .imageUrl ??
                                                                "",
                                                            fit: BoxFit.contain,
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
                                                                horizontal: 8,
                                                                vertical: 4,
                                                              ),
                                                          decoration: const BoxDecoration(
                                                            color: Color(
                                                              0xFF034703,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.only(
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
                                                            searchResponse
                                                                    .data![index]
                                                                    .variants![0]
                                                                    .offer ??
                                                                "",
                                                            style:
                                                                const TextStyle(
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
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      searchResponse
                                                              .data![index]
                                                              .skuName ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    // InkWell(
                                                    //   onTap: () {
                                                    //     // showVarientsDialog(
                                                    //     //   context,
                                                    //     //   searchResponse
                                                    //     //           .data![index]
                                                    //     //           .skuName ??
                                                    //     //       "",
                                                    //     //   index,
                                                    //     //   context
                                                    //     //       .read<
                                                    //     //         BannerBloc
                                                    //     //       >(),
                                                    //     // );
                                                    //   },
                                                    //   child: Container(
                                                    //     padding:
                                                    //         const EdgeInsets.symmetric(
                                                    //           horizontal: 4,
                                                    //           vertical: 8,
                                                    //         ),
                                                    //     decoration: BoxDecoration(
                                                    //       border: Border.all(
                                                    //         color: const Color(
                                                    //           0xFFE0ECE0,
                                                    //         ),
                                                    //       ),
                                                    //       borderRadius:
                                                    //           BorderRadius.circular(
                                                    //             4,
                                                    //           ),
                                                    //     ),
                                                    //     child: Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         Expanded(
                                                    //           child: Text(
                                                    //             searchResponse
                                                    //                     .data![index]
                                                    //                     .variants![0]
                                                    //                     .label ??
                                                    //                 "",
                                                    //             maxLines: 1,
                                                    //             overflow:
                                                    //                 TextOverflow
                                                    //                     .ellipsis,
                                                    //             style: TextStyle(
                                                    //               fontSize: 10,
                                                    //               color:
                                                    //                   Colors
                                                    //                       .black,
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //         Icon(
                                                    //           Icons
                                                    //               .keyboard_arrow_down_rounded,
                                                    //           size: 15,
                                                    //         ),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: 6),
                                                    // Row(
                                                    //   children: [
                                                    //     RichText(
                                                    //       text: TextSpan(
                                                    //         text: '₹ ',
                                                    //         style:
                                                    //             const TextStyle(
                                                    //               fontSize: 16,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .bold,
                                                    //               color:
                                                    //                   Colors
                                                    //                       .black,
                                                    //             ),
                                                    //         children: <
                                                    //           TextSpan
                                                    //         >[
                                                    //           TextSpan(
                                                    //             text:
                                                    //                 '${searchResponse.data![index].variants![0].discountPrice ?? ""}',
                                                    //             style: const TextStyle(
                                                    //               fontSize: 14,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .bold,
                                                    //               color:
                                                    //                   Colors
                                                    //                       .black,
                                                    //             ),
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //     SizedBox(width: 6),
                                                    //     Text(
                                                    //       searchResponse
                                                    //           .data![index]
                                                    //           .variants![0]
                                                    //           .price
                                                    //           .toString(),
                                                    //       style: const TextStyle(
                                                    //         decoration:
                                                    //             TextDecoration
                                                    //                 .lineThrough,
                                                    //         fontSize: 12,
                                                    //         fontWeight:
                                                    //             FontWeight.w600,
                                                    //         color: Color(
                                                    //           0xFF777777,
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //     SizedBox(height: 5),
                                                    //     Expanded(
                                                    //       child: Padding(
                                                    //         padding:
                                                    //             const EdgeInsets.symmetric(
                                                    //               horizontal:
                                                    //                   10.0,
                                                    //             ),
                                                    //         child:
                                                    //             searchResponse
                                                    //                         .data![index]
                                                    //                         .variants![0]
                                                    //                         .cartQuantity ==
                                                    //                     0
                                                    //                 ? InkWell(
                                                    //                   onTap:
                                                    //                       () {},
                                                    //                   child: Container(
                                                    //                     padding: const EdgeInsets.symmetric(
                                                    //                       vertical:
                                                    //                           1,
                                                    //                     ),
                                                    //                     decoration: BoxDecoration(
                                                    //                       color:
                                                    //                           whitecolor,
                                                    //                       borderRadius: BorderRadius.circular(
                                                    //                         20,
                                                    //                       ),
                                                    //                       border: Border.all(
                                                    //                         color:
                                                    //                             appColor,
                                                    //                       ),
                                                    //                     ),
                                                    //                     height:
                                                    //                         27,
                                                    //                     child: Row(
                                                    //                       mainAxisAlignment:
                                                    //                           MainAxisAlignment.center,
                                                    //                       children: [
                                                    //                         Text(
                                                    //                           "Add",
                                                    //                           textAlign:
                                                    //                               TextAlign.center,
                                                    //                           style: GoogleFonts.poppins(
                                                    //                             color:
                                                    //                                 appColor,
                                                    //                             fontSize:
                                                    //                                 12,
                                                    //                             fontWeight:
                                                    //                                 FontWeight.w500,
                                                    //                           ),
                                                    //                         ),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                 )
                                                    //                 : Container(
                                                    //                   padding: const EdgeInsets.symmetric(
                                                    //                     vertical:
                                                    //                         1,
                                                    //                   ),
                                                    //                   decoration: BoxDecoration(
                                                    //                     color: const Color(
                                                    //                       0xFF326A32,
                                                    //                     ),
                                                    //                     borderRadius:
                                                    //                         BorderRadius.circular(
                                                    //                           20,
                                                    //                         ),
                                                    //                     border: Border.all(
                                                    //                       color:
                                                    //                           appColor,
                                                    //                     ),
                                                    //                   ),
                                                    //                   height:
                                                    //                       27,
                                                    //                   child: Row(
                                                    //                     mainAxisAlignment:
                                                    //                         MainAxisAlignment.center,
                                                    //                     children: [
                                                    //                       Expanded(
                                                    //                         child: InkWell(
                                                    //                           onTap: () {
                                                    //                             // context
                                                    //                             //     .read<
                                                    //                             //       BannerBloc
                                                    //                             //     >()
                                                    //                             //     .add(
                                                    //                             //       RemoveButtonPressedEvent(
                                                    //                             //         type:
                                                    //                             //             "screen",
                                                    //                             //         varientindex:
                                                    //                             //             0,
                                                    //                             //         index:
                                                    //                             //             index,
                                                    //                             //       ),
                                                    //                             //     );
                                                    //                           },
                                                    //                           child: const Icon(
                                                    //                             Icons.remove,
                                                    //                             color:
                                                    //                                 Colors.white,
                                                    //                             size:
                                                    //                                 16,
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                       Container(
                                                    //                         // margin:
                                                    //                         //     const EdgeInsets
                                                    //                         //         .symmetric(
                                                    //                         //         horizontal:
                                                    //                         //             16),
                                                    //                         //  padding: const EdgeInsets.symmetric(vertical: 2),
                                                    //                         width:
                                                    //                             37,
                                                    //                         decoration: BoxDecoration(
                                                    //                           color:
                                                    //                               Colors.white,
                                                    //                           //  borderRadius: BorderRadius.circular(4),
                                                    //                         ),
                                                    //                         child: Text(
                                                    //                           searchResponse.data![index].variants![0].cartQuantity.toString(),
                                                    //                           textAlign:
                                                    //                               TextAlign.center,
                                                    //                           style: GoogleFonts.poppins(
                                                    //                             color: const Color(
                                                    //                               0xFF326A32,
                                                    //                             ),
                                                    //                             fontSize:
                                                    //                                 14,
                                                    //                             fontWeight:
                                                    //                                 FontWeight.w500,
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                       Expanded(
                                                    //                         child: InkWell(
                                                    //                           onTap: () {
                                                    //                             // context
                                                    //                             //     .read<
                                                    //                             //       BannerBloc
                                                    //                             //     >()
                                                    //                             //     .add(
                                                    //                             //       AddButtonPressedEvent(
                                                    //                             //         type:
                                                    //                             //             "screen",
                                                    //                             //         index:
                                                    //                             //             index,
                                                    //                             //         varientindex:
                                                    //                             //             0,
                                                    //                             //       ),
                                                    //                             //     );
                                                    //                           },
                                                    //                           child: const Icon(
                                                    //                             Icons.add,
                                                    //                             color:
                                                    //                                 Colors.white,
                                                    //                             size:
                                                    //                                 16,
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ],
                                                    //                   ),
                                                    //                 ),
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
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
      ),
    );
  }
}
