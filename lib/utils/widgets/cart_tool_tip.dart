import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/cart/widgets/cart_item_widget.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/model/cart/update_cart_response_model.dart';
import 'package:selorgweb_main/presentation/cart/cart_bloc.dart';
import 'package:selorgweb_main/presentation/cart/cart_event.dart';
import 'package:selorgweb_main/presentation/cart/cart_state.dart';
import 'package:selorgweb_main/presentation/category/categories_screen.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/home/home_bloc.dart';

import 'package:selorgweb_main/presentation/home/home_event.dart' as he;
import 'package:selorgweb_main/presentation/home/home_state.dart' as hs;
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/utils/widgets/network_image.dart';

class CartToolTip extends StatefulWidget {
  const CartToolTip({super.key, required this.entry, required this.overlay});
  final OverlayEntry entry;
  final OverlayState overlay;
  @override
  State<CartToolTip> createState() => _CartToolTipState();
}

class _CartToolTipState extends State<CartToolTip> {
  static final List<int> tipOptions = [10, 20, 30];
  static CartResponse cartResponse = CartResponse();
  static String tipAmount = "0";
  static bool expantion = false;
  static bool isOneSelected = false;
  static bool isTwoSelected = false;
  static String address = "";
  static String locationType = "";
  static String deliveryIns = "";
  static TextEditingController additionalNote = TextEditingController();
  static UpdateCartResponse updateCartResponse = UpdateCartResponse();
  static List<SearchedLocationResponse> searchedLocations = [];

  static TextEditingController searchLocationController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1090;
    final isMobile = MediaQuery.of(context).size.width < 700;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc()),
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
          return BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartDataSuccess) {
                cartResponse = state.cartResponse;
                debugPrint(cartResponse.items!.length.toString());
                if (cartResponse.items!.isEmpty) {
                  tipAmount = "0";
                  cartCount = 0;
                } else {
                  tipAmount = cartResponse.billSummary!.deliveryTip.toString();
                }
                cartCount = state.countvalue;
                context.read<CounterCubit>().increment(cartCount);
                // debugPrint(state.cartResponse.billSummary!..toString());
              } else if (state is AddButtonClickedState) {
                cartResponse.items![state.selectedIndex].quantity =
                    (cartResponse.items![state.selectedIndex].quantity ?? 0) +
                    1;
                context.read<CartBloc>().add(
                  AddItemInCartApiEvent(
                    userId: userId,
                    productId:
                        cartResponse
                            .items![state.selectedIndex]
                            .productId!
                            .id ??
                        "",
                    quantity: 1,
                    variantLabel:
                        cartResponse.items![state.selectedIndex].variantLabel ??
                        "",
                    imageUrl:
                        cartResponse.items![state.selectedIndex].imageUrl ?? "",
                    price: cartResponse.items![state.selectedIndex].price ?? 0,
                    discountPrice:
                        cartResponse
                            .items![state.selectedIndex]
                            .discountPrice ??
                        0,
                    delivaryInstructions: "",
                    addNotes: "",
                  ),
                );
              } else if (state is RemoveButtonClickedState) {
                // cartResponse.items![state.selectedIndex].quantity =
                //     (cartResponse.items![state.selectedIndex].quantity ?? 0) - 1;
                context.read<CartBloc>().add(
                  RemoveItemInCartApiEvent(
                    userId: userId,
                    productId:
                        cartResponse
                            .items![state.selectedIndex]
                            .productId!
                            .id ??
                        "",
                    quantity: 1,
                    variantLabel:
                        cartResponse.items![state.selectedIndex].variantLabel ??
                        "",
                    deliveryTip: 0,
                    handlingCharges: 0,
                  ),
                );
              } else if (state is ItemAddedToCartState) {
                context.read<CartBloc>().add(
                  GetCartDetailsEvent(userId: userId),
                );
              } else if (state is ItemRemovedToCartState) {
                context.read<CartBloc>().add(
                  GetCartDetailsEvent(userId: userId),
                );
              }
            },
            builder: (context, state) {
              if (state is CartInitialState) {
                cartResponse = CartResponse();
                cartResponse.items = [];
                // savedAddressList = [];
                context.read<CartBloc>().add(
                  GetCartDetailsEvent(userId: userId),
                );
                context.read<CartBloc>().add(
                  GetSavedAddressFromApiEvent(time: "initial", userId: userId),
                );
              }
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Triangle at top center
                  Positioned(
                    top: -10,
                    left: 140, // Adjust this to center the triangle
                    child: CustomPaint(
                      painter: TrianglePainter(color: Colors.white),
                      child: SizedBox(width: 20, height: 10),
                    ),
                  ),

                  // Tooltip box
                  Container(
                    width: 300,
                    // height: 200,
                    constraints: BoxConstraints(maxHeight: 400, minHeight: 200),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child:
                          cartResponse
                                  .items!
                                  .isEmpty /* || cartResponse.items![index]
                                                                  .quantity ==
                                                              0
                                                          ?  */
                              ? SizedBox(
                                width: double.infinity,
                                //color: appColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // spacing: 20,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Cart Items',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        InkWell(
                                          onTap: () => widget.entry.remove(),
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: appColor,
                                            child: Icon(
                                              Icons.close,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Image.asset(emptyCartImage),
                                    Text(
                                      "Your cart is empty",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        CategoriesScreen(),
                                              ),
                                            );
                                            // Navigator.pop(context);
                                            // Navigator.pushNamed(context, '/home');
                                            // selectedIndex = 1;
                                            // context
                                            //     .read<CartBloc>()
                                            //     .add(SelectTipEvent(amount: "0"));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF034703,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            // minimumSize: const Size(300, 50),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Browse Now',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              : Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Cart Items',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        InkWell(
                                          onTap: () => widget.entry.remove(),
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: appColor,
                                            child: Icon(
                                              Icons.close,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),

                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: cartResponse.items!.length,
                                      itemBuilder: (context, index) {
                                        // cartCount = cartResponse.items!.length;
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          cartResponse
                                                                      .items![index]
                                                                      .imageUrl ==
                                                                  ""
                                                              ? SizedBox()
                                                              : ImageNetworkWidget(
                                                                url:
                                                                    cartResponse
                                                                        .items![index]
                                                                        .imageUrl ??
                                                                    "",
                                                                width: 50,
                                                                height: 50,
                                                                fit:
                                                                    BoxFit
                                                                        .fitHeight,
                                                              ),
                                                          // Image.network('image', width: isMobile ? 70 : 90),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                cartResponse
                                                                            .items![index]
                                                                            .productId ==
                                                                        null
                                                                    ? ""
                                                                    : cartResponse
                                                                            .items![index]
                                                                            .productId!
                                                                            .skuName ??
                                                                        "",
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color(
                                                                    0xFF444444,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                cartResponse
                                                                        .items![index]
                                                                        .variantLabel ??
                                                                    "",
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: const Color(
                                                                    0xFF666666,
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '₹ ${cartResponse.items![index].discountPrice}',
                                                                    style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: const Color(
                                                                        0xFF444444,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    '₹ ${cartResponse.items![index].price}',
                                                                    style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: const Color(
                                                                        0xFF777777,
                                                                      ),
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal:
                                                                    10.0,
                                                              ),
                                                          child: Text(
                                                            'x${cartResponse.items![index].quantity}',
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
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Path path =
        Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
