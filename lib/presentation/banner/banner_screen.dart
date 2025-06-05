import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/model/banner/banner_product_response_model.dart';
import 'package:selorgweb_main/presentation/banner/banner_bloc.dart';
import 'package:selorgweb_main/presentation/banner/banner_event.dart';
import 'package:selorgweb_main/presentation/banner/banner_state.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_screen.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_state.dart';
// import 'package:selorgweb_main/presentation/search/search_screen.dart';
import 'package:selorgweb_main/widgets/bottom_app_bar_widget.dart';
import 'package:selorgweb_main/widgets/bottom_categories_bar_widget.dart';
import 'package:selorgweb_main/widgets/bottom_image_widget.dart';
import 'package:selorgweb_main/widgets/header_widget.dart';
// import 'package:selorgweb_main/presentation/search/search_screen.dart';
import 'package:selorgweb_main/widgets/network_image.dart';
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
                                                      color: Colors.green,
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
                                                              color:
                                                                  const Color(
                                                                    0xFF326A32,
                                                                  ),
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
                                                                        color: const Color(
                                                                          0xFF326A32,
                                                                        ),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerBloc(),
      child: BlocConsumer<BannerBloc, BannerState>(
        listener: (context, state) {
          if (state is PraductSuccessState) {
            bannerProductResponse = state.bannerProductResponse;
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
                  userId: userId,
                  productId:
                      bannerProductResponse.data![state.index].productId ?? "",
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
                  userId: userId,
                  productId:
                      bannerProductResponse.data![state.index].productId ?? "",
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
                      bannerProductResponse.data![state.index].productId ?? "",
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
                      bannerProductResponse.data![state.index].productId ?? "",
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
                            HeaderWidget(),
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
                                  constraints: BoxConstraints(maxWidth: 1280),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          constraints.maxWidth < 991 ? 20 : 60,
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
                                      itemCount:
                                          bannerProductResponse.data!.length,
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
                                                                bannerProductResponse
                                                                    .data![index]
                                                                    .productId ??
                                                                "",
                                                            screenType: "back",
                                                          );
                                                        },
                                                      ),
                                                    ).then((value) {
                                                      // Scroll to the top
                                                      // _scrollController.animateTo(
                                                      //   0.0,
                                                      //   duration: const Duration(
                                                      //       milliseconds: 300),
                                                      //   curve: Curves.easeInOut,
                                                      // );
                                                      // if (!context.mounted) return;
                                                      // selectedIndexes = 0;
                                                      // ProductBloc.productList = [];
                                                      // page = 1;
                                                      // context.read<ProductBloc>().add(
                                                      //     ProductStyleEvent(
                                                      //         mobilNo: phoneNumber,
                                                      //         userId: userId,
                                                      //         isMainCategory:
                                                      //             isMainCategory,
                                                      //         mainCatId: mainCatId,
                                                      //         isSubCategory: true,
                                                      //         subCatId:
                                                      //             subCatList[isSelected]
                                                      //                     .id ??
                                                      //                 "",
                                                      //         page: page));
                                                      // context.read<ProductBloc>().add(
                                                      //     CartLengthEvent(
                                                      //         userId: userId));
                                                    });
                                                    // Navigator.pushNamed(
                                                    //     context, '/productDetailsScreen');
                                                    // debugPrint(productStyleResponse
                                                    //     .data![index].productId);
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
                                                                bannerProductResponse
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
                                                            bannerProductResponse
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
                                                      bannerProductResponse
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
                                                            color: const Color(
                                                              0xFFE0ECE0,
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
                                                                bannerProductResponse
                                                                        .data![index]
                                                                        .variants![0]
                                                                        .label ??
                                                                    "",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                  fontSize: 10,
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
                                                            style:
                                                                const TextStyle(
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
                                                                    '${bannerProductResponse.data![index].variants![0].discountPrice ?? ""}',
                                                                style: const TextStyle(
                                                                  fontSize: 14,
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
                                                          bannerProductResponse
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
                                                                FontWeight.w600,
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
                                                                bannerProductResponse
                                                                            .data![index]
                                                                            .variants![0]
                                                                            .cartQuantity ==
                                                                        0
                                                                    ? InkWell(
                                                                      onTap: () {
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
                                                                                    0,
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
                                                                        color: const Color(
                                                                          0xFF326A32,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
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
                                                                                      RemoveButtonPressedEvent(
                                                                                        type:
                                                                                            "screen",
                                                                                        varientindex:
                                                                                            0,
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
                                                                                37,
                                                                            decoration: BoxDecoration(
                                                                              color:
                                                                                  Colors.white,
                                                                              //  borderRadius: BorderRadius.circular(4),
                                                                            ),
                                                                            child: Text(
                                                                              bannerProductResponse.data![index].variants![0].cartQuantity.toString(),
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                              style: GoogleFonts.poppins(
                                                                                color: const Color(
                                                                                  0xFF326A32,
                                                                                ),
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
                                                                                      AddButtonPressedEvent(
                                                                                        type:
                                                                                            "screen",
                                                                                        index:
                                                                                            index,
                                                                                        varientindex:
                                                                                            0,
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
      ),
    );
  }
}
