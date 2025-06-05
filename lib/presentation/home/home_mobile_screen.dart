import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/model/category/product_style_model.dart';
import 'package:selorgweb_main/model/home/banner_model.dart';
import 'package:selorgweb_main/model/home/grab_essentials_model.dart';
import 'package:selorgweb_main/presentation/banner/banner_screen.dart';
import 'package:selorgweb_main/presentation/category/category_bloc.dart';
// import 'package:selorgweb_main/presentation/category/category_state.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/home/home_bloc.dart';
import 'package:selorgweb_main/presentation/home/home_event.dart';
import 'package:selorgweb_main/presentation/home/home_state.dart';
import 'package:selorgweb_main/presentation/location/location_screen.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_screen.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_main_screen.dart';
import 'package:selorgweb_main/presentation/search/search_main_screen.dart';
import 'package:selorgweb_main/presentation/settings/setting_main_screen.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/widgets/network_image.dart';

class HomeMobileScreen extends StatelessWidget {
  const HomeMobileScreen({super.key});

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
  static Timer? timer;
  static List<BannerList> loopingBanners = [];
  static bool addButtonClicked = false;
  static int selectedIndexes = 0;
  static int selectedProductIndexes = 0;
  static int productVarientIndex = 0;

  void showLocationBottomSheet(
    BuildContext context,
    String latitude,
    String longitude,
    String place,
    HomeBloc homebloc,
  ) {
    showModalBottomSheet(
      backgroundColor: whitecolor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      isDismissible: !(location == "No Location Found"),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          //  height: 250,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(locationImage),
              // SizedBox(height: 20),
              Column(
                spacing: 10,
                children: [
                  Text(
                    "Please Enable Location Permission",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "for better delivery experience",
                    style: TextStyle(color: greyColor),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  spacing: 20,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homebloc.add(ContinueLocationEvent());
                        Navigator.pop(context);
                        // Navigator.pushNamed(context, "/yourLocation");
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return YourLocationScreen(
                        //         latitude: latitude,
                        //         longitude: longitude,
                        //         place: place);
                        //   },
                        // ));
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(3, 71, 3, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              //  fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: whitecolor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LocationScreen(screenType: 'dialog');
                            },
                          ),
                        );
                        if (res != null) {
                          debugPrint(res);
                          homebloc.add(UpdateLocationEvent(location: res));
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(3, 71, 3, 1),
                          ),
                          //color: const Color.fromRGBO(3, 71, 3, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search, color: appColor),
                              Text(
                                "Search Your Location",
                                style: TextStyle(
                                  //  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(3, 71, 3, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ) /* .whenComplete(() => context.read<BottomSheetBloc>().add(HideBottomSheetEvent())) */; // Hide when dismissed
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
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
          } else if (state is LocationSuccessState) {
            showLocationBottomSheet(
              context,
              state.latitude ?? "",
              state.longitude ?? "",
              state.place!,
              context.read<HomeBloc>(),
            );
          } else if (state is LocationContinueSuccessState) {
            context.read<HomeBloc>().add(
              GetLocationUsingLatLongFromApiEvent(
                latitude: state.latitude ?? "",
                longitude: state.longitude ?? "",
              ),
            );
          } else if (state is LatLongAddressSuccessState) {
            location =
                "${state.latLongLocationResponse.results![0].addressComponents![1].shortName} - ${state.latLongLocationResponse.results![0].addressComponents![3].shortName}";
            debugPrint(location);
          } else if (state is UpdateLocationState) {
            location = state.location;
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
          } else if (state is HomeErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              location == "No Location Found"
                  ? context.read<HomeBloc>().add(GetLocationEvent())
                  : null;
            });
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

            timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
              if (pageController.hasClients) {
                currentPage++;

                if (currentPage == festivalbanners.length + 1) {
                  // If reached the fake last item, jump to first real image instantly
                  pageController.jumpToPage(1);
                  currentPage = 1;
                } else {
                  // Otherwise, move to the next image
                  pageController.animateToPage(
                    currentPage,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              }
            });
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading:
                state
                    is HomeLoadingState /* || state is CategoryLoadingState */,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    homeTop,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          hometopColor,
                          whitecolor,
                        ], // Start & End Colors
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Column(
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<HomeBloc>().add(
                                    GetLocationEvent(),
                                  );
                                },
                                child: Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                            0.6,
                                      ),
                                      child: Text(
                                        location, // Your dynamic text here
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.keyboard_arrow_down, size: 20),
                                  ],
                                ),
                              ),
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
                                  //   Navigator.pushNamed(context, '/settings');
                                },
                                child: SvgPicture.asset(
                                  profilesvg,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => SearchMainScreen(
                                        searchTitle: "Orange",
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: greyColor),
                              ),
                              //  width: size.width,
                              height: 50,
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Colors.black54),
                                  SizedBox(width: 8),
                                  Text(
                                    "Search For 'Orange'",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  // Expanded(
                                  //   child: TextFormField(
                                  //     controller: searchController,
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               SearchScreen(),
                                  //         ),
                                  //       );
                                  //     },
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //       color: Colors.black,
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //     decoration: InputDecoration(
                                  //       fillColor: Color(0xFFFFFFFF),
                                  //       hintText: 'Search For "Orange"',
                                  //       hintStyle:
                                  //           TextStyle(color: Colors.black54),
                                  //       border: InputBorder.none,
                                  //     ),
                                  //     onChanged: (value) {},
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Grab & Go essentials for you!",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Visibility(
                          visible: !(grabandEssential.data == null),
                          child: IntrinsicHeight(
                            child: Row(
                              spacing: 12,
                              children: [
                                if (grabandEssential.data != null)
                                  for (
                                    int i = 0;
                                    i < grabandEssential.data!.length;
                                    i++
                                  )
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          title =
                                              grabandEssential.data![i].name ??
                                              "";
                                          id =
                                              grabandEssential.data![i].id ??
                                              "";
                                          isMainCategory =
                                              i == 2 ? false : true;
                                          mainCatId =
                                              i == 0
                                                  ? "676431a2edae32578ae6d220"
                                                  : i == 1
                                                  ? "676431ddedae32578ae6d222"
                                                  : "";
                                          isCategory = i == 2 ? true : false;
                                          catId = "6759448c66818180ad94a960";
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (
                                                    context,
                                                  ) => ProductListMainScreen(
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
                                                        i == 2 ? false : true,
                                                    mainCatId:
                                                        i == 0
                                                            ? "676431a2edae32578ae6d220"
                                                            : i == 1
                                                            ? "676431ddedae32578ae6d222"
                                                            : "",
                                                    isCategory:
                                                        i == 2 ? true : false,
                                                    catId:
                                                        "6759448c66818180ad94a960",
                                                  ),
                                            ),
                                          ).then((value) {
                                            if (!context.mounted) return;
                                            context.read<HomeBloc>().add(
                                              GetCartCountEvent(userId: userId),
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
                                          height: 120,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                grabandEssential
                                                        .data![i]
                                                        .imageUrl ??
                                                    "",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.only(
                                                //     top: 4,
                                                //     bottom: 4,
                                                //     left: 20,
                                                //     right: 20),
                                                margin: EdgeInsets.only(
                                                  top: 3,
                                                  right: 3,
                                                  left: 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: whitecolor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 4,
                                                    bottom: 4,
                                                    left: 15,
                                                    right: 15,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      grabandEssential
                                                              .data![i]
                                                              .name ??
                                                          "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
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
                          ),
                        ),
                        SizedBox(height: 8),
                        festivalbanners.isEmpty
                            ? SizedBox()
                            : CarouselSlider.builder(
                              itemCount: festivalbanners.length,
                              options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(
                                  milliseconds: 800,
                                ),
                                // enlargeCenterPage:
                                //     true, // Gives a nice zoom effect
                                viewportFraction:
                                    0.9, // Makes items slightly smaller than screen width
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => BannerScreen(
                                              bannerId:
                                                  festivalbanners[index].id ??
                                                  "",
                                            ),
                                      ),
                                    ).then((value) {
                                      if (!context.mounted) return;
                                      context.read<HomeBloc>().add(
                                        GetCartCountEvent(userId: userId),
                                      );
                                      // context
                                      //     .read<CounterCubit>()
                                      //     .decrement(cartCount);
                                      context.read<CounterCubit>().increment(
                                        cartCount,
                                      );
                                      noOfIteminCart = cartCount;
                                    });
                                    debugPrint(festivalbanners[index].id);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ImageNetworkWidget(
                                        url:
                                            festivalbanners[index].imageUrl ??
                                            "",
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dailybanners.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BannerScreen(
                                          bannerId:
                                              dailybanners[index].id ?? "",
                                        );
                                      },
                                    ),
                                  ).then((value) {
                                    if (!context.mounted) return;
                                    context.read<HomeBloc>().add(
                                      GetCartCountEvent(userId: userId),
                                    );
                                    // context
                                    //     .read<CounterCubit>()
                                    //     .decrement(cartCount);
                                    context.read<CounterCubit>().increment(
                                      cartCount,
                                    );
                                    noOfIteminCart = cartCount;
                                  });
                                  debugPrint(dailybanners[index].id);
                                  //  Navigator.pushNamed(context, '/banner');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Container(
                                    width: 314,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: ImageNetworkWidget(
                                        url: dailybanners[index].imageUrl ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Explore by Categories',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (mainCategory.data != null)
                              Visibility(
                                visible: true, // mainCategory.data!.length > 2,
                                child: Row(
                                  children: [
                                    const Text(
                                      'See All',
                                      style: TextStyle(
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
                        Row(
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
                                    onTap: () {
                                      title = mainCategory.data![i].name ?? "";
                                      id = mainCategory.data![i].id ?? "";
                                      isMainCategory = true;
                                      mainCatId =
                                          mainCategory.data![i].id ?? "";
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
                                                    mainCategory.data![i].id ??
                                                    "",
                                                isMainCategory: true,
                                                mainCatId:
                                                    mainCategory.data![i].id ??
                                                    "",
                                                isCategory: false,
                                                catId: "",
                                              ),
                                        ),
                                      ).then((value) {
                                        if (!context.mounted) return;
                                        context.read<HomeBloc>().add(
                                          GetCartCountEvent(userId: userId),
                                        );
                                        // context
                                        //     .read<CounterCubit>()
                                        //     .decrement(cartCount);
                                        context.read<CounterCubit>().increment(
                                          cartCount,
                                        );
                                        noOfIteminCart = cartCount;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 97,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE5EEC3),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: greyColor,
                                                blurRadius: 4,
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: ImageNetworkWidget(
                                              url:
                                                  mainCategory
                                                      .data![i]
                                                      .imageUrl ??
                                                  "",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          mainCategory.data![i].name ?? "",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ],
                        ),
                        SizedBox(),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double screenWidth = constraints.maxWidth;
                            double itemWidth =
                                (screenWidth - (22 * 2)) /
                                3; // Adjust for crossAxisSpacing
                            double itemHeight =
                                itemWidth * 1.2; // Adjust height dynamically
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 22,
                                    childAspectRatio:
                                        itemWidth /
                                        itemHeight, // Dynamic aspect ratio
                                  ),
                              itemCount: categories.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    title = categories[i].name ?? "";
                                    id = categories[i].id ?? "";
                                    isMainCategory = false;
                                    mainCatId = "";
                                    isCategory = true;
                                    catId = categories[i].id ?? "";
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductListMainScreen(
                                              title: categories[i].name ?? "",
                                              id: categories[i].id ?? "",
                                              isMainCategory: false,
                                              mainCatId: "",
                                              isCategory: true,
                                              catId: categories[i].id ?? "",
                                            ),
                                      ),
                                    ).then((value) {
                                      if (!context.mounted) return;
                                      context.read<HomeBloc>().add(
                                        GetCartCountEvent(userId: userId),
                                      );
                                      // context
                                      //     .read<CounterCubit>()
                                      //     .decrement(cartCount);
                                      context.read<CounterCubit>().increment(
                                        cartCount,
                                      );
                                      noOfIteminCart = cartCount;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            itemHeight *
                                            0.6, // Dynamically adjust height
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE5EEC3),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: greyColor,
                                              blurRadius: 4,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ImageNetworkWidget(
                                              url: categories[i].imageUrl ?? "",
                                              fit: BoxFit.contain,
                                              width:
                                                  itemWidth *
                                                  0.8, // Adjust image width dynamically
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width:
                                            itemWidth *
                                            0.9, // Ensure text fits within item width
                                        child: Text(
                                          categories[i].name ?? "",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF222222),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        //  const BannerCarousel(),
                        //  const SizedBox(height: 26),
                        // const CategoryGrid(),
                        //  const SizedBox(height: 27),
                        if (offerbanners.isNotEmpty)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BannerScreen(
                                      bannerId: offerbanners[0].id ?? "",
                                    );
                                  },
                                ),
                              ).then((value) {
                                if (!context.mounted) return;
                                context.read<HomeBloc>().add(
                                  GetCartCountEvent(userId: userId),
                                );
                                // context
                                //     .read<CounterCubit>()
                                //     .decrement(cartCount);
                                context.read<CounterCubit>().increment(
                                  cartCount,
                                );
                                noOfIteminCart = cartCount;
                              });
                              debugPrint(offerbanners[0].id ?? "");
                            },
                            child: ImageNetworkWidget(
                              url: offerbanners[0].imageUrl ?? "",
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        const SizedBox(height: 17),
                        Text(
                          'Organic & Fresh Fruits',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (freshFruitsresponse.data != null)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10,
                              children: [
                                for (
                                  int i = 0;
                                  i < freshFruitsresponse.data!.length;
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
                                        if (!context.mounted) return;
                                        context.read<HomeBloc>().add(
                                          GetOrganicFruitsEvent(
                                            mainCatId:
                                                "676431a2edae32578ae6d220",
                                            subCatId:
                                                "676ad87c756fa03a5d0d0616",
                                            mobileNo: phoneNumber,
                                          ),
                                        );

                                        context.read<HomeBloc>().add(
                                          GetCartCountEvent(userId: userId),
                                        );
                                        // context
                                        //     .read<CounterCubit>()
                                        //     .decrement(cartCount);
                                        context.read<CounterCubit>().increment(
                                          cartCount,
                                        );
                                        noOfIteminCart = cartCount;
                                      });
                                    },
                                    child: Container(
                                      height: 240,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.3,
                                      decoration: BoxDecoration(
                                        color: whitecolor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                        freshFruitsresponse
                                                            .data![i]
                                                            .variants![0]
                                                            .imageUrl ??
                                                        "",
                                                    height: 100,
                                                    //width: double.infinity,
                                                    fit: BoxFit.contain,
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
                                                    color: Color(0xFF034703),
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
                                                    freshFruitsresponse
                                                            .data![i]
                                                            .variants![0]
                                                            .offer ??
                                                        "",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                //spacing: 2,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                          FontWeight.w500,
                                                      color: Colors.black,
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
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Row(
                                                    spacing: 10,
                                                    children: [
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
                                                                      freshFruitsresponse
                                                                          .data![i]
                                                                          .variants![0]
                                                                          .discountPrice
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                            freshFruitsresponse
                                                                .data![i]
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
                                                                context.read<HomeBloc>().add(
                                                                  AddButtonClikedEvent(
                                                                    response:
                                                                        freshFruitsresponse,
                                                                    type:
                                                                        "screen",
                                                                    index: i,
                                                                    isButtonPressed:
                                                                        true,
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color:
                                                                        appColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
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
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                color: appColor,
                                                                border: Border.all(
                                                                  color:
                                                                      appColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20,
                                                                    ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
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
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
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
                                                                          freshFruitsresponse
                                                                              .data![i]
                                                                              .variants![0]
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
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
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
                        SizedBox(height: 8),
                        Text(
                          'Grocery Essentials',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (groceryEssentialsResponse.data != null)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10,
                              children: [
                                for (
                                  int i = 0;
                                  i < groceryEssentialsResponse.data!.length;
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
                                        if (!context.mounted) return;
                                        context.read<HomeBloc>().add(
                                          GetGroceryEssentialsEvent(
                                            subCatId:
                                                "676b624a84dd76eac5d33a3e",
                                            mobileNo: phoneNumber,
                                          ),
                                        );

                                        context.read<HomeBloc>().add(
                                          GetCartCountEvent(userId: userId),
                                        );
                                        // context
                                        //     .read<CounterCubit>()
                                        //     .decrement(cartCount);
                                        context.read<CounterCubit>().increment(
                                          cartCount,
                                        );
                                        noOfIteminCart = cartCount;
                                      });
                                    },
                                    child: Container(
                                      height: 240,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.3,
                                      decoration: BoxDecoration(
                                        color: whitecolor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    //width: double.infinity,
                                                    fit: BoxFit.cover,
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
                                                    color: Color(0xFF034703),
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
                                                    groceryEssentialsResponse
                                                            .data![i]
                                                            .variants![0]
                                                            .offer ??
                                                        "",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                // spacing: 8,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                          FontWeight.w500,
                                                      color: Colors.black,
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
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Row(
                                                    spacing: 10,
                                                    children: [
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
                                                                      groceryEssentialsResponse
                                                                          .data![i]
                                                                          .variants![0]
                                                                          .discountPrice
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                            groceryEssentialsResponse
                                                                .data![i]
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
                                                                context.read<HomeBloc>().add(
                                                                  AddButtonClikedEvent(
                                                                    response:
                                                                        groceryEssentialsResponse,
                                                                    type:
                                                                        "screen",
                                                                    index: i,
                                                                    isButtonPressed:
                                                                        true,
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color:
                                                                        appColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
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
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                color: appColor,
                                                                border: Border.all(
                                                                  color:
                                                                      appColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20,
                                                                    ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
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
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
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
                                                                          groceryEssentialsResponse
                                                                              .data![i]
                                                                              .variants![0]
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
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
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
                        SizedBox(height: 8),
                        Text(
                          'Nuts & Dried Fruits',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (nutsDriedFruitsResponse.data != null)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10,
                              children: [
                                for (
                                  int i = 0;
                                  i < nutsDriedFruitsResponse.data!.length;
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
                                        if (!context.mounted) return;
                                        context.read<HomeBloc>().add(
                                          GetNutsDriedFruitsEvent(
                                            subCatId:
                                                "676b62c484dd76eac5d33a46",
                                            mobileNo: phoneNumber,
                                          ),
                                        );

                                        context.read<HomeBloc>().add(
                                          GetCartCountEvent(userId: userId),
                                        );
                                        // context
                                        //     .read<CounterCubit>()
                                        //     .decrement(cartCount);
                                        context.read<CounterCubit>().increment(
                                          cartCount,
                                        );
                                        noOfIteminCart = cartCount;
                                      });
                                    },
                                    child: Container(
                                      height: 240,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.3,
                                      decoration: BoxDecoration(
                                        color: whitecolor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    //width: double.infinity,
                                                    fit: BoxFit.cover,
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
                                                    color: Color(0xFF034703),
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
                                                    nutsDriedFruitsResponse
                                                            .data![i]
                                                            .variants![0]
                                                            .offer ??
                                                        "",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                //  spacing: 8,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                          FontWeight.w500,
                                                      color: Colors.black,
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
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Row(
                                                    spacing: 10,
                                                    children: [
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
                                                                      nutsDriedFruitsResponse
                                                                          .data![i]
                                                                          .variants![0]
                                                                          .discountPrice
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                            nutsDriedFruitsResponse
                                                                .data![i]
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
                                                                context.read<HomeBloc>().add(
                                                                  AddButtonClikedEvent(
                                                                    response:
                                                                        nutsDriedFruitsResponse,
                                                                    type:
                                                                        "screen",
                                                                    index: i,
                                                                    isButtonPressed:
                                                                        true,
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color:
                                                                        appColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
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
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                color: appColor,
                                                                border: Border.all(
                                                                  color:
                                                                      appColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20,
                                                                    ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
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
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
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
                                                                          nutsDriedFruitsResponse
                                                                              .data![i]
                                                                              .variants![0]
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
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
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
                        SizedBox(height: 8),
                        Text(
                          'Rice & Cereals',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (riceCerealsResponse.data != null)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10,
                              children: [
                                for (
                                  int i = 0;
                                  i < riceCerealsResponse.data!.length;
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
                                        if (!context.mounted) return;
                                        context.read<HomeBloc>().add(
                                          GetRiceCerealsEvent(
                                            mainCatId:
                                                "676431ddedae32578ae6d222",
                                            subCatId:
                                                "676b60bd84dd76eac5d33a2a",
                                            mobileNo: phoneNumber,
                                          ),
                                        );

                                        context.read<HomeBloc>().add(
                                          GetCartCountEvent(userId: userId),
                                        );
                                        // context
                                        //     .read<CounterCubit>()
                                        //     .decrement(cartCount);
                                        context.read<CounterCubit>().increment(
                                          cartCount,
                                        );
                                        noOfIteminCart = cartCount;
                                      });
                                    },
                                    child: Container(
                                      height: 240,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.3,
                                      decoration: BoxDecoration(
                                        color: whitecolor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    //width: double.infinity,
                                                    fit: BoxFit.cover,
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
                                                    color: Color(0xFF034703),
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
                                                    riceCerealsResponse
                                                            .data![i]
                                                            .variants![0]
                                                            .offer ??
                                                        "",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                //  spacing: 8,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                          FontWeight.w500,
                                                      color: Colors.black,
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
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Row(
                                                    spacing: 10,
                                                    children: [
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
                                                                      riceCerealsResponse
                                                                          .data![i]
                                                                          .variants![0]
                                                                          .discountPrice
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                            riceCerealsResponse
                                                                .data![i]
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
                                                                context.read<HomeBloc>().add(
                                                                  AddButtonClikedEvent(
                                                                    response:
                                                                        riceCerealsResponse,
                                                                    type:
                                                                        "screen",
                                                                    index: i,
                                                                    isButtonPressed:
                                                                        true,
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color:
                                                                        appColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
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
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                color: appColor,
                                                                border: Border.all(
                                                                  color:
                                                                      appColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20,
                                                                    ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
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
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
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
                                                                          riceCerealsResponse
                                                                              .data![i]
                                                                              .variants![0]
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
                                                                          Colors
                                                                              .white,
                                                                      size: 16,
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
                  //  SizedBox(height: 200),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
