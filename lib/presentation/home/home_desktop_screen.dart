import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/category_model.dart' as cat;
import 'package:selorgweb_main/model/category/dynamic_category_model.dart'
    as dm;
import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/model/category/product_style_model.dart';
import 'package:selorgweb_main/model/home/banner_model.dart';
import 'package:selorgweb_main/model/home/dynamic_product_style_response_model.dart';
import 'package:selorgweb_main/model/home/grab_essentials_model.dart';
import 'package:selorgweb_main/presentation/category/categories_screen.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/home/home_bloc.dart';
import 'package:selorgweb_main/presentation/home/home_event.dart';
import 'package:selorgweb_main/presentation/home/home_mobile_screen.dart';
import 'package:selorgweb_main/presentation/home/home_state.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_screen.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_main_screen.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/utils/widgets/bottom_app_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_categories_bar_widget.dart';
import 'package:selorgweb_main/utils/widgets/bottom_image_widget.dart';
import 'package:selorgweb_main/utils/widgets/network_image.dart';
import 'package:selorgweb_main/utils/widgets/header_widget.dart';

class HomeDesktopScreen extends StatelessWidget {
  const HomeDesktopScreen({super.key});

  static GrabandEssential grabandEssential = GrabandEssential();
  static MainCategory mainCategory = MainCategory();

  static TextEditingController searchController = TextEditingController();

  static List<cat.Category> categories = [];
  static List<BannerList> festivalbanners = [];
  static List<BannerList> dailybanners = [];
  static List<BannerList> offerbanners = [];
  static ProductStyleResponse freshFruitsresponse = ProductStyleResponse();
  static ProductStyleResponse groceryEssentialsResponse =
      ProductStyleResponse();
  static ProductStyleResponse nutsDriedFruitsResponse = ProductStyleResponse();
  static ProductStyleResponse riceCerealsResponse = ProductStyleResponse();
  static DynamicProductStyleResponse dynamicProducts =
      DynamicProductStyleResponse();
  static PageController pageController = PageController(initialPage: 0);
  static int currentPage = 0;
  // static Timer? timer;
  static List<BannerList> loopingBanners = [];
  static bool addButtonClicked = false;
  static int selectedIndexes = 0;
  static int selectedProductIndexes = 0;
  static int productVarientIndex = 0;
  static dm.DynamicCategories dynamicCategories = dm.DynamicCategories();

  static List<SearchedLocationResponse> searchedLocations = [];

  static TextEditingController searchLocationController =
      TextEditingController();

  void showLocationMainAlertDialog(BuildContext context, HomeBloc homebloc) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
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
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.asset(locationImage, width: 100, height: 100),
                    const SizedBox(height: 20),
                    const Text(
                      "Please Enable Location permission",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    // const SizedBox(height: 4),
                    Text(
                      "for better delivery experience",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          homebloc.add(ContinueLocationEvent());
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showSearchLocationAlertDialog(context, homebloc);
                          searchLocationController.clear();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: appColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, color: appColor),
                            SizedBox(width: 8),
                            Text(
                              "Search your location",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: appColor,
                                fontSize: 16,
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
          ),
        );
      },
    );
  }

  void showSearchLocationAlertDialog(BuildContext context, HomeBloc homebloc) {
    showDialog(
      context: context,
      barrierDismissible: !(location == "No Location Found"),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: homebloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<HomeBloc, HomeState>(
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
                                          SearchLocationEvent(
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
                                                      context
                                                          .read<HomeBloc>()
                                                          .add(
                                                            SearchLocationEvent(
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
                                                    PlaceLocaitonEvent(
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
                                        homebloc.add(ContinueLocationEvent());
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
    final isMobile = MediaQuery.of(context).size.width < 500;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        //   BlocProvider(create: (context) => CounterCubit()),
        // BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GrabandEssentialsLoadedState) {
            debugPrint(state.grabandEssential.message);
            debugPrint(state.grabandEssential.data?[0].imageUrl);
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
          } else if (state is PlaceLocaitonState) {
            location = state.locationText;
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
              state.response.variants![0].userCartQuantity =
                  (state.response.variants![0].userCartQuantity ?? 0) + 1;
              context.read<HomeBloc>().add(
                AddItemInCartApiEvent(
                  skuName: state.response.skuName ?? 'Product',
                  userId: userId,
                  productId: state.response.id ?? "",
                  quantity: 1,
                  variantLabel:
                      selectedProductIndexes == state.selectedIndexes
                          ? state.response.variants![productVarientIndex].label
                              .toString()
                          : state.response.variants![0].label.toString(),
                  imageUrl:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                              .response
                              .variants![productVarientIndex]
                              .imageUrl
                              .toString()
                          : state.response.variants![0].imageUrl.toString(),
                  price:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                                  .response
                                  .variants![productVarientIndex]
                                  .price ??
                              0
                          : state.response.variants![0].price ?? 0,
                  discountPrice:
                      selectedProductIndexes == state.selectedIndexes
                          ? state
                                  .response
                                  .variants![productVarientIndex]
                                  .discountPrice ??
                              0
                          : state.response.variants![0].discountPrice ?? 0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else if (state.type == "dialog") {
              state.response.variants![state.selectedIndexes].userCartQuantity =
                  (state
                          .response
                          .variants![state.selectedIndexes]
                          .userCartQuantity ??
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
              state.response.variants![0].userCartQuantity == 0
                  ? null
                  : state.response.variants![0].userCartQuantity =
                      (state.response.variants![0].userCartQuantity ?? 0) - 1;
              context.read<HomeBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId: state.response.id ?? "",
                  variantLabel:
                      selectedProductIndexes == state.selectedIndexes
                          ? state.response.variants![productVarientIndex].label
                              .toString()
                          : state.response.variants![0].label.toString(),
                  quantity: 1,
                  deliveryTip: 0,
                  handlingCharges: 0,
                ),
              );
            } else if (state.type == "dialog") {
              state.response.variants![state.selectedIndexes].userCartQuantity =
                  (state
                          .response
                          .variants![state.selectedIndexes]
                          .userCartQuantity ??
                      0) -
                  1;
            }
          } else if (state is ItemRemovedToCartState) {
            context.read<CounterCubit>().decrement(1);
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
          } else if (state is SearchedLocationSuccessState) {
            searchedLocations = state.searchedLocationResponse;
          } else if (state is LatLongSuccessState) {
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return YourLocationScreen(
            //         lat: state.latitude,
            //         long: state.longitude,
            //         screenType:
            //             screenType == "address" ? "listview" : "search");
            //   },
            // ));
          } else if (state is DynamicCategoryLoadedState) {
            dynamicCategories = state.categories;
            debugPrint('home dynamic');
            debugPrint(dynamicCategories.toJson().toString());
          } else if (state is DynamicProductStyleResponseState) {
            dynamicProducts = state.products;
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState) {
            isMobile
                ? null
                : WidgetsBinding.instance.addPostFrameCallback((_) {
                  location == "No Location Found"
                      ? showLocationMainAlertDialog(
                        context,
                        context.read<HomeBloc>(),
                      ) /*  context.read<HomeBloc>().add(ContinueLocationEvent()) */
                      : null;
                });
            context.read<HomeBloc>().add(GetCartCountEvent(userId: userId));
            context.read<HomeBloc>().add(GrabAndGoEvent());
            context.read<HomeBloc>().add(GetBannerEvent());
            context.read<HomeBloc>().add(GetMainCategoryDataEvent());
            context.read<HomeBloc>().add(GetCategoryDataEvent());
            context.read<HomeBloc>().add(GetDynamicHomeProductEvent());
            context.read<HomeBloc>().add(GetDynamicCategoryDataEvent());

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
          return Scaffold(
            backgroundColor: appbackgroundColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return isMobile
                    ? HomeMobileScreen()
                    : SingleChildScrollView(
                      child: Column(
                        children: [
                          HeaderWidget(
                            isHomeScreen: true,
                            onClick: () {
                              showSearchLocationAlertDialog(
                                context,
                                context.read<HomeBloc>(),
                              );
                            },
                          ),
                          Container(
                            // constraints: BoxConstraints(maxHeight: 300),
                            color: appbackgroundColor,
                            height:
                                MediaQuery.of(context).size.width < 991
                                    ? 250
                                    : 300,
                            child: Stack(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxHeight: 160),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: secondAppColor,
                                  ),
                                  child: const Row(children: []),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        'Grab & Go essentials for you!',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          wordSpacing: 2,
                                          letterSpacing: 2,
                                          color: primarytextColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      Visibility(
                                        visible:
                                            !(grabandEssential.data == null),
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
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    // clipBehavior: Clip.hardEdge,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          context.push(
                                                            Uri(
                                                              path:
                                                                  '/productslistscreen',
                                                              queryParameters: {
                                                                'title':
                                                                    grabandEssential
                                                                        .data![i]
                                                                        .name ??
                                                                    '',
                                                                'id':
                                                                    grabandEssential
                                                                        .data![i]
                                                                        .categoryId ??
                                                                    '',
                                                                'isMainCategory':
                                                                    'true',
                                                                'mainCatId':
                                                                    grabandEssential
                                                                        .data![i]
                                                                        .categoryId ??
                                                                    '',
                                                                'isCategory':
                                                                    'true',
                                                                'catId':
                                                                    grabandEssential
                                                                        .data![i]
                                                                        .categoryId ??
                                                                    '',
                                                              },
                                                            ).toString(),
                                                          );
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //     builder:
                                                          //         (
                                                          //           context,
                                                          //         ) => ProductListMainScreen(
                                                          //           title:
                                                          //               grabandEssential
                                                          //                   .data![i]
                                                          //                   .name ??
                                                          //               "",
                                                          //           id:
                                                          //               grabandEssential
                                                          //                   .data![i]
                                                          //                   .id ??
                                                          //               "",
                                                          //           isMainCategory:
                                                          //               i == 2
                                                          //                   ? false
                                                          //                   : true,
                                                          //           mainCatId:
                                                          //               i == 0
                                                          //                   ? "676431a2edae32578ae6d220"
                                                          //                   : i ==
                                                          //                       1
                                                          //                   ? "676431ddedae32578ae6d222"
                                                          //                   : "",
                                                          //           isCategory:
                                                          //               i == 2
                                                          //                   ? true
                                                          //                   : false,
                                                          //           catId:
                                                          //               "6759448c66818180ad94a960",
                                                          //         ),
                                                          //   ),
                                                          // );
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
                                                                        0.25
                                                                    : isTablet
                                                                    ? MediaQuery.of(
                                                                          context,
                                                                        ).size.width *
                                                                        0.22
                                                                    : 256,
                                                            height:
                                                                isMobile
                                                                    ? 100
                                                                    : constraints
                                                                            .maxWidth <
                                                                        991
                                                                    ? 160
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
                                                                    BoxFit.fill,
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
                          //  SizedBox(height: 20),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 1280,
                              // maxHeight: 300,
                            ),
                            child: Column(
                              // spacing: 20,
                              children: [
                                festivalbanners.isEmpty
                                    ? SizedBox()
                                    : Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 1280,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: isMobile ? 10 : 60,
                                        ),
                                        child: CarouselSlider.builder(
                                          itemCount: festivalbanners.length,
                                          options: CarouselOptions(
                                            aspectRatio: 2 / 1,
                                            // height:
                                            //     isMobile
                                            //         ? MediaQuery.of(
                                            //               context,
                                            //             ).size.height /
                                            //             2.2
                                            //         : isTablet
                                            //         ? MediaQuery.of(
                                            //               context,
                                            //             ).size.height *
                                            //             0.5
                                            //         : MediaQuery.of(
                                            //               context,
                                            //             ).size.height *
                                            //             0.6,
                                            autoPlay: true,
                                            scrollPhysics:
                                                FixedExtentScrollPhysics(),
                                            autoPlayInterval: const Duration(
                                              seconds: 3,
                                            ),
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                  milliseconds: 800,
                                                ),
                                            enlargeCenterPage:
                                                true, // Gives a nice zoom effect
                                            viewportFraction:
                                                isMobile
                                                    ? 0.6
                                                    : isTablet
                                                    ? 0.6
                                                    : 0.6, // Makes items slightly smaller than screen width
                                            scrollDirection: Axis.horizontal,
                                            enableInfiniteScroll:
                                                true, // Allows continuous looping
                                            onPageChanged: (index, reason) {
                                              // setState(() {
                                              //   _currentIndex = index;
                                              // });
                                            },
                                          ),
                                          itemBuilder: (
                                            context,
                                            index,
                                            realIndex,
                                          ) {
                                            return InkWell(
                                              hoverColor: Colors.transparent,
                                              onTap: () {
                                                context.push(
                                                  Uri(
                                                    path: '/banner',
                                                    queryParameters: {
                                                      'bannerId':
                                                          festivalbanners[index]
                                                              .id ??
                                                          "",
                                                    },
                                                  ).toString(),
                                                );
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder:
                                                //         (
                                                //           context,
                                                //         ) => BannerScreen(
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

                                                debugPrint(
                                                  festivalbanners[index].id,
                                                );
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: ImageNetworkWidget(
                                                    url:
                                                        festivalbanners[index]
                                                            .imageUrl ??
                                                        "",
                                                    width:
                                                        isMobile
                                                            ? MediaQuery.of(
                                                                  context,
                                                                ).size.width /
                                                                2
                                                            : isTablet
                                                            ? double.infinity
                                                            : MediaQuery.of(
                                                                  context,
                                                                ).size.width /
                                                                2,

                                                    fit: BoxFit.cover,
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
                                SizedBox(height: 15),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 20 : 60,
                                  ),
                                  child: SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: dailybanners.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            context.push(
                                              Uri(
                                                path: '/banner',
                                                queryParameters: {
                                                  'bannerId':
                                                      dailybanners[index].id ??
                                                      "",
                                                },
                                              ).toString(),
                                            );
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) {
                                            //       return BannerScreen(
                                            //         bannerId:
                                            //             dailybanners[index]
                                            //                 .id ??
                                            //             "",
                                            //       );
                                            //     },
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
                                            debugPrint(dailybanners[index].id);
                                            //  Navigator.pushNamed(context, '/banner');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 25,
                                            ),
                                            child: Container(
                                              width: 314,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: ImageNetworkWidget(
                                                  url:
                                                      dailybanners[index]
                                                          .imageUrl ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 20 : 60,
                                  ),
                                  child: Column(
                                    spacing: 20,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    color: appColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 14,
                                                  color: appColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (dynamicCategories.data != null)
                                        for (
                                          int categoryIndex = 0;
                                          categoryIndex <
                                              dynamicCategories.data!.length;
                                          categoryIndex++
                                        )
                                          Column(
                                            children: [
                                              if (dynamicCategories
                                                      .data!
                                                      .length >
                                                  1)
                                                Row(
                                                  children: [
                                                    Text(
                                                      dynamicCategories
                                                          .data![categoryIndex]
                                                          .categoryTitleName!,
                                                      style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium,
                                                    ),
                                                  ],
                                                ),
                                              if (dynamicCategories
                                                      .data!
                                                      .length >
                                                  1)
                                                SizedBox(height: 20),
                                              LayoutBuilder(
                                                builder: (
                                                  context,
                                                  constraints,
                                                ) {
                                                  double maxWidth =
                                                      constraints.maxWidth;
                                                  int itemsPerRow = 6;

                                                  if (maxWidth < 991) {
                                                    itemsPerRow = 3;
                                                  }

                                                  // base width per item
                                                  double baseWidth =
                                                      maxWidth / itemsPerRow;

                                                  List<dm.Category>?
                                                  categorydata = [
                                                    ...dynamicCategories
                                                        .data![categoryIndex]
                                                        .categories!,
                                                  ]..sort(
                                                    (a, b) => a.index!
                                                        .compareTo(b.index!),
                                                  );
                                                  return Wrap(
                                                    spacing: 16,
                                                    runSpacing: 25,
                                                    alignment:
                                                        WrapAlignment.start,
                                                    children: [
                                                      for (
                                                        int i = 0;
                                                        i < categorydata.length;
                                                        i++
                                                      )
                                                        InkWell(
                                                          hoverColor:
                                                              Colors
                                                                  .transparent,
                                                          onTap: () {
                                                            debugPrint(
                                                              categorydata[i]
                                                                      .name ??
                                                                  "",
                                                            );
                                                            title =
                                                                categorydata[i]
                                                                    .name ??
                                                                "";
                                                            id =
                                                                categorydata[i]
                                                                    .id ??
                                                                "";
                                                            isMainCategory =
                                                                true;
                                                            mainCatId =
                                                                categorydata[i]
                                                                    .id ??
                                                                "";
                                                            isCategory = true;
                                                            catId =
                                                                categorydata[i]
                                                                    .id ??
                                                                "";
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (
                                                                      context,
                                                                    ) => ProductListMainScreen(
                                                                      title:
                                                                          categorydata[i]
                                                                              .name ??
                                                                          "",
                                                                      id:
                                                                          categorydata[i]
                                                                              .id ??
                                                                          "",
                                                                      isMainCategory:
                                                                          true,
                                                                      mainCatId:
                                                                          categorydata[i]
                                                                              .id ??
                                                                          "",
                                                                      isCategory:
                                                                          true,
                                                                      catId:
                                                                          categorydata[i]
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
                                                                width:
                                                                    categorydata[i]
                                                                            .isHighlight!
                                                                        ? baseWidth *
                                                                                1.5 -
                                                                            16
                                                                        : baseWidth -
                                                                            16,
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
                                                                          categorydata[i]
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
                                                                categorydata[i]
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
                                                  );
                                                },
                                              ),
                                              if (dynamicCategories
                                                      .data!
                                                      .length >
                                                  1)
                                                SizedBox(height: 20),
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
                                      constraints: BoxConstraints(
                                        maxWidth: 1280,
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(),
                                      width: double.infinity,
                                      // color: appColor,
                                      child: InkWell(
                                        onTap: () {
                                          context.push(
                                            Uri(
                                              path: '/banner',
                                              queryParameters: {
                                                'bannerId':
                                                    offerbanners[0].id ?? "",
                                              },
                                            ).toString(),
                                          );
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
                                SizedBox(height: 20),
                                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                if (dynamicProducts.data != null)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 20 : 60,
                                    ),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width <=
                                                    1280
                                                ? MediaQuery.of(
                                                  context,
                                                ).size.width
                                                : 1280,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            dynamicProducts.data!.map((
                                              productdata,
                                            ) {
                                              List<Product> product =
                                                  productdata.products!;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15,
                                                  bottom: 15,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing: 16,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          productdata
                                                              .displayName!,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: blackColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        spacing: 10,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          for (
                                                            int i = 0;
                                                            i < product.length;
                                                            i++
                                                          )
                                                            InkWell(
                                                              hoverColor:
                                                                  Colors
                                                                      .transparent,

                                                              onTap: () {
                                                                context.push(
                                                                  Uri(
                                                                    path:
                                                                        '/productdetail',
                                                                    queryParameters: {
                                                                      'productId':
                                                                          product[i]
                                                                              .id ??
                                                                          "",
                                                                      'screenType':
                                                                          'back',
                                                                    },
                                                                  ).toString(),
                                                                );
                                                                // Navigator.push(
                                                                //   context,
                                                                //   MaterialPageRoute(
                                                                //     builder: (context) {
                                                                //       return ProductDetailsScreen(
                                                                //         productId:
                                                                //             riceCerealsResponse
                                                                //                 .data![i]
                                                                //                 .productId ??
                                                                //             "",
                                                                //         screenType:
                                                                //             "back",
                                                                //       );
                                                                //     },
                                                                //   ),
                                                                // ).then((value) {
                                                                //   if (!context.mounted) {
                                                                //     return;
                                                                //   }
                                                                //   context.read<HomeBloc>().add(
                                                                //     GetRiceCerealsEvent(
                                                                //       mainCatId:
                                                                //           "676431ddedae32578ae6d222",
                                                                //       subCatId:
                                                                //           "676b60bd84dd76eac5d33a2a",
                                                                //       mobileNo:
                                                                //           phoneNumber,
                                                                //     ),
                                                                //   );

                                                                //   context
                                                                //       .read<HomeBloc>()
                                                                //       .add(
                                                                //         GetCartCountEvent(
                                                                //           userId: userId,
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
                                                              child: Container(
                                                                height: 250,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      whiteColor,

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
                                                                            padding: const EdgeInsets.only(
                                                                              top:
                                                                                  12.0,
                                                                            ),
                                                                            child: ImageNetworkWidget(
                                                                              url:
                                                                                  product[i].variants![0].imageUrl ??
                                                                                  "",
                                                                              height:
                                                                                  100,
                                                                              width:
                                                                                  double.infinity,
                                                                              fit:
                                                                                  BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              0,
                                                                          left:
                                                                              0,
                                                                          child: Container(
                                                                            padding: const EdgeInsets.symmetric(
                                                                              horizontal:
                                                                                  8,
                                                                              vertical:
                                                                                  4,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                              color:
                                                                                  appColor,
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(
                                                                                  20,
                                                                                ),
                                                                                bottomRight: Radius.circular(
                                                                                  20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            child: Text(
                                                                              product[i].variants![0].offer ??
                                                                                  "",
                                                                              style: const TextStyle(
                                                                                color:
                                                                                    Colors.white,
                                                                                fontSize:
                                                                                    14,
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
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                              10,
                                                                            ),
                                                                        child: Column(
                                                                          //spacing: 2,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text(
                                                                              product[i].skuName ??
                                                                                  "",
                                                                              style: const TextStyle(
                                                                                fontSize:
                                                                                    14,
                                                                                fontWeight:
                                                                                    FontWeight.w500,
                                                                                color:
                                                                                    Colors.black,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              product[i].variants![0].label ??
                                                                                  "",
                                                                              style: TextStyle(
                                                                                fontSize:
                                                                                    12,
                                                                                fontWeight:
                                                                                    FontWeight.w500,
                                                                                color:
                                                                                    Colors.black54,
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              spacing:
                                                                                  10,
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
                                                                                                product[i].variants![0].discountPrice.toString(),
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
                                                                                      product[i].variants![0].price.toString(),
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
                                                                                product[i].variants![0].userCartQuantity ==
                                                                                        0
                                                                                    ? Expanded(
                                                                                      child: InkWell(
                                                                                        hoverColor:
                                                                                            Colors.transparent,

                                                                                        onTap: () {
                                                                                          context
                                                                                              .read<
                                                                                                HomeBloc
                                                                                              >()
                                                                                              .add(
                                                                                                AddButtonClikedEvent(
                                                                                                  response:
                                                                                                      product[i],
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
                                                                                              hoverColor:
                                                                                                  Colors.transparent,

                                                                                              onTap: () {
                                                                                                context
                                                                                                    .read<
                                                                                                      HomeBloc
                                                                                                    >()
                                                                                                    .add(
                                                                                                      RemoveItemButtonClikedEvent(
                                                                                                        response:
                                                                                                            product[i],
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
                                                                                                    product[i].variants![0].userCartQuantity.toString(),
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
                                                                                              hoverColor:
                                                                                                  Colors.transparent,

                                                                                              onTap: () {
                                                                                                context
                                                                                                    .read<
                                                                                                      HomeBloc
                                                                                                    >()
                                                                                                    .add(
                                                                                                      AddButtonClikedEvent(
                                                                                                        response:
                                                                                                            product[i],
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
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  ),

                                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                              ],
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
          );
        },
      ),
    );
  }
}
