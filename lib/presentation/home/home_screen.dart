import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/model/category/product_style_model.dart';

import 'package:selorgweb_main/model/home/banner_model.dart';

import 'package:selorgweb_main/model/home/grab_essentials_model.dart';
import 'package:selorgweb_main/presentation/category/categories_screen.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/home/home_bloc.dart';
import 'package:selorgweb_main/presentation/home/home_event.dart';
import 'package:selorgweb_main/presentation/home/home_state.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_screen.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_menu.dart';

import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/widgets/bottom_app_bar_widget.dart';
import 'package:selorgweb_main/widgets/bottom_categories_bar_widget.dart';
import 'package:selorgweb_main/widgets/network_image.dart';
import 'package:selorgweb_main/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static GrabandEssential grabandEssential = GrabandEssential();
  static MainCategory mainCategory = MainCategory();

  static TextEditingController searchController = TextEditingController();

  static List<Category> categories = [];
  static List<BannerList> festivalbanners = [];
  static List<BannerList> dailybanners = [];
  static List<BannerList> offerbanners = [];
  static ProductStyleResponse freshFruitsresponse = ProductStyleResponse();
  static ProductStyleResponse groceryEssentialsResponse =
      ProductStyleResponse();
  static ProductStyleResponse nutsDriedFruitsResponse = ProductStyleResponse();
  static ProductStyleResponse riceCerealsResponse = ProductStyleResponse();

  static PageController pageController = PageController(initialPage: 0);
  static int currentPage = 0;
  // static Timer? timer;
  static List<BannerList> loopingBanners = [];
  static bool addButtonClicked = false;
  static int selectedIndexes = 0;
  static int selectedProductIndexes = 0;
  static int productVarientIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CounterCubit()),
        // BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GrabandEssentialsLoadedState) {
            debugPrint(state.grabandEssential.message);
            grabandEssential = state.grabandEssential;
          } else if (state is BannerLoadedState) {
            festivalbanners = [];
            dailybanners = [];
            offerbanners = [];
            debugPrint(state.banners.message);
            for (int i = 0; i < state.banners.data!.length; i++) {
              if (state.banners.data![i].bannerType == "festival") {
                festivalbanners.add(state.banners.data![i]);
              } else if (state.banners.data![i].bannerType == "dailyUsage") {
                dailybanners.add(state.banners.data![i]);
              } else if (state.banners.data![i].bannerType == "offer") {
                offerbanners.add(state.banners.data![i]);
              }
            }
          } else if (state is OrganicFreshFruitsLoadedState) {
            freshFruitsresponse = ProductStyleResponse();
            // freshFruitsList = state.productStyleResponse.data ?? [];
            freshFruitsresponse = state.productStyleResponse;
          } else if (state is GroceryEssentialsLoadedState) {
            // groceryEssentials = state.productStyleResponse.data ?? [];
            groceryEssentialsResponse = ProductStyleResponse();
            groceryEssentialsResponse = state.productStyleResponse;
          } else if (state is NutsDriedFruitsLoadedState) {
            // nutsDriedFruits = state.productStyleResponse.data ?? [];
            nutsDriedFruitsResponse = ProductStyleResponse();
            nutsDriedFruitsResponse = state.productStyleResponse;
          } else if (state is RiceCerealsLoadedState) {
            //  riceCerealsList = state.productStyleResponse.data ?? [];
            riceCerealsResponse = ProductStyleResponse();
            riceCerealsResponse = state.productStyleResponse;
          } else if (state is MainCategoryLoadedState) {
            mainCategory = state.mainCategory;
            debugPrint(mainCategory.message);
          } else if (state is CategoryLoadedState) {
            categories = state.categories;
            debugPrint("CategoryLoadedState");
          } else if (state is AddButtonClickedState) {
            // noOfIteminCart = noOfIteminCart + 1;
            // context.read<CounterCubit>().increment();
            addButtonClicked = state.isSelected;
            selectedIndexes = state.selectedIndexes;
            if (state.type == "screen") {
              state
                  .response
                  .data![state.selectedIndexes]
                  .variants![0]
                  .cartQuantity = (state
                          .response
                          .data![state.selectedIndexes]
                          .variants![0]
                          .cartQuantity ??
                      0) +
                  1;
              context.read<HomeBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId:
                      state.response.data![state.selectedIndexes].productId ??
                      "",
                  quantity: 1,
                  variantLabel:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                              .response
                              .data![state.selectedIndexes]
                              .variants![productVarientIndex]
                              .label
                              .toString()
                          : state
                              .response
                              .data![state.selectedIndexes]
                              .variants![0]
                              .label
                              .toString(),
                  imageUrl:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                              .response
                              .data![state.selectedIndexes]
                              .variants![productVarientIndex]
                              .imageUrl
                              .toString()
                          : state
                              .response
                              .data![state.selectedIndexes]
                              .variants![0]
                              .imageUrl
                              .toString(),
                  price:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                                  .response
                                  .data![state.selectedIndexes]
                                  .variants![productVarientIndex]
                                  .price ??
                              0
                          : state
                                  .response
                                  .data![state.selectedIndexes]
                                  .variants![0]
                                  .price ??
                              0,
                  discountPrice:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                                  .response
                                  .data![state.selectedIndexes]
                                  .variants![productVarientIndex]
                                  .discountPrice ??
                              0
                          : state
                                  .response
                                  .data![state.selectedIndexes]
                                  .variants![0]
                                  .discountPrice ??
                              0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else if (state.type == "dialog") {
              state
                  .response
                  .data![0]
                  .variants![state.selectedIndexes]
                  .cartQuantity = (state
                          .response
                          .data![0]
                          .variants![state.selectedIndexes]
                          .cartQuantity ??
                      0) +
                  1;
            }
          } else if (state is ItemAddedToCartInHomeScreenState) {
            //   context.read<CounterCubit>().increment(1);
            context.read<HomeBloc>().add(GetCartCountEvent(userId: userId));
          } else if (state is CartDataSuccess) {
            // context.read<CounterCubit>().decrement(state.noOfItems);
            noOfIteminCart = state.noOfItems;
            context.read<HomeBloc>().add(
              GetScreenEvent(cartcount: state.noOfItems, index: 0),
            );
            context.read<CounterCubit>().increment(state.noOfItems);
            noOfIteminCart = state.noOfItems;
          } else if (state is RemoveButtonClickedState) {
            // noOfIteminCart = noOfIteminCart - 1;
            if (state.type == "screen") {
              state
                          .response
                          .data![state.selectedIndexes]
                          .variants![0]
                          .cartQuantity ==
                      0
                  ? null
                  : state
                      .response
                      .data![state.selectedIndexes]
                      .variants![0]
                      .cartQuantity = (state
                              .response
                              .data![state.selectedIndexes]
                              .variants![0]
                              .cartQuantity ??
                          0) -
                      1;
              context.read<HomeBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId:
                      state.response.data![state.selectedIndexes].productId ??
                      "",
                  variantLabel:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                              .response
                              .data![state.selectedIndexes]
                              .variants![productVarientIndex]
                              .label
                              .toString()
                          : state
                              .response
                              .data![state.selectedIndexes]
                              .variants![0]
                              .label
                              .toString(),
                  quantity: 1,
                  deliveryTip: 0,
                  handlingCharges: 0,
                ),
              );
            } else if (state.type == "dialog") {
              state
                  .response
                  .data![0]
                  .variants![state.selectedIndexes]
                  .cartQuantity = (state
                          .response
                          .data![0]
                          .variants![state.selectedIndexes]
                          .cartQuantity ??
                      0) -
                  1;
            }
          } else if (state is ItemRemovedToCartState) {
            context.read<CounterCubit>().decrement(1);
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   location == "No Location Found"
            //       ? context.read<HomeBloc>().add(GetLocationEvent())
            //       : null;
            // });
            context.read<HomeBloc>().add(GetCartCountEvent(userId: userId));
            context.read<HomeBloc>().add(GrabAndGoEvent());
            context.read<HomeBloc>().add(GetBannerEvent());
            context.read<HomeBloc>().add(GetMainCategoryDataEvent());
            context.read<HomeBloc>().add(GetCategoryDataEvent());
            context.read<HomeBloc>().add(
              GetOrganicFruitsEvent(
                mainCatId: "676431a2edae32578ae6d220",
                subCatId: "676ad87c756fa03a5d0d0616",
                mobileNo: phoneNumber,
              ),
            );
            context.read<HomeBloc>().add(
              GetGroceryEssentialsEvent(
                subCatId: "676b624a84dd76eac5d33a3e",
                mobileNo: phoneNumber,
              ),
            );
            context.read<HomeBloc>().add(
              GetNutsDriedFruitsEvent(
                subCatId: "676b62c484dd76eac5d33a46",
                mobileNo: phoneNumber,
              ),
            );
            context.read<HomeBloc>().add(
              GetRiceCerealsEvent(
                mainCatId: "676431ddedae32578ae6d222",
                subCatId: "676b60bd84dd76eac5d33a2a",
                mobileNo: phoneNumber,
              ),
            );

            // timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
            //   if (pageController.hasClients) {
            //     currentPage++;

            //     if (currentPage == festivalbanners.length + 1) {
            //       // If reached the fake last item, jump to first real image instantly
            //       pageController.jumpToPage(1);
            //       currentPage = 1;
            //     } else {
            //       // Otherwise, move to the next image
            //       pageController.animateToPage(
            //         currentPage,
            //         duration: const Duration(milliseconds: 500),
            //         curve: Curves.easeInOut,
            //       );
            //     }
            //   }
            // });
          }
          final isTablet = MediaQuery.of(context).size.width < 991;
          final isMobile = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            backgroundColor: appbackgroundColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      HeaderWidget(),
                      Container(
                        constraints: BoxConstraints(maxHeight: 300),
                        color: appbackgroundColor,
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Stack(
                          children: [
                            Container(
                              constraints: BoxConstraints(maxHeight: 150),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Color(0xFF052E16),
                              ),
                              child: const Row(children: []),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 0),
                                    Text(
                                      'Grab & Go essentials for you!',
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Visibility(
                                      visible: !(grabandEssential.data == null),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          spacing:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.03,
                                          children: [
                                            if (grabandEssential.data != null)
                                              for (
                                                int i = 0;
                                                i <
                                                    grabandEssential
                                                        .data!
                                                        .length;
                                                i++
                                              )
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => ProductListMenuScreen(
                                                              title:
                                                                  grabandEssential
                                                                      .data![i]
                                                                      .name ??
                                                                  "",
                                                              id:
                                                                  grabandEssential
                                                                      .data![i]
                                                                      .id ??
                                                                  "",
                                                              isMainCategory:
                                                                  i == 2
                                                                      ? false
                                                                      : true,
                                                              mainCatId:
                                                                  i == 0
                                                                      ? "676431a2edae32578ae6d220"
                                                                      : i == 1
                                                                      ? "676431ddedae32578ae6d222"
                                                                      : "",
                                                              isCategory:
                                                                  i == 2
                                                                      ? true
                                                                      : false,
                                                              catId:
                                                                  "6759448c66818180ad94a960",
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    // clipBehavior: Clip.hardEdge,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => ProductListMenuScreen(
                                                                    title:
                                                                        grabandEssential
                                                                            .data![i]
                                                                            .name ??
                                                                        "",
                                                                    id:
                                                                        grabandEssential
                                                                            .data![i]
                                                                            .id ??
                                                                        "",
                                                                    isMainCategory:
                                                                        i == 2
                                                                            ? false
                                                                            : true,
                                                                    mainCatId:
                                                                        i == 0
                                                                            ? "676431a2edae32578ae6d220"
                                                                            : i ==
                                                                                1
                                                                            ? "676431ddedae32578ae6d222"
                                                                            : "",
                                                                    isCategory:
                                                                        i == 2
                                                                            ? true
                                                                            : false,
                                                                    catId:
                                                                        "6759448c66818180ad94a960",
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  0,
                                                                ),
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            width:
                                                                isMobile
                                                                    ? MediaQuery.of(
                                                                          context,
                                                                        ).size.width *
                                                                        0.3
                                                                    : isTablet
                                                                    ? MediaQuery.of(
                                                                          context,
                                                                        ).size.width *
                                                                        0.25
                                                                    : 256,
                                                            height:
                                                                isMobile
                                                                    ? 100
                                                                    : constraints
                                                                            .maxWidth <
                                                                        991
                                                                    ? 120
                                                                    : 200,
                                                            decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color:
                                                                      Colors
                                                                          .grey,
                                                                  offset:
                                                                      Offset(
                                                                        1,
                                                                        3,
                                                                      ),
                                                                  blurRadius:
                                                                      10,
                                                                ),
                                                              ],
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                              image: DecorationImage(
                                                                fit:
                                                                    BoxFit
                                                                        .fitWidth,
                                                                image: NetworkImage(
                                                                  grabandEssential
                                                                          .data![i]
                                                                          .imageUrl ??
                                                                      "",
                                                                  // width: 256,
                                                                  // height:
                                                                  //     double
                                                                  //         .infinity,
                                                                  // height:
                                                                  //     constraints.maxWidth <
                                                                  //             1124
                                                                  //         ? 150
                                                                  //         : 200,
                                                                  // fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                            child: SizedBox(),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 50,

                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                    top: 4,
                                                                    bottom: 4,
                                                                    left: 15,
                                                                    right: 15,
                                                                  ),
                                                              child: Text(
                                                                grabandEssential
                                                                        .data![i]
                                                                        .name ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      isMobile
                                                                          ? 8
                                                                          : isTablet
                                                                          ? 12
                                                                          : 15,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        constraints: BoxConstraints(maxWidth: 1280),
                        child: Column(
                          // spacing: 20,
                          children: [
                            festivalbanners.isEmpty
                                ? SizedBox()
                                : Container(
                                  constraints: BoxConstraints(maxWidth: 1280),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 10 : 60,
                                    ),
                                    child: CarouselSlider.builder(
                                      itemCount: festivalbanners.length,
                                      options: CarouselOptions(
                                        aspectRatio: 16 / 9,
                                        height:
                                            isMobile
                                                ? MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.6
                                                : isTablet
                                                ? MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.6
                                                : MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.6,
                                        autoPlay: true,
                                        scrollPhysics:
                                            FixedExtentScrollPhysics(),
                                        autoPlayInterval: const Duration(
                                          seconds: 3,
                                        ),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        enlargeCenterPage:
                                            true, // Gives a nice zoom effect
                                        viewportFraction:
                                            isMobile
                                                ? 0.7
                                                : isTablet
                                                ? 0.4
                                                : 0.4, // Makes items slightly smaller than screen width
                                        scrollDirection: Axis.horizontal,
                                        enableInfiniteScroll:
                                            true, // Allows continuous looping
                                        onPageChanged: (index, reason) {
                                          // setState(() {
                                          //   _currentIndex = index;
                                          // });
                                        },
                                      ),
                                      itemBuilder: (context, index, realIndex) {
                                        return InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder:
                                            //         (context) => BannerScreen(
                                            //           bannerId:
                                            //               festivalbanners[index]
                                            //                   .id ??
                                            //               "",
                                            //         ),
                                            //   ),
                                            // ).then((value) {
                                            //   if (!context.mounted) return;
                                            //   context.read<HomeBloc>().add(
                                            //     GetCartCountEvent(
                                            //       userId: userId,
                                            //     ),
                                            //   );
                                            //   // context
                                            //   //     .read<CounterCubit>()
                                            //   //     .decrement(cartCount);
                                            //   context
                                            //       .read<CounterCubit>()
                                            //       .increment(cartCount);
                                            //   noOfIteminCart = cartCount;
                                            // });
                                            debugPrint(
                                              festivalbanners[index].id,
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: ImageNetwork(
                                                image:
                                                    festivalbanners[index]
                                                        .imageUrl ??
                                                    "",
                                                width:
                                                    isMobile
                                                        ? MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            0.6
                                                        : isTablet
                                                        ? MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            0.3
                                                        : MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            0.3,
                                                height:
                                                    isMobile
                                                        ? MediaQuery.of(
                                                              context,
                                                            ).size.height *
                                                            0.6
                                                        : isTablet
                                                        ? MediaQuery.of(
                                                              context,
                                                            ).size.height *
                                                            0.5
                                                        : MediaQuery.of(
                                                              context,
                                                            ).size.height *
                                                            0.6,
                                                fitWeb: BoxFitWeb.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 150),
                            //   child: SizedBox(
                            //     height: 180,
                            //     child: ListView.builder(
                            //       scrollDirection: Axis.horizontal,
                            //       itemCount: dailybanners.length,
                            //       itemBuilder: (context, index) {
                            //         return InkWell(
                            //           onTap: () {
                            //             // Navigator.push(context, MaterialPageRoute(
                            //             //   builder: (context) {
                            //             //     return BannerScreen(
                            //             //         bannerId:
                            //             //             dailybanners[index].id ?? "");
                            //             //   },
                            //             // ));
                            //             // debugPrint(dailybanners[index].id);
                            //             // //  Navigator.pushNamed(context, '/banner');
                            //           },
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(right: 12),
                            //             child: Container(
                            //               width: 370,
                            //               height: 220,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(8),
                            //               ),
                            //               child: ClipRRect(
                            //                 borderRadius: BorderRadius.circular(8),
                            //                 child: Image.network(
                            //                   dailybanners[index].imageUrl ?? "",
                            //                   fit: BoxFit.cover,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 60,
                              ),
                              child: Column(
                                spacing: 20,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return CategoriesScreen();
                                              },
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'See All',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF034703),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 14,
                                              color: appColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   spacing: 16,
                                  //   children: [
                                  //     if (mainCategory.data != null)
                                  //       for (
                                  //         int i = 0;
                                  //         i < mainCategory.data!.length;
                                  //         i++
                                  //       )
                                  //         Expanded(
                                  //           child: InkWell(
                                  //             onTap: () {
                                  //               // Navigator.push(
                                  //               //   context,
                                  //               //   MaterialPageRoute(
                                  //               //     builder:
                                  //               //         (context) =>
                                  //               //             ProductListMenuScreen(
                                  //               //               title:
                                  //               //                   mainCategory
                                  //               //                       .data![i]
                                  //               //                       .name ??
                                  //               //                   "",
                                  //               //               id:
                                  //               //                   mainCategory
                                  //               //                       .data![i]
                                  //               //                       .id ??
                                  //               //                   "",
                                  //               //               isMainCategory:
                                  //               //                   true,
                                  //               //               mainCatId:
                                  //               //                   mainCategory
                                  //               //                       .data![i]
                                  //               //                       .id ??
                                  //               //                   "",
                                  //               //               isCategory: false,
                                  //               //               catId: "",
                                  //               //             ),
                                  //               //   ),
                                  //               // );
                                  //             },
                                  //             child: Column(
                                  //               children: [
                                  //                 Container(
                                  //                   height: 130,
                                  //                   decoration: BoxDecoration(
                                  //                     color: const Color(0xFFE5EEC3),
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(5),
                                  //                     boxShadow: [
                                  //                       BoxShadow(
                                  //                         color: greyColor,
                                  //                         blurRadius: 4,
                                  //                         offset: const Offset(0, 0),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                   // child: Center(
                                  //                   //   child: Image.network(
                                  //                   //     mainCategory
                                  //                   //             .data![i]
                                  //                   //             .imageUrl ??
                                  //                   //         "",
                                  //                   //     fit: BoxFit.contain,
                                  //                   //   ),
                                  //                   // ),
                                  //                 ),
                                  //                 const SizedBox(height: 8),
                                  //                 Text(
                                  //                   mainCategory.data![i].name ?? "",
                                  //                   textAlign: TextAlign.center,
                                  //                   style: const TextStyle(
                                  //                     fontSize: 13,
                                  //                     fontWeight: FontWeight.w600,
                                  //                     color: Color(0xFF222222),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //   ],
                                  // ),
                                  isTablet
                                      ? Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        spacing: 20,
                                        runSpacing: 20,
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
                                                      i <
                                                          mainCategory
                                                              .data!
                                                              .length;
                                                      i++
                                                    )
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            debugPrint(
                                                              "*******",
                                                            );
                                                            // title =
                                                            //     mainCategory
                                                            //         .data![i]
                                                            //         .name ??
                                                            //     "";
                                                            // id =
                                                            //     mainCategory
                                                            //         .data![i]
                                                            //         .id ??
                                                            //     "";
                                                            // isMainCategory =
                                                            //     true;
                                                            // mainCatId =
                                                            //     mainCategory
                                                            //         .data![i]
                                                            //         .id ??
                                                            //     "";
                                                            // isCategory = false;
                                                            // catId = "";
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (
                                                            //           context,
                                                            //         ) => ProductListMenuScreen(
                                                            //           title:
                                                            //               mainCategory
                                                            //                   .data![i]
                                                            //                   .name ??
                                                            //               "",
                                                            //           id:
                                                            //               mainCategory
                                                            //                   .data![i]
                                                            //                   .id ??
                                                            //               "",
                                                            //           isMainCategory:
                                                            //               true,
                                                            //           mainCatId:
                                                            //               mainCategory
                                                            //                   .data![i]
                                                            //                   .id ??
                                                            //               "",
                                                            //           isCategory:
                                                            //               false,
                                                            //           catId: "",
                                                            //         ),
                                                            //   ),
                                                            // ).then((value) {
                                                            //   if (!context
                                                            //       .mounted) {
                                                            //     return;
                                                            //   }
                                                            //   context
                                                            //       .read<
                                                            //         HomeBloc
                                                            //       >()
                                                            //       .add(
                                                            //         GetCartCountEvent(
                                                            //           userId:
                                                            //               userId,
                                                            //         ),
                                                            //       );
                                                            //   // context
                                                            //   //     .read<CounterCubit>()
                                                            //   //     .decrement(cartCount);
                                                            //   context
                                                            //       .read<
                                                            //         CounterCubit
                                                            //       >()
                                                            //       .increment(
                                                            //         cartCount,
                                                            //       );
                                                            //   noOfIteminCart =
                                                            //       cartCount;
                                                            // });
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  debugPrint(
                                                                    "******",
                                                                  );
                                                                },
                                                                child: Container(
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
                                                                        blurRadius:
                                                                            3,
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
                                                                            mainCategory.data![i].imageUrl ??
                                                                            "",
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            double.infinity,
                                                                        fit:
                                                                            BoxFit.contain,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                mainCategory
                                                                        .data![i]
                                                                        .name ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
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
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 130,
                                                              width: null,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    const Color(
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
                                                                    blurRadius:
                                                                        3,
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
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              categories[i]
                                                                      .name ??
                                                                  "",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      i <
                                                          mainCategory
                                                              .data!
                                                              .length;
                                                      i++
                                                    )
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            debugPrint(
                                                              "*******",
                                                            );
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
                                                            isMainCategory =
                                                                true;
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
                                                                    ) => ProductListMenuScreen(
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
                                                              if (!context
                                                                  .mounted) {
                                                                return;
                                                              }
                                                              context
                                                                  .read<
                                                                    HomeBloc
                                                                  >()
                                                                  .add(
                                                                    GetCartCountEvent(
                                                                      userId:
                                                                          userId,
                                                                    ),
                                                                  );
                                                              // context
                                                              //     .read<CounterCubit>()
                                                              //     .decrement(cartCount);
                                                              context
                                                                  .read<
                                                                    CounterCubit
                                                                  >()
                                                                  .increment(
                                                                    cartCount,
                                                                  );
                                                              noOfIteminCart =
                                                                  cartCount;
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
                                                                      blurRadius:
                                                                          3,
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
                                                                      height:
                                                                          100,
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
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                mainCategory
                                                                        .data![i]
                                                                        .name ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
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
                                                          onTap: () {
                                                            debugPrint(
                                                              categories[i]
                                                                      .name ??
                                                                  "",
                                                            );
                                                            title =
                                                                categories[i]
                                                                    .name ??
                                                                "";
                                                            id =
                                                                categories[i]
                                                                    .id ??
                                                                "";
                                                            isMainCategory =
                                                                false;
                                                            mainCatId = "";
                                                            isCategory = true;
                                                            catId =
                                                                categories[i]
                                                                    .id ??
                                                                "";
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (
                                                                      context,
                                                                    ) => ProductListMenuScreen(
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
                                                                      mainCatId:
                                                                          "",
                                                                      isCategory:
                                                                          true,
                                                                      catId:
                                                                          categories[i]
                                                                              .id ??
                                                                          "",
                                                                    ),
                                                              ),
                                                            ).then((value) {
                                                              if (!context
                                                                  .mounted) {
                                                                return;
                                                              }
                                                              context
                                                                  .read<
                                                                    HomeBloc
                                                                  >()
                                                                  .add(
                                                                    GetCartCountEvent(
                                                                      userId:
                                                                          userId,
                                                                    ),
                                                                  );
                                                              // context
                                                              //     .read<CounterCubit>()
                                                              //     .decrement(cartCount);
                                                              context
                                                                  .read<
                                                                    CounterCubit
                                                                  >()
                                                                  .increment(
                                                                    cartCount,
                                                                  );
                                                              noOfIteminCart =
                                                                  cartCount;
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
                                                                      blurRadius:
                                                                          3,
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
                                                                      height:
                                                                          100,
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
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                categories[i]
                                                                        .name ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
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
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        spacing: 20,
                                        runSpacing: 20,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
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
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 130,
                                                              // width: 130,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    const Color(
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
                                                                    blurRadius:
                                                                        3,
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
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              categories[i]
                                                                      .name ??
                                                                  "",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
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
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
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
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 130,
                                                              // width: 130,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    const Color(
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
                                                                    blurRadius:
                                                                        3,
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
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              categories[i]
                                                                      .name ??
                                                                  "",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                          onTap: () {
                                                            debugPrint(
                                                              categories[i]
                                                                      .name ??
                                                                  "",
                                                            );
                                                            title =
                                                                categories[i]
                                                                    .name ??
                                                                "";
                                                            id =
                                                                categories[i]
                                                                    .id ??
                                                                "";
                                                            isMainCategory =
                                                                false;
                                                            mainCatId = "";
                                                            isCategory = true;
                                                            catId =
                                                                categories[i]
                                                                    .id ??
                                                                "";
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (
                                                                      context,
                                                                    ) => ProductListMenuScreen(
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
                                                                      mainCatId:
                                                                          "",
                                                                      isCategory:
                                                                          true,
                                                                      catId:
                                                                          categories[i]
                                                                              .id ??
                                                                          "",
                                                                    ),
                                                              ),
                                                            ).then((value) {
                                                              if (!context
                                                                  .mounted) {
                                                                return;
                                                              }
                                                              context
                                                                  .read<
                                                                    HomeBloc
                                                                  >()
                                                                  .add(
                                                                    GetCartCountEvent(
                                                                      userId:
                                                                          userId,
                                                                    ),
                                                                  );
                                                              // context
                                                              //     .read<CounterCubit>()
                                                              //     .decrement(cartCount);
                                                              context
                                                                  .read<
                                                                    CounterCubit
                                                                  >()
                                                                  .increment(
                                                                    cartCount,
                                                                  );
                                                              noOfIteminCart =
                                                                  cartCount;
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
                                                                      blurRadius:
                                                                          3,
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
                                                                      height:
                                                                          100,
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
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                categories[i]
                                                                        .name ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
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
                                                          onTap: () {
                                                            title =
                                                                categories[i]
                                                                    .name ??
                                                                "";
                                                            id =
                                                                categories[i]
                                                                    .id ??
                                                                "";
                                                            isMainCategory =
                                                                false;
                                                            mainCatId = "";
                                                            isCategory = true;
                                                            catId =
                                                                categories[i]
                                                                    .id ??
                                                                "";
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (
                                                                      context,
                                                                    ) => ProductListMenuScreen(
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
                                                                      mainCatId:
                                                                          "",
                                                                      isCategory:
                                                                          true,
                                                                      catId:
                                                                          categories[i]
                                                                              .id ??
                                                                          "",
                                                                    ),
                                                              ),
                                                            ).then((value) {
                                                              if (!context
                                                                  .mounted) {
                                                                return;
                                                              }
                                                              context
                                                                  .read<
                                                                    HomeBloc
                                                                  >()
                                                                  .add(
                                                                    GetCartCountEvent(
                                                                      userId:
                                                                          userId,
                                                                    ),
                                                                  );
                                                              // context
                                                              //     .read<CounterCubit>()
                                                              //     .decrement(cartCount);
                                                              context
                                                                  .read<
                                                                    CounterCubit
                                                                  >()
                                                                  .increment(
                                                                    cartCount,
                                                                  );
                                                              noOfIteminCart =
                                                                  cartCount;
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
                                                                      blurRadius:
                                                                          3,
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
                                                                      height:
                                                                          100,
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
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                categories[i]
                                                                        .name ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
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
                            SizedBox(height: 50),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 150),
                            //   child: Row(
                            //     spacing: 20,
                            //     children: [
                            //       Expanded(
                            //         child: Container(
                            //           width: 100,
                            //           height:
                            //               MediaQuery.of(context).size.height * 0.6,
                            //           decoration: BoxDecoration(
                            //             color: redColor,
                            //             borderRadius: BorderRadius.circular(5),
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //           width: 100,
                            //           height:
                            //               MediaQuery.of(context).size.height * 0.6,
                            //           decoration: BoxDecoration(
                            //             color: appColor,
                            //             borderRadius: BorderRadius.circular(5),
                            //           ),
                            //           child: ImageNetwork(
                            //             image:
                            //                 "https://selorg-new-bgi.s3.us-east-1.amazonaws.com/Banners/For+lanch/Year+End+sale.png",
                            //             width:
                            //                 MediaQuery.of(context).size.height * 0.77,
                            //             height:
                            //                 MediaQuery.of(context).size.height * 0.6,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            if (offerbanners.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 20 : 60,
                                ),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 1280),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(),
                                  width: double.infinity,
                                  // color: appColor,
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) {
                                      //     return BannerScreen(
                                      //         bannerId: offerbanners[0].id ?? "");
                                      //   },
                                      // ));
                                      // debugPrint(offerbanners[0].id ?? "");
                                    },
                                    child: Image.asset(
                                      "banner.png",
                                      width: double.infinity,
                                      height: null,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 60,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  spacing: 20,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Organic & Fresh Fruits',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: blackColor,
                                      ),
                                    ),
                                    if (freshFruitsresponse.data != null)
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          spacing: 16,
                                          children: [
                                            for (
                                              int i = 0;
                                              i <
                                                  freshFruitsresponse
                                                      .data!
                                                      .length;
                                              i++
                                            )
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProductDetailsScreen(
                                                          productId:
                                                              freshFruitsresponse
                                                                  .data![i]
                                                                  .productId ??
                                                              "",
                                                          screenType: "back",
                                                        );
                                                      },
                                                    ),
                                                  ).then((value) {
                                                    if (!context.mounted) {
                                                      return;
                                                    }
                                                    context.read<HomeBloc>().add(
                                                      GetOrganicFruitsEvent(
                                                        mainCatId:
                                                            "676431a2edae32578ae6d220",
                                                        subCatId:
                                                            "676ad87c756fa03a5d0d0616",
                                                        mobileNo: phoneNumber,
                                                      ),
                                                    );

                                                    context
                                                        .read<HomeBloc>()
                                                        .add(
                                                          GetCartCountEvent(
                                                            userId: userId,
                                                          ),
                                                        );
                                                    // context
                                                    //     .read<CounterCubit>()
                                                    //     .decrement(cartCount);
                                                    context
                                                        .read<CounterCubit>()
                                                        .increment(cartCount);
                                                    noOfIteminCart = cartCount;
                                                  });
                                                },
                                                child: Container(
                                                  height: 250,
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
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    top: 12.0,
                                                                  ),
                                                              child: ImageNetworkWidget(
                                                                url:
                                                                    freshFruitsresponse
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
                                                                    vertical: 4,
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
                                                                freshFruitsresponse
                                                                        .data![i]
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
                                                                freshFruitsresponse
                                                                        .data![i]
                                                                        .skuName ??
                                                                    "",
                                                                style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                freshFruitsresponse
                                                                        .data![i]
                                                                        .variants![0]
                                                                        .label ??
                                                                    "",
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black54,
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
                                                                          style: GoogleFonts.inter(
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
                                                                                  freshFruitsresponse.data![i].variants![0].discountPrice.toString(),
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
                                                                        freshFruitsresponse
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
                                                                  freshFruitsresponse
                                                                              .data![i]
                                                                              .variants![0]
                                                                              .cartQuantity ==
                                                                          0
                                                                      ? Expanded(
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            context
                                                                                .read<
                                                                                  HomeBloc
                                                                                >()
                                                                                .add(
                                                                                  AddButtonClikedEvent(
                                                                                    response:
                                                                                        freshFruitsresponse,
                                                                                    type:
                                                                                        "screen",
                                                                                    index:
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
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        RemoveItemButtonClikedEvent(
                                                                                          response:
                                                                                              freshFruitsresponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                                                                                      freshFruitsresponse.data![i].variants![0].cartQuantity.toString(),
                                                                                      textAlign:
                                                                                          TextAlign.center,
                                                                                      // style: GoogleFonts.poppins(
                                                                                      //   color: const Color(0xFF326A32),
                                                                                      //   fontSize: 14,
                                                                                      //   fontWeight: FontWeight.w500,
                                                                                      // ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  context
                                                                                      .read<
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        AddButtonClikedEvent(
                                                                                          response:
                                                                                              freshFruitsresponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 60,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  spacing: 20,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Grocery Essentials',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: blackColor,
                                      ),
                                    ),
                                    if (groceryEssentialsResponse.data != null)
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          spacing: 16,
                                          children: [
                                            for (
                                              int i = 0;
                                              i <
                                                  groceryEssentialsResponse
                                                      .data!
                                                      .length;
                                              i++
                                            )
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProductDetailsScreen(
                                                          productId:
                                                              groceryEssentialsResponse
                                                                  .data![i]
                                                                  .productId ??
                                                              "",
                                                          screenType: "back",
                                                        );
                                                      },
                                                    ),
                                                  ).then((value) {
                                                    if (!context.mounted) {
                                                      return;
                                                    }
                                                    context.read<HomeBloc>().add(
                                                      GetGroceryEssentialsEvent(
                                                        subCatId:
                                                            "676b624a84dd76eac5d33a3e",
                                                        mobileNo: phoneNumber,
                                                      ),
                                                    );

                                                    context
                                                        .read<HomeBloc>()
                                                        .add(
                                                          GetCartCountEvent(
                                                            userId: userId,
                                                          ),
                                                        );
                                                    // context
                                                    //     .read<CounterCubit>()
                                                    //     .decrement(cartCount);
                                                    context
                                                        .read<CounterCubit>()
                                                        .increment(cartCount);
                                                    noOfIteminCart = cartCount;
                                                  });
                                                },
                                                child: Container(
                                                  height: 250,
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
                                                                    groceryEssentialsResponse
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
                                                                    vertical: 4,
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
                                                                groceryEssentialsResponse
                                                                        .data![i]
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
                                                                groceryEssentialsResponse
                                                                        .data![i]
                                                                        .skuName ??
                                                                    "",
                                                                style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                groceryEssentialsResponse
                                                                        .data![i]
                                                                        .variants![0]
                                                                        .label ??
                                                                    "",
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black54,
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
                                                                          style: GoogleFonts.inter(
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
                                                                                  groceryEssentialsResponse.data![i].variants![0].discountPrice.toString(),
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
                                                                        groceryEssentialsResponse
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
                                                                  groceryEssentialsResponse
                                                                              .data![i]
                                                                              .variants![0]
                                                                              .cartQuantity ==
                                                                          0
                                                                      ? Expanded(
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            context
                                                                                .read<
                                                                                  HomeBloc
                                                                                >()
                                                                                .add(
                                                                                  AddButtonClikedEvent(
                                                                                    response:
                                                                                        groceryEssentialsResponse,
                                                                                    type:
                                                                                        "screen",
                                                                                    index:
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
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        RemoveItemButtonClikedEvent(
                                                                                          response:
                                                                                              groceryEssentialsResponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                                                                                      groceryEssentialsResponse.data![i].variants![0].cartQuantity.toString(),
                                                                                      textAlign:
                                                                                          TextAlign.center,
                                                                                      // style: GoogleFonts.poppins(
                                                                                      //   color: const Color(0xFF326A32),
                                                                                      //   fontSize: 14,
                                                                                      //   fontWeight: FontWeight.w500,
                                                                                      // ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  context
                                                                                      .read<
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        AddButtonClikedEvent(
                                                                                          response:
                                                                                              groceryEssentialsResponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 60,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  spacing: 20,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Nuts & Dried Fruits',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: blackColor,
                                      ),
                                    ),
                                    if (nutsDriedFruitsResponse.data != null)
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          spacing: 16,
                                          children: [
                                            for (
                                              int i = 0;
                                              i <
                                                  nutsDriedFruitsResponse
                                                      .data!
                                                      .length;
                                              i++
                                            )
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProductDetailsScreen(
                                                          productId:
                                                              nutsDriedFruitsResponse
                                                                  .data![i]
                                                                  .productId ??
                                                              "",
                                                          screenType: "back",
                                                        );
                                                      },
                                                    ),
                                                  ).then((value) {
                                                    if (!context.mounted) {
                                                      return;
                                                    }
                                                    context.read<HomeBloc>().add(
                                                      GetNutsDriedFruitsEvent(
                                                        subCatId:
                                                            "676b62c484dd76eac5d33a46",
                                                        mobileNo: phoneNumber,
                                                      ),
                                                    );

                                                    context
                                                        .read<HomeBloc>()
                                                        .add(
                                                          GetCartCountEvent(
                                                            userId: userId,
                                                          ),
                                                        );
                                                    // context
                                                    //     .read<CounterCubit>()
                                                    //     .decrement(cartCount);
                                                    context
                                                        .read<CounterCubit>()
                                                        .increment(cartCount);
                                                    noOfIteminCart = cartCount;
                                                  });
                                                },
                                                child: Container(
                                                  height: 250,
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
                                                                    nutsDriedFruitsResponse
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
                                                                    vertical: 4,
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
                                                                nutsDriedFruitsResponse
                                                                        .data![i]
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
                                                                nutsDriedFruitsResponse
                                                                        .data![i]
                                                                        .skuName ??
                                                                    "",
                                                                style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                nutsDriedFruitsResponse
                                                                        .data![i]
                                                                        .variants![0]
                                                                        .label ??
                                                                    "",
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black54,
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
                                                                          style: GoogleFonts.inter(
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
                                                                                  nutsDriedFruitsResponse.data![i].variants![0].discountPrice.toString(),
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
                                                                        nutsDriedFruitsResponse
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
                                                                  nutsDriedFruitsResponse
                                                                              .data![i]
                                                                              .variants![0]
                                                                              .cartQuantity ==
                                                                          0
                                                                      ? Expanded(
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            context
                                                                                .read<
                                                                                  HomeBloc
                                                                                >()
                                                                                .add(
                                                                                  AddButtonClikedEvent(
                                                                                    response:
                                                                                        nutsDriedFruitsResponse,
                                                                                    type:
                                                                                        "screen",
                                                                                    index:
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
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        RemoveItemButtonClikedEvent(
                                                                                          response:
                                                                                              nutsDriedFruitsResponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                                                                                      nutsDriedFruitsResponse.data![i].variants![0].cartQuantity.toString(),
                                                                                      textAlign:
                                                                                          TextAlign.center,
                                                                                      // style: GoogleFonts.poppins(
                                                                                      //   color: const Color(0xFF326A32),
                                                                                      //   fontSize: 14,
                                                                                      //   fontWeight: FontWeight.w500,
                                                                                      // ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  context
                                                                                      .read<
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        AddButtonClikedEvent(
                                                                                          response:
                                                                                              nutsDriedFruitsResponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 60,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  spacing: 20,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Rice & Cereals',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: blackColor,
                                      ),
                                    ),
                                    if (riceCerealsResponse.data != null)
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          spacing: 16,
                                          children: [
                                            for (
                                              int i = 0;
                                              i <
                                                  riceCerealsResponse
                                                      .data!
                                                      .length;
                                              i++
                                            )
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProductDetailsScreen(
                                                          productId:
                                                              riceCerealsResponse
                                                                  .data![i]
                                                                  .productId ??
                                                              "",
                                                          screenType: "back",
                                                        );
                                                      },
                                                    ),
                                                  ).then((value) {
                                                    if (!context.mounted) {
                                                      return;
                                                    }
                                                    context.read<HomeBloc>().add(
                                                      GetRiceCerealsEvent(
                                                        mainCatId:
                                                            "676431ddedae32578ae6d222",
                                                        subCatId:
                                                            "676b60bd84dd76eac5d33a2a",
                                                        mobileNo: phoneNumber,
                                                      ),
                                                    );

                                                    context
                                                        .read<HomeBloc>()
                                                        .add(
                                                          GetCartCountEvent(
                                                            userId: userId,
                                                          ),
                                                        );
                                                    // context
                                                    //     .read<CounterCubit>()
                                                    //     .decrement(cartCount);
                                                    context
                                                        .read<CounterCubit>()
                                                        .increment(cartCount);
                                                    noOfIteminCart = cartCount;
                                                  });
                                                },
                                                child: Container(
                                                  height: 250,
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
                                                                    riceCerealsResponse
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
                                                                    vertical: 4,
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
                                                                riceCerealsResponse
                                                                        .data![i]
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
                                                                riceCerealsResponse
                                                                        .data![i]
                                                                        .skuName ??
                                                                    "",
                                                                style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                riceCerealsResponse
                                                                        .data![i]
                                                                        .variants![0]
                                                                        .label ??
                                                                    "",
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      Colors
                                                                          .black54,
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
                                                                          style: GoogleFonts.inter(
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
                                                                                  riceCerealsResponse.data![i].variants![0].discountPrice.toString(),
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
                                                                        riceCerealsResponse
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
                                                                  riceCerealsResponse
                                                                              .data![i]
                                                                              .variants![0]
                                                                              .cartQuantity ==
                                                                          0
                                                                      ? Expanded(
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            context
                                                                                .read<
                                                                                  HomeBloc
                                                                                >()
                                                                                .add(
                                                                                  AddButtonClikedEvent(
                                                                                    response:
                                                                                        riceCerealsResponse,
                                                                                    type:
                                                                                        "screen",
                                                                                    index:
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
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        RemoveItemButtonClikedEvent(
                                                                                          response:
                                                                                              riceCerealsResponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                                                                                      riceCerealsResponse.data![i].variants![0].cartQuantity.toString(),
                                                                                      textAlign:
                                                                                          TextAlign.center,
                                                                                      // style: GoogleFonts.poppins(
                                                                                      //   color: const Color(0xFF326A32),
                                                                                      //   fontSize: 14,
                                                                                      //   fontWeight: FontWeight.w500,
                                                                                      // ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  context
                                                                                      .read<
                                                                                        HomeBloc
                                                                                      >()
                                                                                      .add(
                                                                                        AddButtonClikedEvent(
                                                                                          response:
                                                                                              riceCerealsResponse,
                                                                                          type:
                                                                                              "screen",
                                                                                          index:
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
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      isTablet
                          ? SizedBox()
                          : Container(
                            constraints: const BoxConstraints(
                              minHeight: 400,
                              maxWidth: 1280,
                            ),
                            child: Stack(
                              children: [
                                // Background Image
                                Image.asset(
                                  'download_banner.png',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  width: 1280,
                                  height: 350,
                                ),
                                // Content
                                Positioned(
                                  left: 100,
                                  top: 0,
                                  bottom: 0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 20 : 10,
                                    ),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 1280,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Download the Selorg app',
                                                style: TextStyle(
                                                  color: const Color(
                                                    0xFF034703,
                                                  ),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 17),
                                              Text(
                                                'Download Selorg app available on Android & iOS',
                                                style: TextStyle(
                                                  color: const Color(
                                                    0xFF555555,
                                                  ),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 21),
                                              Wrap(
                                                spacing: 20,
                                                runSpacing: 20,
                                                children: [
                                                  AppStoreButton(
                                                    icon:
                                                        'https://cdn.builder.io/api/v1/image/assets/TEMP/e63616af6b1623990b6e73b5785ab42480319283?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                    topText: 'Get it On',
                                                    bottomText: 'Google Play',
                                                    iconSize: const Size(
                                                      47,
                                                      47,
                                                    ),
                                                  ),
                                                  AppStoreButton(
                                                    icon:
                                                        'https://cdn.builder.io/api/v1/image/assets/TEMP/bc7388ec939068717da235abdfc46ffc125d7ead?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                                    topText: 'Download on the',
                                                    bottomText: 'App Store',
                                                    iconSize: const Size(
                                                      44,
                                                      50,
                                                    ),
                                                    topTextStyle:
                                                        const TextStyle(
                                                          fontSize: 19,
                                                        ),
                                                    bottomTextStyle:
                                                        const TextStyle(
                                                          fontSize: 22,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      BottomCategoriesBarWidget(),
                      BottomAppBarWidget(),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AppStoreButton extends StatelessWidget {
  final String icon;
  final String topText;
  final String bottomText;
  final Size iconSize;
  final TextStyle? topTextStyle;
  final TextStyle? bottomTextStyle;

  const AppStoreButton({
    super.key,
    required this.icon,
    required this.topText,
    required this.bottomText,
    required this.iconSize,
    this.topTextStyle,
    this.bottomTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF444444),
        borderRadius: BorderRadius.circular(9.159),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            icon,
            width: iconSize.width,
            height: iconSize.height,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topText,
                style:
                    topTextStyle?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ) ??
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
              ),
              Text(
                bottomText,
                style:
                    bottomTextStyle?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ) ??
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
