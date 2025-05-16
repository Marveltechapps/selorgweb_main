import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:selorgweb_main/cart/widgets/cart_with_no_address.dart';
import 'package:selorgweb_main/footer/widgets/app_download_section.dart';
import 'package:selorgweb_main/footer/widgets/categories_section.dart';
import 'package:selorgweb_main/footer/widgets/footer_section.dart';
import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/order/screens/order_status.dart';
import 'package:selorgweb_main/presentation/cart/cart_bloc.dart';
import 'package:selorgweb_main/presentation/cart/cart_event.dart';
import 'package:selorgweb_main/presentation/cart/cart_state.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/widgets/header_widget.dart';

class AddressItem {
  final String title;
  final String subtitle;

  AddressItem({required this.title, required this.subtitle});
}

final List<AddressItem> addressList = [
  AddressItem(title: "Adyar", subtitle: "Adyar, Chennai, Tamil Nadu, India"),
  AddressItem(
    title: "Adyar bus depot",
    subtitle:
        "Adyar Bus Depot, Lattice Bridge Road, Shastri Nagar, Adyar, Chennai, Tamil Nadu, India",
  ),
  AddressItem(
    title: "Adyar Cancer Institute",
    subtitle: "Guindy National Park, Adyar, Chennai, Tamil Nadu, India",
  ),
  AddressItem(title: "Adyar", subtitle: "Adyar, Karnataka, India"),
  AddressItem(
    title: "Adyar Ananda Bhavan – A2B",
    subtitle: "A2B, Commercial Road, Adyar, Chennai",
  ),
  AddressItem(
    title: "Adyar Ananda Bhavan – A2B",
    subtitle: "A2B, Commercial Road, Adyar, Chennai",
  ),
  AddressItem(
    title: "Adyar Ananda Bhavan – A2B",
    subtitle: "A2B, Commercial Road, Adyar, Chennai",
  ),
];

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static String tipAmount = "0";
  static bool isaddressadded = true;
  static CartResponse cartResponse = CartResponse();
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1090;
    final isMobile = MediaQuery.of(context).size.width < 700;
    return BlocProvider(
      create: (context) => CartBloc(),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartDataSuccess) {
            cartResponse = state.cartResponse;
            debugPrint(cartResponse.items!.length.toString());
            if (cartResponse.items!.isEmpty) {
              tipAmount = "0";
              // cartCount = 0;
            } else {
              tipAmount = cartResponse.billSummary!.deliveryTip.toString();
            }
            // debugPrint(state.cartResponse.billSummary!..toString());
          }
        },
        builder: (context, state) {
          if (state is CartInitialState) {
            cartResponse = CartResponse();
            cartResponse.items = [];
            // savedAddressList = [];
            context.read<CartBloc>().add(GetCartDetailsEvent(userId: userId));
            // context.read<CartBloc>().add(
            //     GetSavedAddressFromApiEvent(time: "initial", userId: userId));
          }
          return Scaffold(
            backgroundColor: Color(0xFFFAFAFA),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  HeaderWidget(),
                  Padding(
                    padding:
                        !isMobile
                            ? EdgeInsets.symmetric(horizontal: 70, vertical: 60)
                            : EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 1280,
                        minWidth: 500,
                      ),
                      child:
                          isDesktop
                              ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 59,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(22),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x40666666),
                                                blurRadius: 2,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
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
                                                      spacing: 5,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          emptyCartImage,
                                                        ),
                                                        Text(
                                                          "Your cart is empty",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayMedium,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size.width /
                                                              2,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              // Navigator.pop(context);
                                                              // Navigator.pushNamed(context, '/home');
                                                              // selectedIndex = 1;
                                                              // context
                                                              //     .read<CartBloc>()
                                                              //     .add(SelectTipEvent(amount: "0"));
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                    0xFF034703,
                                                                  ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      32,
                                                                    ),
                                                              ),
                                                              minimumSize:
                                                                  const Size(
                                                                    double
                                                                        .infinity,
                                                                    50,
                                                                  ),
                                                            ),
                                                            child: Text(
                                                              'Browser Now',
                                                              style:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  : Column(
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            cartResponse
                                                                .items!
                                                                .length,
                                                        itemBuilder: (
                                                          context,
                                                          index,
                                                        ) {
                                                          // cartCount = cartResponse.items!.length;
                                                          return ResponsiveRowColumn(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  cartResponse
                                                                              .items![index]
                                                                              .imageUrl ==
                                                                          ""
                                                                      ? SizedBox()
                                                                      : ImageNetwork(
                                                                        image:
                                                                            cartResponse.items![index].imageUrl ??
                                                                            "",
                                                                        width:
                                                                            isMobile
                                                                                ? 70
                                                                                : 90,
                                                                        height:
                                                                            isMobile
                                                                                ? 70
                                                                                : 90,
                                                                        fitWeb:
                                                                            BoxFitWeb.cover,
                                                                      ),
                                                                  // Image.network('image', width: isMobile ? 70 : 90),
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        cartResponse.items![index].productId ==
                                                                                null
                                                                            ? ""
                                                                            : cartResponse.items![index].productId!.skuName ??
                                                                                "",
                                                                        style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              isMobile
                                                                                  ? 15
                                                                                  : 19,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color(
                                                                            0xFF444444,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        cartResponse.items![index].variantLabel ??
                                                                            "",
                                                                        style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              isMobile
                                                                                  ? 10
                                                                                  : 13,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color(
                                                                            0xFF666666,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            '₹ ' +
                                                                                cartResponse.items![index].discountPrice.toString(),
                                                                            style: GoogleFonts.inter(
                                                                              fontSize:
                                                                                  isMobile
                                                                                      ? 15
                                                                                      : 19,
                                                                              fontWeight:
                                                                                  FontWeight.w500,
                                                                              color: const Color(
                                                                                0xFF444444,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            '₹ ' +
                                                                                cartResponse.items![index].price.toString(),
                                                                            style: GoogleFonts.inter(
                                                                              fontSize:
                                                                                  isMobile
                                                                                      ? 10
                                                                                      : 13,
                                                                              fontWeight:
                                                                                  FontWeight.w400,
                                                                              color: const Color(
                                                                                0xFF777777,
                                                                              ),
                                                                              decoration:
                                                                                  TextDecoration.lineThrough,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                width:
                                                                    isMobile
                                                                        ? 200
                                                                        : null,
                                                                // constraints: BoxConstraints(minWidth: 400),
                                                                padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      isMobile
                                                                          ? 20
                                                                          : 20,
                                                                  vertical: 0,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  color: const Color(
                                                                    0xFF326A32,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        30,
                                                                      ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    IconButton(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                            0,
                                                                          ),
                                                                      onPressed:
                                                                          () {},
                                                                      icon: Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color:
                                                                            Colors.white,
                                                                        size:
                                                                            isMobile
                                                                                ? 20
                                                                                : 24,
                                                                      ),
                                                                    ),

                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            isMobile
                                                                                ? 15
                                                                                : 20,
                                                                        vertical:
                                                                            0,
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                        color:
                                                                            Colors.white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              0,
                                                                            ),
                                                                      ),
                                                                      child: Text(
                                                                        cartResponse
                                                                            .items![index]
                                                                            .quantity
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              isMobile
                                                                                  ? 16
                                                                                  : 24,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color(
                                                                            0xFF326A32,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    IconButton(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                            0,
                                                                          ),
                                                                      onPressed:
                                                                          () {},
                                                                      icon: Icon(
                                                                        Icons
                                                                            .add,
                                                                        color:
                                                                            Colors.white,
                                                                        size:
                                                                            isMobile
                                                                                ? 20
                                                                                : 24,
                                                                      ),
                                                                    ),
                                                                    //Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/32c07b56fcedf450d98dd12ef6d9a409a8d074af?placeholderIfAbsent=true', width: 23),
                                                                  ],
                                                                ),
                                                              ),
                                                            
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                    ],
                                                  ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(25),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x40666666),
                                                blurRadius: 2,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Delivery Instructions',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(
                                                    0xFF222222,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Delivery partner will be notified',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(
                                                    0xFF666666,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Expanded(
                                                  child: Row(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    children: [
                                                      _buildInstructionBox(
                                                        title:
                                                            'No Contact Delivery',
                                                        description:
                                                            'Delivery partner will leave\nyour order at your door',
                                                        iconUrl:
                                                            'assets/icons/cart-instructions1.svg',
                                                      ),
                                                      const SizedBox(width: 19),
                                                      _buildInstructionBox(
                                                        title:
                                                            'Do Not Ring The Bell',
                                                        description:
                                                            'Delivery partner will not\nring the bell',
                                                        iconUrl:
                                                            'assets/icons/cart-instructions2.svg',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(24),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x40666666),
                                                blurRadius: 2,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Additional Note',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(
                                                    0xFF222222,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFAAAAAA),
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: Color(
                                                            0xFFAAAAAA,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Color(
                                                        0xFFAAAAAA,
                                                      ), // Change this to whatever highlight color you want
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  // helperText: 'Add your special notes on your order',
                                                  hintText:
                                                      'Add your special notes on your order',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 41,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 23,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x40666666),
                                                blurRadius: 2,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () {},
                                            // () => showDialog(
                                            //   context: context,
                                            //   builder: (_) => const CouponPopup(),
                                            // ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'icons/coupons.svg',
                                                      width: 39,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      'View Coupons & Offers',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize:
                                                                isMobile
                                                                    ? 12
                                                                    : 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                              0xFF444444,
                                                            ),
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: const Color(
                                                    0xFF666666,
                                                  ),
                                                  size: 16,
                                                ),
                                                // Image.network(
                                                //   'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/fd21dedf63ca3d820a922f365814eef0f412a62e?placeholderIfAbsent=true',
                                                //   width: 30,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Container(
                                          width: double.infinity,
                                          // constraints: BoxConstraints(maxWidth: 523),
                                          decoration:
                                              DeliveryTipStyles.cardDecoration,
                                          padding: EdgeInsets.fromLTRB(
                                            21,
                                            19,
                                            21,
                                            19,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 451,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Delivery Partner Tip',
                                                            style:
                                                                DeliveryTipStyles
                                                                    .titleStyle,
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'We thank you for your generosity!',
                                                            style:
                                                                DeliveryTipStyles
                                                                    .subtitleStyle,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 55),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 81,
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 14,
                                                                vertical: 6,
                                                              ),
                                                          decoration:
                                                              DeliveryTipStyles
                                                                  .tippedIndicatorDecoration,
                                                          child: Text(
                                                            'Rs.${tipAmount}\nTipped',
                                                            style:
                                                                DeliveryTipStyles
                                                                    .tippedTextStyle,
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 21),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    _buildTipButton(
                                                      10,
                                                      'https://cdn.builder.io/api/v1/image/assets/TEMP/9e0b9dcb18ad0ca952db09dce74488e3258c7b38?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                    ),
                                                    SizedBox(width: 10),
                                                    _buildTipButton(
                                                      20,
                                                      'https://cdn.builder.io/api/v1/image/assets/TEMP/88f4fcda9e256dac734b77d4d17130120ec46859?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                    ),
                                                    SizedBox(width: 10),
                                                    _buildTipButton(
                                                      30,
                                                      'https://cdn.builder.io/api/v1/image/assets/TEMP/20267f2b60956aebb8a53c7c186f7f3ac23bdc64?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                    ),
                                                    SizedBox(width: 10),
                                                    _buildTipButton(
                                                      50,
                                                      'https://cdn.builder.io/api/v1/image/assets/TEMP/20267f2b60956aebb8a53c7c186f7f3ac23bdc64?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                    ),
                                                    SizedBox(width: 10),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // setState(() {
                                                        //   tipAmount = 0;
                                                        // });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              vertical: 10,
                                                            ),
                                                        child: Text(
                                                          'Cancel',
                                                          style:
                                                              DeliveryTipStyles
                                                                  .cancelStyle,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // _buildDeliveryTipSection(),
                                        const SizedBox(height: 7),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(17),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x40666666),
                                                blurRadius: 2,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Bill Summary',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                        0xFF222222,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 7,
                                                          vertical: 8,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFF034703,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      'Saved ₹88',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 15,
                                                            color: const Color(
                                                              0xFFE7F9E7,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 17),
                                              _buildBillItem(
                                                title: 'Item Total & GST',
                                                originalPrice: '₹96',
                                                price: '₹87',
                                                showInfo: true,
                                              ),
                                              _buildBillItem(
                                                title: 'Handling charge',
                                                originalPrice: '₹15',
                                                price: '₹05',
                                              ),
                                              _buildBillItem(
                                                title: 'Delivery Fee',
                                                originalPrice: '₹35',
                                                price: 'Free',
                                              ),
                                              _buildBillItem(
                                                title: 'Delivery Tip',
                                                price: '₹20',
                                              ),
                                              Container(
                                                height: 1,
                                                color: const Color(0xFFD9D4D4),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                    ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total Bill',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                        0xFF444444,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹192',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                        0xFF444444,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: isMobile ? 10 : 35,
                                            vertical: 18,
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x40666666),
                                                blurRadius: 2,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child:
                                              isaddressadded
                                                  ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                isMobile
                                                                    ? 150
                                                                    : 220,
                                                            child: Text(
                                                              'Other - 13, 8/22,Dr Muthu  Lakshmi Rd, Djdskjskdnamn amnsamns',
                                                              style:
                                                                  GoogleFonts.poppins(
                                                                    color: Color(
                                                                      0xFF666666,
                                                                    ),
                                                                    fontSize:
                                                                        15,
                                                                  ),

                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Row(
                                                            spacing:
                                                                isMobile
                                                                    ? 5
                                                                    : 10,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.string(
                                                                '''
                      <svg width="25" height="27" viewBox="0 0 25 27" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M19.3743 5.76411C21.0365 7.37333 21.9872 9.54538 22.0253 11.821C22.0634 14.0966 21.186 16.2974 19.5785 17.9579L19.3743 18.1624L15.1058 22.2942C14.5642 22.8183 13.8371 23.1234 13.0718 23.1479C12.3065 23.1723 11.5603 22.9141 10.9842 22.4257L10.8393 22.2942L6.56985 18.1615C4.87188 16.5175 3.91797 14.2877 3.91797 11.9628C3.91797 9.63783 4.87188 7.4081 6.56985 5.76411C8.26782 4.12012 10.5708 3.19653 12.9721 3.19653C15.3733 3.19653 17.6763 4.12012 19.3743 5.76411ZM12.9721 9.04072C12.5757 9.04072 12.1833 9.1163 11.8171 9.26315C11.4509 9.41 11.1182 9.62524 10.838 9.89658C10.5577 10.1679 10.3354 10.49 10.1838 10.8446C10.0321 11.1991 9.95404 11.5791 9.95404 11.9628C9.95404 12.3465 10.0321 12.7265 10.1838 13.081C10.3354 13.4355 10.5577 13.7577 10.838 14.029C11.1182 14.3003 11.4509 14.5156 11.8171 14.6624C12.1833 14.8093 12.5757 14.8849 12.9721 14.8849C13.7725 14.8849 14.5401 14.577 15.1061 14.029C15.6721 13.481 15.9901 12.7378 15.9901 11.9628C15.9901 11.1878 15.6721 10.4446 15.1061 9.89658C14.5401 9.34858 13.7725 9.04072 12.9721 9.04072Z" 
          fill="#034703"/>
          </svg>
          
                      ''',
                                                                width: 20,
                                                                height: 22,
                                                                color: Color(
                                                                  0xFF034703,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Change',
                                                                style: GoogleFonts.poppins(
                                                                  color: const Color(
                                                                    0xFF034703,
                                                                  ),
                                                                  fontSize:
                                                                      isMobile
                                                                          ? 12
                                                                          : 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height:
                                                                      1.32, // 29/22
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 27,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                'To Pay',
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      const Color.fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.75,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                '₹92',
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      const Color.fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.85,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              // showAddressPopup(context);
                                                              showConfirmAddress(
                                                                context,
                                                              );
                                                              Navigator.push<
                                                                void
                                                              >(
                                                                context,
                                                                MaterialPageRoute<
                                                                  void
                                                                >(
                                                                  builder:
                                                                      (
                                                                        BuildContext
                                                                        context,
                                                                      ) =>
                                                                          OrderStatus(),
                                                                ),
                                                              );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              // backgroundColor: Colors.green,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      36,
                                                                    ),
                                                              ),
                                                              backgroundColor:
                                                                  const Color(
                                                                    0xFF034703,
                                                                  ),
                                                            ),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        isMobile
                                                                            ? 0
                                                                            : 10,
                                                                  ),
                                                              // width: double.infinity,
                                                              height: 45,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Center(
                                                                child: Text(
                                                                  'Continue to Payment',
                                                                  style: GoogleFonts.poppins(
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        isMobile
                                                                            ? 12
                                                                            : 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        0.81, // 14.5/18
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                  : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        spacing: 20,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.string(
                                                            '''
                      <svg width="25" height="27" viewBox="0 0 25 27" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M19.3743 5.76411C21.0365 7.37333 21.9872 9.54538 22.0253 11.821C22.0634 14.0966 21.186 16.2974 19.5785 17.9579L19.3743 18.1624L15.1058 22.2942C14.5642 22.8183 13.8371 23.1234 13.0718 23.1479C12.3065 23.1723 11.5603 22.9141 10.9842 22.4257L10.8393 22.2942L6.56985 18.1615C4.87188 16.5175 3.91797 14.2877 3.91797 11.9628C3.91797 9.63783 4.87188 7.4081 6.56985 5.76411C8.26782 4.12012 10.5708 3.19653 12.9721 3.19653C15.3733 3.19653 17.6763 4.12012 19.3743 5.76411ZM12.9721 9.04072C12.5757 9.04072 12.1833 9.1163 11.8171 9.26315C11.4509 9.41 11.1182 9.62524 10.838 9.89658C10.5577 10.1679 10.3354 10.49 10.1838 10.8446C10.0321 11.1991 9.95404 11.5791 9.95404 11.9628C9.95404 12.3465 10.0321 12.7265 10.1838 13.081C10.3354 13.4355 10.5577 13.7577 10.838 14.029C11.1182 14.3003 11.4509 14.5156 11.8171 14.6624C12.1833 14.8093 12.5757 14.8849 12.9721 14.8849C13.7725 14.8849 14.5401 14.577 15.1061 14.029C15.6721 13.481 15.9901 12.7378 15.9901 11.9628C15.9901 11.1878 15.6721 10.4446 15.1061 9.89658C14.5401 9.34858 13.7725 9.04072 12.9721 9.04072Z" 
          fill="#034703"/>
          </svg>
          
                      ''',
                                                            width:
                                                                isMobile
                                                                    ? 22
                                                                    : 24,
                                                            height:
                                                                isMobile
                                                                    ? 24
                                                                    : 26,
                                                            color: Color(
                                                              0xFF034703,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Enter your Delivery Address',
                                                            style: GoogleFonts.poppins(
                                                              color:
                                                                  const Color(
                                                                    0xFF034703,
                                                                  ),
                                                              fontSize:
                                                                  isMobile
                                                                      ? 14
                                                                      : 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height:
                                                                  1.32, // 29/22
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 27,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          showAddressPopup(
                                                            context,
                                                          );
                                                          // showConfirmAddress(context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          // backgroundColor: Colors.green,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  36,
                                                                ),
                                                          ),
                                                          backgroundColor:
                                                              const Color(
                                                                0xFF034703,
                                                              ),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Center(
                                                            child: Text(
                                                              'Add Address to Proceed',
                                                              style: GoogleFonts.poppins(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height:
                                                                    0.81, // 14.5/18
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                        ),
                                        // _buildAddressSection(),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              : SingleChildScrollView(
                                // scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 23,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x40666666),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              // () => showDialog(
                                              //   context: context,
                                              //   builder: (_) => const CouponPopup(),
                                              // ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'icons/coupons.svg',
                                                        width: 39,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        'View Coupons & Offers',
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize:
                                                                  isMobile
                                                                      ? 12
                                                                      : 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  const Color(
                                                                    0xFF444444,
                                                                  ),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: const Color(
                                                      0xFF666666,
                                                    ),
                                                    size: 16,
                                                  ),
                                                  // Image.network(
                                                  //   'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/fd21dedf63ca3d820a922f365814eef0f412a62e?placeholderIfAbsent=true',
                                                  //   width: 30,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(22),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x40666666),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                ResponsiveRowColumn(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.network(
                                                          'image',
                                                          width:
                                                              isMobile
                                                                  ? 70
                                                                  : 90,
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'name',
                                                              style: GoogleFonts.poppins(
                                                                fontSize:
                                                                    isMobile
                                                                        ? 15
                                                                        : 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    const Color(
                                                                      0xFF444444,
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'weight',
                                                              style: GoogleFonts.poppins(
                                                                fontSize:
                                                                    isMobile
                                                                        ? 10
                                                                        : 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color:
                                                                    const Color(
                                                                      0xFF666666,
                                                                    ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'price',
                                                                  style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        isMobile
                                                                            ? 15
                                                                            : 19,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: const Color(
                                                                      0xFF444444,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  'originalPrice',
                                                                  style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        isMobile
                                                                            ? 10
                                                                            : 13,
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
                                                    Container(
                                                      width:
                                                          isMobile ? 200 : null,
                                                      // constraints: BoxConstraints(minWidth: 400),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                isMobile
                                                                    ? 20
                                                                    : 20,
                                                            vertical: 0,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFF326A32,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              30,
                                                            ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  0,
                                                                ),
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                              size:
                                                                  isMobile
                                                                      ? 20
                                                                      : 24,
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      isMobile
                                                                          ? 15
                                                                          : 20,
                                                                  vertical: 0,
                                                                ),
                                                            decoration:
                                                                BoxDecoration(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        0,
                                                                      ),
                                                                ),
                                                            child: Text(
                                                              'quantity',
                                                              style: GoogleFonts.poppins(
                                                                fontSize:
                                                                    isMobile
                                                                        ? 16
                                                                        : 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    const Color(
                                                                      0xFF326A32,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          IconButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  0,
                                                                ),
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size:
                                                                  isMobile
                                                                      ? 20
                                                                      : 24,
                                                            ),
                                                          ),
                                                          //Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/32c07b56fcedf450d98dd12ef6d9a409a8d074af?placeholderIfAbsent=true', width: 23),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(height: 24),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            // constraints: BoxConstraints(maxWidth: 523),
                                            decoration:
                                                DeliveryTipStyles
                                                    .cardDecoration,
                                            padding: EdgeInsets.fromLTRB(
                                              21,
                                              19,
                                              21,
                                              19,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 451,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Delivery Partner Tip',
                                                              style:
                                                                  DeliveryTipStyles
                                                                      .titleStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'We thank you for your generosity!',
                                                              style:
                                                                  DeliveryTipStyles
                                                                      .subtitleStyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 55),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            width: 81,
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      14,
                                                                  vertical: 6,
                                                                ),
                                                            decoration:
                                                                DeliveryTipStyles
                                                                    .tippedIndicatorDecoration,
                                                            child: Text(
                                                              'Rs.${tipAmount}\nTipped',
                                                              style:
                                                                  DeliveryTipStyles
                                                                      .tippedTextStyle,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 21),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      _buildTipButton(
                                                        10,
                                                        'https://cdn.builder.io/api/v1/image/assets/TEMP/9e0b9dcb18ad0ca952db09dce74488e3258c7b38?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                      ),
                                                      SizedBox(width: 10),
                                                      _buildTipButton(
                                                        20,
                                                        'https://cdn.builder.io/api/v1/image/assets/TEMP/88f4fcda9e256dac734b77d4d17130120ec46859?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                      ),
                                                      SizedBox(width: 10),
                                                      _buildTipButton(
                                                        30,
                                                        'https://cdn.builder.io/api/v1/image/assets/TEMP/20267f2b60956aebb8a53c7c186f7f3ac23bdc64?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                      ),
                                                      SizedBox(width: 10),
                                                      _buildTipButton(
                                                        50,
                                                        'https://cdn.builder.io/api/v1/image/assets/TEMP/20267f2b60956aebb8a53c7c186f7f3ac23bdc64?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                      ),
                                                      SizedBox(width: 10),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // setState(() {
                                                          //   tipAmount = 0;
                                                          // });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                vertical: 10,
                                                              ),
                                                          child: Text(
                                                            'Cancel',
                                                            style:
                                                                DeliveryTipStyles
                                                                    .cancelStyle,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(17),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x40666666),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Bill Summary',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: const Color(
                                                              0xFF222222,
                                                            ),
                                                          ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 7,
                                                            vertical: 8,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFF034703,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        'Saved ₹88',
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              color:
                                                                  const Color(
                                                                    0xFFE7F9E7,
                                                                  ),
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 17),
                                                _buildBillItem(
                                                  title: 'Item Total & GST',
                                                  originalPrice: '₹96',
                                                  price: '₹87',
                                                  showInfo: true,
                                                ),
                                                _buildBillItem(
                                                  title: 'Handling charge',
                                                  originalPrice: '₹15',
                                                  price: '₹05',
                                                ),
                                                _buildBillItem(
                                                  title: 'Delivery Fee',
                                                  originalPrice: '₹35',
                                                  price: 'Free',
                                                ),
                                                _buildBillItem(
                                                  title: 'Delivery Tip',
                                                  price: '₹20',
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: const Color(
                                                    0xFFD9D4D4,
                                                  ),
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total Bill',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                              0xFF444444,
                                                            ),
                                                          ),
                                                    ),
                                                    Text(
                                                      '₹192',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                          0xFF444444,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(25),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x40666666),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Delivery Instructions',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(
                                                      0xFF222222,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Delivery partner will be notified',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(
                                                      0xFF666666,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Expanded(
                                                    child: Row(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      children: [
                                                        _buildInstructionBox(
                                                          title:
                                                              'No Contact Delivery',
                                                          description:
                                                              'Delivery partner will leave\nyour order at your door',
                                                          iconUrl:
                                                              'assets/icons/cart-instructions1.svg',
                                                        ),
                                                        const SizedBox(
                                                          width: 19,
                                                        ),
                                                        _buildInstructionBox(
                                                          title:
                                                              'Do Not Ring The Bell',
                                                          description:
                                                              'Delivery partner will not\nring the bell',
                                                          iconUrl:
                                                              'assets/icons/cart-instructions2.svg',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(24),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x40666666),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                                BoxShadow(
                                                  color: Color(0x40666666),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Additional Note',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(
                                                      0xFF222222,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xFFAAAAAA,
                                                        ),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          borderSide:
                                                              BorderSide(
                                                                color: Color(
                                                                  0xFFAAAAAA,
                                                                ),
                                                                width: 1.0,
                                                              ),
                                                        ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xFFAAAAAA,
                                                        ), // Change this to whatever highlight color you want
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    // helperText: 'Add your special notes on your order',
                                                    hintText:
                                                        'Add your special notes on your order',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          // _buildDeliveryTipSection(),
                                          const SizedBox(height: 7),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: isMobile ? 10 : 35,
                                              vertical: 18,
                                            ),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x40666666),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child:
                                                isaddressadded
                                                    ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  isMobile
                                                                      ? 150
                                                                      : 220,
                                                              child: Text(
                                                                'Other - 13, 8/22,Dr Muthu  Lakshmi Rd, Djdskjskdnamn amnsamns',
                                                                style: GoogleFonts.poppins(
                                                                  color: Color(
                                                                    0xFF666666,
                                                                  ),
                                                                  fontSize: 15,
                                                                ),

                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Row(
                                                              spacing:
                                                                  isMobile
                                                                      ? 5
                                                                      : 10,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture.string(
                                                                  '''
                      <svg width="25" height="27" viewBox="0 0 25 27" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M19.3743 5.76411C21.0365 7.37333 21.9872 9.54538 22.0253 11.821C22.0634 14.0966 21.186 16.2974 19.5785 17.9579L19.3743 18.1624L15.1058 22.2942C14.5642 22.8183 13.8371 23.1234 13.0718 23.1479C12.3065 23.1723 11.5603 22.9141 10.9842 22.4257L10.8393 22.2942L6.56985 18.1615C4.87188 16.5175 3.91797 14.2877 3.91797 11.9628C3.91797 9.63783 4.87188 7.4081 6.56985 5.76411C8.26782 4.12012 10.5708 3.19653 12.9721 3.19653C15.3733 3.19653 17.6763 4.12012 19.3743 5.76411ZM12.9721 9.04072C12.5757 9.04072 12.1833 9.1163 11.8171 9.26315C11.4509 9.41 11.1182 9.62524 10.838 9.89658C10.5577 10.1679 10.3354 10.49 10.1838 10.8446C10.0321 11.1991 9.95404 11.5791 9.95404 11.9628C9.95404 12.3465 10.0321 12.7265 10.1838 13.081C10.3354 13.4355 10.5577 13.7577 10.838 14.029C11.1182 14.3003 11.4509 14.5156 11.8171 14.6624C12.1833 14.8093 12.5757 14.8849 12.9721 14.8849C13.7725 14.8849 14.5401 14.577 15.1061 14.029C15.6721 13.481 15.9901 12.7378 15.9901 11.9628C15.9901 11.1878 15.6721 10.4446 15.1061 9.89658C14.5401 9.34858 13.7725 9.04072 12.9721 9.04072Z" 
          fill="#034703"/>
          </svg>
          
                      ''',
                                                                  width: 20,
                                                                  height: 22,
                                                                  color: Color(
                                                                    0xFF034703,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Change',
                                                                  style: GoogleFonts.poppins(
                                                                    color: const Color(
                                                                      0xFF034703,
                                                                    ),
                                                                    fontSize:
                                                                        isMobile
                                                                            ? 12
                                                                            : 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        1.32, // 29/22
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 27,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  'To Pay',
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        const Color.fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.75,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '₹92',
                                                                  style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        const Color.fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.85,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                // showAddressPopup(context);
                                                                showConfirmAddress(
                                                                  context,
                                                                );
                                                                Navigator.push<
                                                                  void
                                                                >(
                                                                  context,
                                                                  MaterialPageRoute<
                                                                    void
                                                                  >(
                                                                    builder:
                                                                        (
                                                                          BuildContext
                                                                          context,
                                                                        ) =>
                                                                            OrderStatus(),
                                                                  ),
                                                                );
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                // backgroundColor: Colors.green,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        36,
                                                                      ),
                                                                ),
                                                                backgroundColor:
                                                                    const Color(
                                                                      0xFF034703,
                                                                    ),
                                                              ),
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      isMobile
                                                                          ? 0
                                                                          : 10,
                                                                ),
                                                                // width: double.infinity,
                                                                height: 45,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Continue to Payment',
                                                                    style: GoogleFonts.poppins(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          isMobile
                                                                              ? 12
                                                                              : 16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      height:
                                                                          0.81, // 14.5/18
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                    : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          spacing: 20,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.string(
                                                              '''
                      <svg width="25" height="27" viewBox="0 0 25 27" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M19.3743 5.76411C21.0365 7.37333 21.9872 9.54538 22.0253 11.821C22.0634 14.0966 21.186 16.2974 19.5785 17.9579L19.3743 18.1624L15.1058 22.2942C14.5642 22.8183 13.8371 23.1234 13.0718 23.1479C12.3065 23.1723 11.5603 22.9141 10.9842 22.4257L10.8393 22.2942L6.56985 18.1615C4.87188 16.5175 3.91797 14.2877 3.91797 11.9628C3.91797 9.63783 4.87188 7.4081 6.56985 5.76411C8.26782 4.12012 10.5708 3.19653 12.9721 3.19653C15.3733 3.19653 17.6763 4.12012 19.3743 5.76411ZM12.9721 9.04072C12.5757 9.04072 12.1833 9.1163 11.8171 9.26315C11.4509 9.41 11.1182 9.62524 10.838 9.89658C10.5577 10.1679 10.3354 10.49 10.1838 10.8446C10.0321 11.1991 9.95404 11.5791 9.95404 11.9628C9.95404 12.3465 10.0321 12.7265 10.1838 13.081C10.3354 13.4355 10.5577 13.7577 10.838 14.029C11.1182 14.3003 11.4509 14.5156 11.8171 14.6624C12.1833 14.8093 12.5757 14.8849 12.9721 14.8849C13.7725 14.8849 14.5401 14.577 15.1061 14.029C15.6721 13.481 15.9901 12.7378 15.9901 11.9628C15.9901 11.1878 15.6721 10.4446 15.1061 9.89658C14.5401 9.34858 13.7725 9.04072 12.9721 9.04072Z" 
          fill="#034703"/>
          </svg>
          
                      ''',
                                                              width:
                                                                  isMobile
                                                                      ? 22
                                                                      : 24,
                                                              height:
                                                                  isMobile
                                                                      ? 24
                                                                      : 26,
                                                              color: Color(
                                                                0xFF034703,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Enter your Delivery Address',
                                                              style: GoogleFonts.poppins(
                                                                color:
                                                                    const Color(
                                                                      0xFF034703,
                                                                    ),
                                                                fontSize:
                                                                    isMobile
                                                                        ? 14
                                                                        : 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height:
                                                                    1.32, // 29/22
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 27,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            showAddressPopup(
                                                              context,
                                                            );
                                                            // showConfirmAddress(context);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            // backgroundColor: Colors.green,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    36,
                                                                  ),
                                                            ),
                                                            backgroundColor:
                                                                const Color(
                                                                  0xFF034703,
                                                                ),
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 45,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Center(
                                                              child: Text(
                                                                'Add Address to Proceed',
                                                                style: GoogleFonts.poppins(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height:
                                                                      0.81, // 14.5/18
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                          ),
                                          // _buildAddressSection(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ),
                  ),
                  AppDownloadSection(),
                  CategoriesSection(),
                  FooterSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTipButton(int amount, String imageUrl) {
    final bool isSelected = tipAmount == amount.toString();
    return GestureDetector(
      onTap: () {
        tipAmount = amount.toString();

        // widget.onTipSelected?.call(amount);
      },
      child: Container(
        width: 83,
        height: 41,
        decoration:
            isSelected
                ? DeliveryTipStyles.tipAmountDecoration
                : DeliveryTipStyles.tipButtonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isSelected) ...[
              Image.network(
                imageUrl,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 7),
            ],
            Text('₹$amount', style: DeliveryTipStyles.tipAmountStyle),
          ],
        ),
      ),
    );
  }

  void showAddressPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 400,
            // height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Search Field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFF034703),
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: "Search a new address",
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Address List
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 6,
                      radius: const Radius.circular(8),

                      child: ListView.separated(
                        itemCount: addressList.length,
                        separatorBuilder:
                            (_, __) => Divider(color: Colors.grey.shade500),
                        itemBuilder: (context, index) {
                          final item = addressList[index];
                          return ListTile(
                            leading: SvgPicture.asset(
                              'icons/location.svg',
                              color: Color(0xFF034703),
                              width: 30,
                            ),
                            title: Text(
                              item.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              item.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              // Handle tap
                              Navigator.of(context).pop();
                            },
                          );
                        },
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
  }

  void showConfirmAddress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // allows tap outside to close
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 300,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('icons/check_address.png', width: 65, height: 65),
                SizedBox(height: 16),
                Text(
                  'Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your address has been saved',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF034703),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(double.infinity, 45),
                  ),
                  onPressed: () {
                    // Handle button action
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ResponsiveRowColumn extends StatelessWidget {
  final List<Widget> children;
  ResponsiveRowColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return isMobile
        ? Column(children: children)
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        );
  }
}

Widget _buildInstructionBox({
  required String title,
  required String description,
  required String iconUrl,
}) {
  return Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFAAAAAA)),
    ),
    child: Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.network(iconUrl, width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class DeliveryTipStyles {
  static const Color primaryGreen = Color(0xFF24BB0C);
  static const Color darkGreen = Color(0xFF034703);
  static const Color lightGreen = Color(0xFFE0FADC);
  static const Color textDark = Color(0xFF222222);
  static const Color textGrey = Color(0xFF444444);
  static const Color borderGrey = Color(0xFFCCCCCC);
  static const Color errorRed = Color(0xFFE21414);

  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(color: Color(0x40666666), blurRadius: 2, offset: Offset(0, 1)),
    ],
  );

  static BoxDecoration tipButtonDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: borderGrey, width: 1),
  );

  static BoxDecoration tipAmountDecoration = BoxDecoration(
    color: lightGreen,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: darkGreen, width: 1),
  );

  static BoxDecoration tippedIndicatorDecoration = BoxDecoration(
    color: lightGreen,
    borderRadius: BorderRadius.circular(7),
  );

  static TextStyle titleStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textDark,
    height: 1,
  );

  static TextStyle subtitleStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryGreen,
    height: 1.3,
  );

  static TextStyle tipAmountStyle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textGrey,
  );

  static TextStyle cancelStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: errorRed,
  );

  static TextStyle tippedTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textGrey,
    height: 1.2,
  );
}

Widget _buildBillItem({
  required String title,
  required String price,
  String? originalPrice,
  bool showInfo = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: showInfo ? 17 : 16,
                fontWeight: showInfo ? FontWeight.w500 : FontWeight.w400,
                color:
                    showInfo
                        ? const Color(0xFF222222)
                        : const Color(0xFF666666),
              ),
            ),
            if (showInfo)
              Container(
                width: 11,
                height: 11,
                margin: const EdgeInsets.only(left: 2),
                decoration: const BoxDecoration(
                  color: Color(0xFFA9D046),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'i',
                    style: TextStyle(fontSize: 7, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        Row(
          children: [
            if (originalPrice != null) ...[
              Text(
                originalPrice,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF777777),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 7),
            ],
            Text(
              price,
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
