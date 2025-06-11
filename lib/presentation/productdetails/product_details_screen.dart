import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/model/category/similar_product_response_model.dart';
import 'package:selorgweb_main/presentation/cart/cart_screen.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_bloc.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_event.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_state.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/utils/widgets/bottom_app_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_categories_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_image_widget.dart';
import 'package:selorgweb_main/utils/widgets/network_image.dart';
import 'package:selorgweb_main/utils/widgets/header_widget.dart';
import 'package:selorgweb_main/presentation/home/home_bloc.dart';
import 'package:selorgweb_main/presentation/home/home_event.dart' as he;
import 'package:selorgweb_main/presentation/home/home_state.dart' as hs;
import 'package:selorgweb_main/model/cart/cart_model.dart' as cart;
import 'package:selorgweb_main/model/category/product_detail_model.dart' as pdm;
import 'package:selorgweb_main/model/category/similar_product_detail_response_model.dart'
    as spd;

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final String screenType;

  const ProductDetailsScreen({
    required this.productId,
    required this.screenType,
    super.key,
  });

  static pdm.ProductDetailResponse productDetailResponse =
      pdm.ProductDetailResponse();
  static String errorMsg = '';
  static SimilarProductResponse similarProductResponse =
      SimilarProductResponse();
  static spd.SimilarProductDetailResponse similarProductDetailResponse =
      spd.SimilarProductDetailResponse();
  static bool addButtonClicked = false;
  static int varientIndex = 0;
  static int similarvarientIndex = 0;
  static cart.CartResponse cartResponse = cart.CartResponse();
  static int cartCount = 0;
  static int totalAmount = 0;
  static dynamic selectedVariant;
  static dynamic selectedsimilarVariant;
  static int similarIndex = 0;

  void showProductBottomSheet(
    BuildContext context,
    String name,
    bool isSimilar,
    int similarIndex,
    List<dynamic> variant,
    ProductDetailBloc productDetailBloc,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: productDetailBloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          spacing: 15,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: variant.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    // varientIndex =
                                    //     i; // Update the selected variant index
                                    // selectedVariant = productDetailResponse
                                    //     .data!.product!.variants![i];

                                    Navigator.pop(context);
                                    context.read<ProductDetailBloc>().add(
                                      LabelVarientItemEvent(
                                        productIndex: 0,
                                        varientIndex: i,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              variant[i].label ?? "",
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall,
                                            ),
                                            Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: '₹ ',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            variant[i]
                                                                .discountPrice
                                                                .toString(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              '`Poppins`',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                RichText(
                                                  text: TextSpan(
                                                    text: '₹ ',
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            variant[i].price
                                                                .toString(),
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        isSimilar
                                            ? similarProductResponse
                                                        .data![similarIndex]
                                                        .variants![i]
                                                        .cartQuantity ==
                                                    0
                                                ? SizedBox(
                                                  width: 100,
                                                  height: 30,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          whiteColor,
                                                      shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          color: appColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                            ProductDetailBloc
                                                          >()
                                                          .add(
                                                            AddButtonClikedEvent(
                                                              type:
                                                                  "similar_dialog",
                                                              index: i,
                                                              similarIndex:
                                                                  similarIndex,
                                                              isButtonPressed:
                                                                  true,
                                                            ),
                                                          );
                                                    },
                                                    child: Text(
                                                      "Add",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: appColor,
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
                                                    color: const Color(
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
                                                            context.read<ProductDetailBloc>().add(
                                                              RemoveItemButtonClikedEvent(
                                                                type:
                                                                    "similar_dialog",
                                                                index: i,
                                                                similarIndex:
                                                                    similarIndex,
                                                                isButtonPressed:
                                                                    true,
                                                              ),
                                                            );
                                                          },
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                              size: 16,
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
                                                            similarProductResponse
                                                                .data![similarIndex]
                                                                .variants![i]
                                                                .cartQuantity
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: GoogleFonts.poppins(
                                                              color:
                                                                  const Color(
                                                                    0xFF326A32,
                                                                  ),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            context.read<ProductDetailBloc>().add(
                                                              AddButtonClikedEvent(
                                                                type:
                                                                    "similar_dialog",
                                                                index: i,
                                                                similarIndex:
                                                                    similarIndex,
                                                                isButtonPressed:
                                                                    true,
                                                              ),
                                                            );
                                                          },
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                              child: const Icon(
                                                                Icons.add,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                size: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            : productDetailResponse
                                                    .data!
                                                    .product!
                                                    .variants![i]
                                                    .cartQuantity ==
                                                0
                                            ? SizedBox(
                                              width: 100,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: whiteColor,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: appColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  context
                                                      .read<ProductDetailBloc>()
                                                      .add(
                                                        AddButtonClikedEvent(
                                                          type: "dialog",
                                                          index: i,
                                                          similarIndex:
                                                              similarIndex,
                                                          isButtonPressed: true,
                                                        ),
                                                      );
                                                },
                                                child: Text(
                                                  "Add",
                                                  style: GoogleFonts.poppins(
                                                    color: appColor,
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
                                                color: const Color(0xFF326A32),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: appColor,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                              ProductDetailBloc
                                                            >()
                                                            .add(
                                                              RemoveItemButtonClikedEvent(
                                                                type: "dialog",
                                                                index: i,
                                                                similarIndex:
                                                                    similarIndex,
                                                                isButtonPressed:
                                                                    true,
                                                              ),
                                                            );
                                                      },
                                                      child: SizedBox(
                                                        height: 30,
                                                        child: const Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        productDetailResponse
                                                            .data!
                                                            .product!
                                                            .variants![i]
                                                            .cartQuantity
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              color:
                                                                  const Color(
                                                                    0xFF326A32,
                                                                  ),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                              ProductDetailBloc
                                                            >()
                                                            .add(
                                                              AddButtonClikedEvent(
                                                                type: "dialog",
                                                                index: i,
                                                                similarIndex:
                                                                    similarIndex,
                                                                isButtonPressed:
                                                                    true,
                                                              ),
                                                            );
                                                      },
                                                      child: SizedBox(
                                                        height: 30,
                                                        child: Center(
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 16,
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
                            cartCount == 0
                                ? SizedBox()
                                : Container(
                                  height: 56,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "$cartCount Item",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                " | ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          totalAmount
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontFamily: '`Poppins`',
                                                        fontSize: 16,
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return CartScreen(
                                                      // fromScreen: 'productdetail',
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Row(
                                              spacing: 10,
                                              children: [
                                                Image.asset(viewCartImage),
                                                Text(
                                                  "View Cart",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            SizedBox(height: 10),
                          ],
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

  void showVarientsDialog(
    BuildContext context,
    String name,
    bool isSimilar,
    int similarIndex,
    List<dynamic> variant,
    ProductDetailBloc productDetailBloc,
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
                  value: productDetailBloc,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return BlocBuilder<ProductDetailBloc, ProductDetailState>(
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
                                            itemCount: variant.length,
                                            itemBuilder: (context, i) {
                                              return InkWell(
                                                onTap: () {
                                                  // varientIndex =
                                                  //     i; // Update the selected variant index
                                                  // selectedVariant = productDetailResponse
                                                  //     .data!.product!.variants![i];

                                                  Navigator.pop(context);
                                                  context
                                                      .read<ProductDetailBloc>()
                                                      .add(
                                                        LabelVarientItemEvent(
                                                          productIndex: 0,
                                                          varientIndex: i,
                                                        ),
                                                      );
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
                                                    color: whiteColor,
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
                                                            variant[i].label ??
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
                                                                          variant[i]
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
                                                                          variant[i]
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
                                                      isSimilar
                                                          ? similarProductResponse
                                                                      .data![similarIndex]
                                                                      .variants![i]
                                                                      .cartQuantity ==
                                                                  0
                                                              ? SizedBox(
                                                                width: 100,
                                                                height: 30,
                                                                child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        whiteColor,
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
                                                                    context
                                                                        .read<
                                                                          ProductDetailBloc
                                                                        >()
                                                                        .add(
                                                                          AddButtonClikedEvent(
                                                                            type:
                                                                                "similar_dialog",
                                                                            index:
                                                                                i,
                                                                            similarIndex:
                                                                                similarIndex,
                                                                            isButtonPressed:
                                                                                true,
                                                                          ),
                                                                        );
                                                                  },
                                                                  child: Text(
                                                                    "Add",
                                                                    style: GoogleFonts.poppins(
                                                                      color:
                                                                          appColor,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                              : Container(
                                                                width: 100,
                                                                height: 30,
                                                                padding:
                                                                    const EdgeInsets.symmetric(
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
                                                                                ProductDetailBloc
                                                                              >()
                                                                              .add(
                                                                                RemoveItemButtonClikedEvent(
                                                                                  type:
                                                                                      "similar_dialog",
                                                                                  index:
                                                                                      i,
                                                                                  similarIndex:
                                                                                      similarIndex,
                                                                                  isButtonPressed:
                                                                                      true,
                                                                                ),
                                                                              );
                                                                        },
                                                                        child: SizedBox(
                                                                          height:
                                                                              30,
                                                                          child: const Icon(
                                                                            Icons.remove,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          35,
                                                                      width: 35,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          similarProductResponse
                                                                              .data![similarIndex]
                                                                              .variants![i]
                                                                              .cartQuantity
                                                                              .toString(),
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
                                                                    ),
                                                                    Expanded(
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          context
                                                                              .read<
                                                                                ProductDetailBloc
                                                                              >()
                                                                              .add(
                                                                                AddButtonClikedEvent(
                                                                                  type:
                                                                                      "similar_dialog",
                                                                                  index:
                                                                                      i,
                                                                                  similarIndex:
                                                                                      similarIndex,
                                                                                  isButtonPressed:
                                                                                      true,
                                                                                ),
                                                                              );
                                                                        },
                                                                        child: SizedBox(
                                                                          height:
                                                                              30,
                                                                          child: Center(
                                                                            child: const Icon(
                                                                              Icons.add,
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
                                                              )
                                                          : productDetailResponse
                                                                  .data!
                                                                  .product!
                                                                  .variants![i]
                                                                  .cartQuantity ==
                                                              0
                                                          ? SizedBox(
                                                            width: 100,
                                                            height: 30,
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    whiteColor,
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
                                                                context
                                                                    .read<
                                                                      ProductDetailBloc
                                                                    >()
                                                                    .add(
                                                                      AddButtonClikedEvent(
                                                                        type:
                                                                            "dialog",
                                                                        index:
                                                                            i,
                                                                        similarIndex:
                                                                            similarIndex,
                                                                        isButtonPressed:
                                                                            true,
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
                                                                            ProductDetailBloc
                                                                          >()
                                                                          .add(
                                                                            RemoveItemButtonClikedEvent(
                                                                              type:
                                                                                  "dialog",
                                                                              index:
                                                                                  i,
                                                                              similarIndex:
                                                                                  similarIndex,
                                                                              isButtonPressed:
                                                                                  true,
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
                                                                      productDetailResponse
                                                                          .data!
                                                                          .product!
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
                                                                            ProductDetailBloc
                                                                          >()
                                                                          .add(
                                                                            AddButtonClikedEvent(
                                                                              type:
                                                                                  "dialog",
                                                                              index:
                                                                                  i,
                                                                              similarIndex:
                                                                                  similarIndex,
                                                                              isButtonPressed:
                                                                                  true,
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
        BlocProvider(create: (context) => ProductDetailBloc()),
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
          return BlocConsumer<ProductDetailBloc, ProductDetailState>(
            listener: (context, state) {
              if (state is ProductDetailSuccessState) {
                productDetailResponse = state.productDetailResponse;
                debugPrint(productDetailResponse.data!.product!.skuName);
                similarProductResponse = SimilarProductResponse();
                context.read<ProductDetailBloc>().add(
                  GetSimilarProductEvent(
                    productId: productDetailResponse.data!.product!.id ?? "",
                  ),
                );
                selectedVariant = productDetailResponse.data!.product!.variants!
                    .firstWhere(
                      (variant) => (variant.cartQuantity ?? 0) > 0,
                      orElse:
                          () =>
                              productDetailResponse.data!.product!.variants![0],
                    );
              } else if (state is UpdateSimilarProductIndexState) {
                similarvarientIndex = state.similarIndex;
              } else if (state is SimilarProductSuccessState) {
                similarProductResponse = state.similarProductResponse;
                // similarProductResponse.data![similarIndex].variants!
                //         .firstWhere(
                //           (variant) => (variant.cartQuantity ?? 0) > 0,
                //           orElse: () => similarProductResponse
                //               .data![similarIndex].variants![0],
                //         )
                //         .label ??
                // "";
                selectedsimilarVariant = similarProductResponse
                    .data![similarIndex]
                    .variants!
                    .firstWhere(
                      (variant) => (variant.cartQuantity ?? 0) > 0,
                      orElse:
                          () =>
                              similarProductResponse
                                  .data![similarIndex]
                                  .variants![0],
                    );
              } else if (state is SimilarProductDetailSuccessState) {
                similarProductDetailResponse =
                    state.similarProductDetailResponse;
              } else if (state is LabelChangedState) {
                // varientIndex = state.varientIndex;
                // debugPrint(productDetailResponse
                //     .data!.product!.variants![state.varientIndex].label);
                varientIndex = state.varientIndex;
                similarvarientIndex = state.varientIndex;
                selectedVariant =
                    productDetailResponse
                        .data!
                        .product!
                        .variants![varientIndex];
                selectedsimilarVariant =
                    similarProductResponse
                        .data![similarIndex]
                        .variants![similarvarientIndex];
                debugPrint(
                  productDetailResponse
                      .data!
                      .product!
                      .variants![state.varientIndex]
                      .label,
                );
              } else if (state is AddButtonClickedState) {
                addButtonClicked = state.isSelected;
                varientIndex = state.selectedIndexes;
                similarvarientIndex = state.selectedIndexes;
                if (state.type == "screen") {
                  productDetailResponse
                      .data!
                      .product!
                      .variants![varientIndex]
                      .cartQuantity = (productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .cartQuantity ??
                          0) +
                      1;
                  selectedVariant =
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex];

                  context.read<ProductDetailBloc>().add(
                    AddItemInCartApiEvent(
                      userId: userId,
                      productId: productDetailResponse.data!.product!.id ?? "",
                      quantity: 1,
                      variantLabel:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .label ??
                          "",
                      imageUrl:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .imageUrl ??
                          "",
                      price:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .price ??
                          0,
                      discountPrice:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .discountPrice ??
                          0,
                      deliveryInstructions: "",
                      addNotes: "",
                    ),
                  );
                } else if (state.type == "dialog") {
                  productDetailResponse
                      .data!
                      .product!
                      .variants![varientIndex]
                      .cartQuantity = (productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .cartQuantity ??
                          0) +
                      1;
                  debugPrint(
                    productDetailResponse
                        .data!
                        .product!
                        .variants![varientIndex]
                        .label
                        .toString(),
                  );
                  selectedVariant =
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex];
                  context.read<ProductDetailBloc>().add(
                    AddItemInCartApiEvent(
                      userId: userId,
                      productId: productDetailResponse.data!.product!.id ?? "",
                      quantity: 1,
                      variantLabel:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .label ??
                          "",
                      imageUrl:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .imageUrl ??
                          "",
                      price:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .price ??
                          0,
                      discountPrice:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .discountPrice ??
                          0,
                      deliveryInstructions: "",
                      addNotes: "",
                    ),
                  );
                } else if (state.type == "similar") {
                  similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity = (similarProductResponse
                              .data![state.selectedIndexes]
                              .variants![similarvarientIndex]
                              .cartQuantity ??
                          0) +
                      1;
                  selectedsimilarVariant =
                      similarProductResponse
                          .data![similarIndex]
                          .variants![similarvarientIndex];
                  context.read<ProductDetailBloc>().add(
                    AddItemInCartApiEvent(
                      userId: userId,
                      productId:
                          similarProductResponse
                              .data![state.similarIndex]
                              .similarProductId ??
                          "",
                      quantity: 1,
                      variantLabel:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .label ??
                          "",
                      imageUrl:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .imageUrl ??
                          "",
                      price:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .price ??
                          0,
                      discountPrice:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .discountPrice ??
                          0,
                      deliveryInstructions: "",
                      addNotes: "",
                    ),
                  );
                } else if (state.type == "similar_dialog") {
                  similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity = (similarProductResponse
                              .data![state.similarIndex]
                              .variants![similarvarientIndex]
                              .cartQuantity ??
                          0) +
                      1;
                  selectedsimilarVariant =
                      similarProductResponse
                          .data![similarIndex]
                          .variants![similarvarientIndex];
                  context.read<ProductDetailBloc>().add(
                    AddItemInCartApiEvent(
                      userId: userId,
                      productId:
                          similarProductResponse
                              .data![state.similarIndex]
                              .similarProductId ??
                          "",
                      quantity: 1,
                      variantLabel:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .label ??
                          "",
                      imageUrl:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .imageUrl ??
                          "",
                      price:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .price ??
                          0,
                      discountPrice:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .discountPrice ??
                          0,
                      deliveryInstructions: "",
                      addNotes: "",
                    ),
                  );
                }
                // itemCount.add(1);
              } else if (state is ItemAddedToCartState) {
                context.read<ProductDetailBloc>().add(
                  GetSimilarProductEvent(
                    productId: productDetailResponse.data!.product!.id ?? "",
                  ),
                );
                context.read<ProductDetailBloc>().add(
                  GetCartCountLengthEvent(userId: userId),
                );
              } else if (state is RemoveButtonClickedState) {
                varientIndex = state.selectedIndexes;
                similarvarientIndex = state.selectedIndexes;
                if (state.type == "screen") {
                  productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .cartQuantity ==
                          0
                      ? null
                      : productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .cartQuantity = (productDetailResponse
                                  .data!
                                  .product!
                                  .variants![varientIndex]
                                  .cartQuantity ??
                              0) -
                          1;
                  selectedVariant =
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex];
                  context.read<ProductDetailBloc>().add(
                    RemoveItemInCartApiEvent(
                      userId: userId,
                      productId: productDetailResponse.data!.product!.id ?? "",
                      variantLabel:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .label ??
                          "",
                      quantity: 1,
                      deliveryTip: 0,
                      handlingcharges: 0,
                    ),
                  );
                } else if (state.type == "dialog") {
                  productDetailResponse
                      .data!
                      .product!
                      .variants![varientIndex]
                      .cartQuantity = (productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .cartQuantity ??
                          0) -
                      1;
                  debugPrint(
                    productDetailResponse
                        .data!
                        .product!
                        .variants![varientIndex]
                        .label
                        .toString(),
                  );
                  selectedVariant =
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex];
                  context.read<ProductDetailBloc>().add(
                    RemoveItemInCartApiEvent(
                      userId: userId,
                      productId: productDetailResponse.data!.product!.id ?? "",
                      variantLabel:
                          productDetailResponse
                              .data!
                              .product!
                              .variants![varientIndex]
                              .label ??
                          "",
                      quantity: 1,
                      deliveryTip: 0,
                      handlingcharges: 0,
                    ),
                  );
                } else if (state.type == "similar") {
                  similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity = (similarProductResponse
                              .data![state.similarIndex]
                              .variants![similarvarientIndex]
                              .cartQuantity ??
                          0) -
                      1;
                  selectedsimilarVariant =
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![similarvarientIndex];
                  context.read<ProductDetailBloc>().add(
                    RemoveItemInCartApiEvent(
                      userId: userId,
                      productId:
                          similarProductResponse
                              .data![state.similarIndex]
                              .similarProductId ??
                          "",
                      variantLabel:
                          similarProductResponse
                              .data![state.selectedIndexes]
                              .variants![varientIndex]
                              .label ??
                          "",
                      quantity: 1,
                      deliveryTip: 0,
                      handlingcharges: 0,
                    ),
                  );
                } else if (state.type == "similar_dialog") {
                  similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity = (similarProductResponse
                              .data![state.similarIndex]
                              .variants![similarvarientIndex]
                              .cartQuantity ??
                          0) -
                      1;
                  selectedsimilarVariant =
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![similarvarientIndex];
                  context.read<ProductDetailBloc>().add(
                    RemoveItemInCartApiEvent(
                      userId: userId,
                      productId:
                          similarProductResponse
                              .data![state.similarIndex]
                              .similarProductId ??
                          "",
                      variantLabel:
                          similarProductResponse
                              .data![state.similarIndex]
                              .variants![varientIndex]
                              .label ??
                          "",
                      quantity: 1,
                      deliveryTip: 0,
                      handlingcharges: 0,
                    ),
                  );
                }
              } else if (state is ItemRemovedToCartState) {
                context.read<ProductDetailBloc>().add(
                  GetSimilarProductEvent(
                    productId: productDetailResponse.data!.product!.id ?? "",
                  ),
                );
                context.read<ProductDetailBloc>().add(
                  GetCartCountLengthEvent(userId: userId),
                );
              } else if (state is CartCountLengthSuccessState) {
                cartResponse = state.cartResponse;
                cartCount = 0;
                if (state.cartResponse.items != null) {
                  for (var i = 0; i < state.cartResponse.items!.length; i++) {
                    cartCount =
                        cartCount +
                        (state.cartResponse.items![i].quantity ?? 0);
                  }
                }
                context.read<CounterCubit>().increment(cartCount);
                totalAmount = state.cartResponse.billSummary!.itemTotal ?? 0;
              } else if (state is ProductDetailErrorState) {
                errorMsg = state.errorMsg;
                debugPrint(state.errorMsg);
              }
            },
            builder: (context, state) {
              if (state is ProductDetailInitialState) {
                varientIndex = 0;
                similarvarientIndex = 0;
                productDetailResponse = pdm.ProductDetailResponse();
                context.read<ProductDetailBloc>().add(
                  GetProductDetailEvent(
                    mobileNo: phoneNumber,
                    productId: productId,
                  ),
                );
                context.read<ProductDetailBloc>().add(
                  GetCartCountLengthEvent(userId: userId),
                );
              }
              final isTablet = MediaQuery.of(context).size.width < 991;
              final isMobile = MediaQuery.of(context).size.width < 600;
              return Scaffold(
                backgroundColor: appbackgroundColor,
                body: SingleChildScrollView(
                  child:
                      productDetailResponse.data != null
                          ? Column(
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 20 : 60,
                                ),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(),
                                  constraints: BoxConstraints(maxWidth: 1280),
                                  // color: redColor,
                                  // width: double.infinity,
                                  height: isMobile ? 600 : 420,
                                  child:
                                      MediaQuery.of(context).size.width < 800
                                          ? Column(
                                            spacing: 20,
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  //   color: greenColor,
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width /
                                                      2,
                                                  // height: 400,
                                                  child: ImageNetworkWidget(
                                                    url:
                                                        productDetailResponse
                                                            .data!
                                                            .product!
                                                            .variants![0]
                                                            .imageUrl ??
                                                        "",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  //  color: whiteColor,
                                                  width: double.infinity,
                                                  // height: 500,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        productDetailResponse
                                                                .data!
                                                                .product!
                                                                .skuName ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: blackColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          //  color: greenColor,
                                                          width:
                                                              double.infinity,
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                productDetailResponse
                                                                    .data!
                                                                    .product!
                                                                    .variants!
                                                                    .length,
                                                            itemBuilder: (
                                                              context,
                                                              i,
                                                            ) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  // varientIndex =
                                                                  //     i; // Update the selected variant index
                                                                  // selectedVariant = productDetailResponse
                                                                  //     .data!.product!.variants![i];

                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                  context
                                                                      .read<
                                                                        ProductDetailBloc
                                                                      >()
                                                                      .add(
                                                                        LabelVarientItemEvent(
                                                                          productIndex:
                                                                              0,
                                                                          varientIndex:
                                                                              i,
                                                                        ),
                                                                      );
                                                                },
                                                                child: Container(
                                                                  margin:
                                                                      const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            6,
                                                                      ),
                                                                  padding:
                                                                      const EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            10,
                                                                      ),
                                                                  decoration: BoxDecoration(
                                                                    color:
                                                                        whiteColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          3,
                                                                        ),
                                                                    border: Border.all(
                                                                      color:
                                                                          Colors
                                                                              .green,
                                                                      width:
                                                                          0.5,
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              productDetailResponse.data!.product!.variants![i].label ??
                                                                                  "",
                                                                              style:
                                                                                  Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodySmall,
                                                                              maxLines:
                                                                                  1,
                                                                              overflow:
                                                                                  TextOverflow.ellipsis,
                                                                              softWrap:
                                                                                  true,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    text:
                                                                                        '₹ ',
                                                                                    style: TextStyle(
                                                                                      fontSize:
                                                                                          16,
                                                                                      fontWeight:
                                                                                          FontWeight.bold,
                                                                                      color:
                                                                                          Colors.black,
                                                                                    ),
                                                                                    children: <
                                                                                      TextSpan
                                                                                    >[
                                                                                      TextSpan(
                                                                                        text:
                                                                                            productDetailResponse.data!.product!.variants![i].discountPrice.toString(),
                                                                                        style: TextStyle(
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
                                                                                  width:
                                                                                      6,
                                                                                ),
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    text:
                                                                                        '₹ ',
                                                                                    style: GoogleFonts.inter(
                                                                                      decoration:
                                                                                          TextDecoration.lineThrough,
                                                                                      fontSize:
                                                                                          12,
                                                                                      color:
                                                                                          Colors.grey,
                                                                                    ),
                                                                                    children: <
                                                                                      TextSpan
                                                                                    >[
                                                                                      TextSpan(
                                                                                        text:
                                                                                            productDetailResponse.data!.product!.variants![i].price.toString(),
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
                                                                      ),
                                                                      productDetailResponse.data!.product!.variants![i].cartQuantity ==
                                                                              0
                                                                          ? SizedBox(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                30,
                                                                            child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor:
                                                                                    whiteColor,
                                                                                shape: RoundedRectangleBorder(
                                                                                  side: BorderSide(
                                                                                    color:
                                                                                        appColor,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                context
                                                                                    .read<
                                                                                      ProductDetailBloc
                                                                                    >()
                                                                                    .add(
                                                                                      AddButtonClikedEvent(
                                                                                        type:
                                                                                            "dialog",
                                                                                        index:
                                                                                            i,
                                                                                        similarIndex:
                                                                                            similarIndex,
                                                                                        isButtonPressed:
                                                                                            true,
                                                                                      ),
                                                                                    );
                                                                              },
                                                                              child: Text(
                                                                                "Add",
                                                                                style: GoogleFonts.poppins(
                                                                                  color:
                                                                                      appColor,
                                                                                  fontSize:
                                                                                      14,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                          : Container(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                30,
                                                                            padding: const EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  1,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                              color: const Color(
                                                                                0xFF326A32,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                20,
                                                                              ),
                                                                              border: Border.all(
                                                                                color:
                                                                                    appColor,
                                                                              ),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      context
                                                                                          .read<
                                                                                            ProductDetailBloc
                                                                                          >()
                                                                                          .add(
                                                                                            RemoveItemButtonClikedEvent(
                                                                                              type:
                                                                                                  "dialog",
                                                                                              index:
                                                                                                  i,
                                                                                              similarIndex:
                                                                                                  similarIndex,
                                                                                              isButtonPressed:
                                                                                                  true,
                                                                                            ),
                                                                                          );
                                                                                    },
                                                                                    child: SizedBox(
                                                                                      height:
                                                                                          30,
                                                                                      child: const Icon(
                                                                                        Icons.remove,
                                                                                        color:
                                                                                            Colors.white,
                                                                                        size:
                                                                                            16,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  height:
                                                                                      35,
                                                                                  width:
                                                                                      35,
                                                                                  decoration: BoxDecoration(
                                                                                    color:
                                                                                        Colors.white,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      productDetailResponse.data!.product!.variants![i].cartQuantity.toString(),
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
                                                                                ),
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      context
                                                                                          .read<
                                                                                            ProductDetailBloc
                                                                                          >()
                                                                                          .add(
                                                                                            AddButtonClikedEvent(
                                                                                              type:
                                                                                                  "dialog",
                                                                                              index:
                                                                                                  i,
                                                                                              similarIndex:
                                                                                                  similarIndex,
                                                                                              isButtonPressed:
                                                                                                  true,
                                                                                            ),
                                                                                          );
                                                                                    },
                                                                                    child: SizedBox(
                                                                                      height:
                                                                                          30,
                                                                                      child: Center(
                                                                                        child: const Icon(
                                                                                          Icons.add,
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                          : Row(
                                            spacing: 20,
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  //   color: greenColor,
                                                  width: 200,
                                                  height: 400,
                                                  child: ImageNetworkWidget(
                                                    url:
                                                        productDetailResponse
                                                            .data!
                                                            .product!
                                                            .variants![0]
                                                            .imageUrl ??
                                                        "",
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  //  color: whiteColor,
                                                  width: 200,
                                                  height: 400,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        productDetailResponse
                                                                .data!
                                                                .product!
                                                                .skuName ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: blackColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          //  color: greenColor,
                                                          width:
                                                              double.infinity,
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                productDetailResponse
                                                                    .data!
                                                                    .product!
                                                                    .variants!
                                                                    .length,
                                                            itemBuilder: (
                                                              context,
                                                              i,
                                                            ) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  // varientIndex =
                                                                  //     i; // Update the selected variant index
                                                                  // selectedVariant = productDetailResponse
                                                                  //     .data!.product!.variants![i];

                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                  context
                                                                      .read<
                                                                        ProductDetailBloc
                                                                      >()
                                                                      .add(
                                                                        LabelVarientItemEvent(
                                                                          productIndex:
                                                                              0,
                                                                          varientIndex:
                                                                              i,
                                                                        ),
                                                                      );
                                                                },
                                                                child: Container(
                                                                  margin:
                                                                      const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            6,
                                                                      ),
                                                                  padding:
                                                                      const EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            10,
                                                                      ),
                                                                  decoration: BoxDecoration(
                                                                    color:
                                                                        whiteColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          3,
                                                                        ),
                                                                    border: Border.all(
                                                                      color:
                                                                          Colors
                                                                              .green,
                                                                      width:
                                                                          0.5,
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            productDetailResponse.data!.product!.variants![i].label ??
                                                                                "",
                                                                            style:
                                                                                Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodySmall,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              RichText(
                                                                                text: TextSpan(
                                                                                  text:
                                                                                      '₹ ',
                                                                                  style: TextStyle(
                                                                                    fontSize:
                                                                                        16,
                                                                                    fontWeight:
                                                                                        FontWeight.bold,
                                                                                    color:
                                                                                        Colors.black,
                                                                                  ),
                                                                                  children: <
                                                                                    TextSpan
                                                                                  >[
                                                                                    TextSpan(
                                                                                      text:
                                                                                          productDetailResponse.data!.product!.variants![i].discountPrice.toString(),
                                                                                      style: TextStyle(
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
                                                                                width:
                                                                                    6,
                                                                              ),
                                                                              RichText(
                                                                                text: TextSpan(
                                                                                  text:
                                                                                      '₹ ',
                                                                                  style: GoogleFonts.inter(
                                                                                    decoration:
                                                                                        TextDecoration.lineThrough,
                                                                                    fontSize:
                                                                                        12,
                                                                                    color:
                                                                                        Colors.grey,
                                                                                  ),
                                                                                  children: <
                                                                                    TextSpan
                                                                                  >[
                                                                                    TextSpan(
                                                                                      text:
                                                                                          productDetailResponse.data!.product!.variants![i].price.toString(),
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
                                                                      productDetailResponse.data!.product!.variants![i].cartQuantity ==
                                                                              0
                                                                          ? SizedBox(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                30,
                                                                            child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor:
                                                                                    whiteColor,
                                                                                shape: RoundedRectangleBorder(
                                                                                  side: BorderSide(
                                                                                    color:
                                                                                        appColor,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                context
                                                                                    .read<
                                                                                      ProductDetailBloc
                                                                                    >()
                                                                                    .add(
                                                                                      AddButtonClikedEvent(
                                                                                        type:
                                                                                            "dialog",
                                                                                        index:
                                                                                            i,
                                                                                        similarIndex:
                                                                                            similarIndex,
                                                                                        isButtonPressed:
                                                                                            true,
                                                                                      ),
                                                                                    );
                                                                              },
                                                                              child: Text(
                                                                                "Add",
                                                                                style: GoogleFonts.poppins(
                                                                                  color:
                                                                                      appColor,
                                                                                  fontSize:
                                                                                      14,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                          : Container(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                30,
                                                                            padding: const EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  1,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                              color: const Color(
                                                                                0xFF326A32,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                20,
                                                                              ),
                                                                              border: Border.all(
                                                                                color:
                                                                                    appColor,
                                                                              ),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      context
                                                                                          .read<
                                                                                            ProductDetailBloc
                                                                                          >()
                                                                                          .add(
                                                                                            RemoveItemButtonClikedEvent(
                                                                                              type:
                                                                                                  "dialog",
                                                                                              index:
                                                                                                  i,
                                                                                              similarIndex:
                                                                                                  similarIndex,
                                                                                              isButtonPressed:
                                                                                                  true,
                                                                                            ),
                                                                                          );
                                                                                    },
                                                                                    child: SizedBox(
                                                                                      height:
                                                                                          30,
                                                                                      child: const Icon(
                                                                                        Icons.remove,
                                                                                        color:
                                                                                            Colors.white,
                                                                                        size:
                                                                                            16,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  height:
                                                                                      35,
                                                                                  width:
                                                                                      35,
                                                                                  decoration: BoxDecoration(
                                                                                    color:
                                                                                        Colors.white,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      productDetailResponse.data!.product!.variants![i].cartQuantity.toString(),
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
                                                                                ),
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      context
                                                                                          .read<
                                                                                            ProductDetailBloc
                                                                                          >()
                                                                                          .add(
                                                                                            AddButtonClikedEvent(
                                                                                              type:
                                                                                                  "dialog",
                                                                                              index:
                                                                                                  i,
                                                                                              similarIndex:
                                                                                                  similarIndex,
                                                                                              isButtonPressed:
                                                                                                  true,
                                                                                            ),
                                                                                          );
                                                                                    },
                                                                                    child: SizedBox(
                                                                                      height:
                                                                                          30,
                                                                                      child: Center(
                                                                                        child: const Icon(
                                                                                          Icons.add,
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 20 : 60,
                                ),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 1280),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: ExpansionTile(
                                    backgroundColor: whiteColor,
                                    collapsedBackgroundColor: whiteColor,
                                    shape: Border.all(color: whiteColor),
                                    iconColor: appColor,
                                    collapsedIconColor: appColor,
                                    title: Text(
                                      'Product Information',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    children: <Widget>[
                                      Column(
                                        spacing: 10,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "     •     ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'About - ${productDetailResponse.data!.product!.description!.about}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "     •     ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Health Benefits - ${productDetailResponse.data!.product!.description!.healthBenefits}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "     •     ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Nutrition - ${productDetailResponse.data!.product!.description!.nutrition}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "     •     ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Origin of Place - ${productDetailResponse.data!.product!.description!.origin}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 20 : 60,
                                ),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 1280),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 20,
                                    children: [
                                      if (similarProductResponse.data != null)
                                        Text("Similar Products"),
                                      if (similarProductResponse.data != null)
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            spacing: 10,
                                            children: [
                                              for (
                                                int i = 0;
                                                i <
                                                    similarProductResponse
                                                        .data!
                                                        .length;
                                                i++
                                              )
                                                InkWell(
                                                  onTap: () {
                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(
                                                    //   builder: (context) {
                                                    //     return ProductDetailsScreen(
                                                    //         productId: freshFruitsresponse
                                                    //                 .data![i].productId ??
                                                    //             "");
                                                    //   },
                                                    // )).then(
                                                    //   (value) {
                                                    //     if (!context.mounted) return;
                                                    //     context.read<HomeBloc>().add(
                                                    //         GetOrganicFruitsEvent(
                                                    //             mainCatId:
                                                    //                 "676431a2edae32578ae6d220",
                                                    //             subCatId:
                                                    //                 "676ad87c756fa03a5d0d0616",
                                                    //             mobileNo: phoneNumber));
                                                    //   },
                                                    // );
                                                  },
                                                  child: Container(
                                                    height: 300,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: whiteColor,

                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      top: 12.0,
                                                                    ),
                                                                child: ImageNetworkWidget(
                                                                  url:
                                                                      similarProductResponse
                                                                          .data![i]
                                                                          .variants![0]
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
                                                                      vertical:
                                                                          4,
                                                                    ),
                                                                decoration: const BoxDecoration(
                                                                  color: Color(
                                                                    0xFF034703,
                                                                  ),
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
                                                                  similarProductResponse
                                                                          .data![i]
                                                                          .variants![0]
                                                                          .offer ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  10,
                                                                ),
                                                            child: Column(
                                                              //spacing: 2,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  similarProductResponse
                                                                          .data![i]
                                                                          .skuName ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    // debugPrint(
                                                                    //     selectedProductIndexes
                                                                    //         .toString());
                                                                    showVarientsDialog(
                                                                      context,
                                                                      similarProductResponse
                                                                              .data![i]
                                                                              .skuName ??
                                                                          "",
                                                                      true,
                                                                      i,
                                                                      similarProductResponse
                                                                              .data![i]
                                                                              .variants ??
                                                                          [],
                                                                      context
                                                                          .read<
                                                                            ProductDetailBloc
                                                                          >(),
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          4,
                                                                      vertical:
                                                                          8,
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
                                                                            // similarProductResponse
                                                                            //         .data![
                                                                            //             i]
                                                                            //         .variants![
                                                                            //             similarvarientIndex]
                                                                            //         .label ??
                                                                            //     "",
                                                                            similarProductResponse.data![i].variants!
                                                                                    .firstWhere(
                                                                                      (
                                                                                        variant,
                                                                                      ) =>
                                                                                          (variant.cartQuantity ??
                                                                                              0) >
                                                                                          0,
                                                                                      orElse:
                                                                                          () =>
                                                                                              similarProductResponse.data![i].variants![0],
                                                                                    )
                                                                                    .label ??
                                                                                "",
                                                                            // selectedsimilarVariant
                                                                            //         .label ??
                                                                            //     similarProductResponse
                                                                            //         .data![
                                                                            //             i]
                                                                            //         .variants!
                                                                            //         .firstWhere(
                                                                            //           (variant) => (variant.cartQuantity ?? 0) > 0,
                                                                            //           orElse: () => similarProductResponse.data![i].variants![0],
                                                                            //         )
                                                                            //         .label ??
                                                                            //     "",
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              fontSize:
                                                                                  12,
                                                                              color:
                                                                                  Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  spacing: 10,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        RichText(
                                                                          text: TextSpan(
                                                                            text:
                                                                                '₹ ',
                                                                            style: const TextStyle(
                                                                              fontSize:
                                                                                  16,
                                                                              fontWeight:
                                                                                  FontWeight.bold,
                                                                              color:
                                                                                  Colors.black,
                                                                            ),
                                                                            children: <
                                                                              TextSpan
                                                                            >[
                                                                              TextSpan(
                                                                                text:
                                                                                    similarProductResponse.data![i].variants![0].discountPrice.toString(),
                                                                                style: const TextStyle(
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
                                                                        SizedBox(
                                                                          width:
                                                                              6,
                                                                        ),
                                                                        Text(
                                                                          similarProductResponse
                                                                              .data![i]
                                                                              .variants![0]
                                                                              .price
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Color(
                                                                              0xFF777777,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    similarProductResponse.data![i].variants![0].cartQuantity ==
                                                                            0
                                                                        ? Expanded(
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              context
                                                                                  .read<
                                                                                    ProductDetailBloc
                                                                                  >()
                                                                                  .add(
                                                                                    AddButtonClikedEvent(
                                                                                      type:
                                                                                          "similar",
                                                                                      index:
                                                                                          similarIndex,
                                                                                      similarIndex:
                                                                                          i,
                                                                                      isButtonPressed:
                                                                                          true,
                                                                                    ),
                                                                                  );
                                                                            },
                                                                            child: Container(
                                                                              height:
                                                                                  30,
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  color:
                                                                                      appColor,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(
                                                                                  20,
                                                                                ),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'Add',
                                                                                  style: TextStyle(
                                                                                    color:
                                                                                        appColor,
                                                                                    fontSize:
                                                                                        12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                        : Expanded(
                                                                          child: Container(
                                                                            height:
                                                                                30,
                                                                            decoration: BoxDecoration(
                                                                              color:
                                                                                  appColor,
                                                                              border: Border.all(
                                                                                color:
                                                                                    appColor,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                20,
                                                                              ),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    context
                                                                                        .read<
                                                                                          ProductDetailBloc
                                                                                        >()
                                                                                        .add(
                                                                                          RemoveItemButtonClikedEvent(
                                                                                            type:
                                                                                                "similar",
                                                                                            index:
                                                                                                similarIndex,
                                                                                            similarIndex:
                                                                                                i,
                                                                                            isButtonPressed:
                                                                                                true,
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
                                                                                Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color:
                                                                                        Colors.white,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(
                                                                                        left:
                                                                                            8,
                                                                                        right:
                                                                                            8,
                                                                                      ),
                                                                                      child: Text(
                                                                                        similarProductResponse.data![i].variants![0].cartQuantity.toString(),
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
                                                                                  ),
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    context
                                                                                        .read<
                                                                                          ProductDetailBloc
                                                                                        >()
                                                                                        .add(
                                                                                          AddButtonClikedEvent(
                                                                                            type:
                                                                                                "similar",
                                                                                            index:
                                                                                                similarIndex,
                                                                                            similarIndex:
                                                                                                i,
                                                                                            isButtonPressed:
                                                                                                true,
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
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              BottomImageWidget(),
                              BottomCategoriesBarWidget(),
                              BottomAppBarWidget(),
                            ],
                          )
                          : Column(
                            children: [
                              Image.asset(emptyCartImage),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    errorMsg,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
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
