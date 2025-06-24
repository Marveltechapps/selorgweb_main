import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/apiservice/post_method.dart' as api;
import 'package:selorgweb_main/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/lat_long_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/model/cart/cart_error_response_model.dart';
import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/category_model.dart' as cat;
import 'package:selorgweb_main/model/category/dynamic_category_model.dart'
    as dm;
import 'package:selorgweb_main/model/category/main_category_model.dart';
// import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/model/category/product_style_model.dart';
import 'package:selorgweb_main/model/category/remove_cart_response_model.dart';
import 'package:selorgweb_main/model/category/remove_item_cart_model.dart';
import 'package:selorgweb_main/model/home/banner_model.dart';
import 'package:selorgweb_main/model/home/grab_essentials_model.dart';
import 'package:selorgweb_main/model/home/dynamic_product_style_response_model.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<GetLocationEvent>(getlocation);
    on<GetScreenEvent>(onTap);
    on<GrabAndGoEvent>(getGrabandGo);
    on<GetBannerEvent>(getBanner);
    on<GetOrganicFruitsEvent>(getOrganicFreshFruitsData);
    on<GetGroceryEssentialsEvent>(getGroceryEssentialsData);
    on<GetNutsDriedFruitsEvent>(getNutsDriedFruitsData);
    on<GetRiceCerealsEvent>(getRiceCerelasData);
    on<ContinueLocationEvent>(locationContinue);
    on<UpdateLocationEvent>(updateLocation);
    on<AddItemInCartApiEvent>(addItemToCart);
    on<AddButtonClikedEvent>(onAddbuttonclicked);
    on<RemoveItemInCartApiEvent>(removeItemsToCartApifunction);
    on<RemoveItemButtonClikedEvent>(onRemoveItembuttonclicked);
    on<GetCartCountEvent>(getCartCount);
    on<GetMainCategoryDataEvent>(getMainCategoryData);
    on<GetCategoryDataEvent>(getCategoryData);
    on<GetLocationUsingLatLongFromApiEvent>(getlatlongfromapi);
    on<SearchLocationEvent>(seachLocation);
    on<GetLatLonOnListEvent>(getlatlon);
    on<PlaceLocaitonEvent>(placelocatiovalue);
    on<GetDynamicCategoryDataEvent>(getDynamicCategoryData);
    on<GetDynamicHomeProductEvent>(getDynamicHomeProductData);
    on<ShowBottomSheetEvent>((event, emit) => emit(BottomSheetVisible()));
  }

  placelocatiovalue(PlaceLocaitonEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(PlaceLocaitonState(locationText: event.locationText));
  }

  getCartCount(GetCartCountEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      if (isLoggedInvalue) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var cartResponse = cartResponseFromJson(response.body);
          cartResponse.items!.length;
          int countvalue = 0;
          for (int i = 0; i < cartResponse.items!.length; i++) {
            countvalue = countvalue + cartResponse.items![i].quantity!;
          }
          emit(CartDataSuccess(noOfItems: countvalue));
        } else {
          var errorResponse = cartErrorResponseFromJson(response.body);
          emit(HomeErrorState(message: errorResponse.message ?? ""));
        }
      } else {
        final props = await SharedPreferences.getInstance();
        var data = props.getString('cartdata');
        debugPrint('data $data');
        List<dynamic> decryptedData = jsonDecode(data ?? '[]');
        debugPrint('decrypteddata $decryptedData');
        debugPrint('cart count ${decryptedData.length}');

        emit(CartDataSuccess(noOfItems: decryptedData.length));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  onAddbuttonclicked(AddButtonClikedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(
      AddButtonClickedState(
        response: event.response,
        type: event.type,
        selectedIndexes: event.index,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  addItemToCart(AddItemInCartApiEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = event.userId;
    addItemToCartRequest.productId = event.productId;
    addItemToCartRequest.skuName = event.skuName;
    addItemToCartRequest.quantity = event.quantity;
    addItemToCartRequest.variantLabel = event.variantLabel;
    addItemToCartRequest.imageUrl = event.imageUrl;
    addItemToCartRequest.price = event.price;
    addItemToCartRequest.discountPrice = event.discountPrice;
    addItemToCartRequest.deliveryInstructions = event.deliveryInstructions;
    addItemToCartRequest.addNotes = event.addNotes;
    try {
      if (isLoggedInvalue == true) {
        String url = addCartUrl;
        debugPrint(url);
        api.Response response = await api.ApiService().postRequest(
          addCartUrl,
          addItemToCartRequestToJson(addItemToCartRequest),
        );
        if (response.statusCode == 200) {
          var addItemToCartResponse = addItemToCartResponseFromJson(
            response.resBody,
          );
          emit(
            ItemAddedToCartInHomeScreenState(
              addItemToCartResponse: addItemToCartResponse,
            ),
          );
        } else {
          emit(HomeErrorState(message: response.resBody));
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        List<dynamic> cartdata = jsonDecode(prefs.getString('cartdata') ?? '');
        String data = addItemToCartRequestToJson(addItemToCartRequest);
        cartdata.add(jsonDecode(data));
        debugPrint('add cart rough $cartdata');
        await prefs.setString('cartdata', jsonEncode(cartdata));
        emit(CartDataSuccess(noOfItems: cartdata.length));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  removeItemsToCartApifunction(
    RemoveItemInCartApiEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    RemoveItemToCartRequest removeItemToCartRequest = RemoveItemToCartRequest();
    removeItemToCartRequest.userId = event.userId;
    removeItemToCartRequest.productId = event.productId;
    removeItemToCartRequest.variantLabel = event.variantLabel;
    removeItemToCartRequest.quantity = event.quantity;
    removeItemToCartRequest.handlingCharges = event.handlingCharges;
    removeItemToCartRequest.deliveryTip = event.deliveryTip;
    try {
      String url = removeCartUrl;
      debugPrint(url);
      if (isLoggedInvalue) {
        api.Response response = await api.ApiService().postRequest(
          url,
          removeItemToCartRequestToJson(removeItemToCartRequest),
        );
        if (response.statusCode == 200) {
          var removeCartResponse = removeCartResponseFromJson(response.resBody);
          emit(ItemRemovedToCartState(removeCartResponse: removeCartResponse));
        } else {
          emit(HomeErrorState(message: response.resBody));
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        List<dynamic> cartdata = jsonDecode(prefs.getString('cartdata') ?? '');
        final index = cartdata.indexWhere(
          (item) =>
              item['productId'] == event.productId &&
              item['quantity'] == event.quantity &&
              item['variantLabel'] == event.variantLabel,
        );
        // cartdata.add(jsonDecode(data));
        cartdata.removeAt(index);
        debugPrint('add cart rough $cartdata');
        await prefs.setString('cartdata', jsonEncode(cartdata));
        emit(CartDataSuccess(noOfItems: cartdata.length));
        // emit(
        //   ItemAddedToCartInHomeScreenState(
        //     addItemToCartResponse: addItemToCartResponseFromJson('[]'),
        //   ),
        // );
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  onRemoveItembuttonclicked(
    RemoveItemButtonClikedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeLoadingState());
    emit(
      RemoveButtonClickedState(
        response: event.response,
        type: event.type,
        selectedIndexes: event.index,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  updateLocation(UpdateLocationEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(UpdateLocationState(location: event.location));
  }

  getOrganicFreshFruitsData(
    GetOrganicFruitsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?category_id=${event.mainCatId}&subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var organicFreshFruitsResponse = productStyleResponseFromJson(
          response.body,
        );
        emit(
          OrganicFreshFruitsLoadedState(
            productStyleResponse: organicFreshFruitsResponse,
          ),
        );
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getGroceryEssentialsData(
    GetGroceryEssentialsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var groceryEssentialsResponse = productStyleResponseFromJson(
          response.body,
        );
        emit(
          GroceryEssentialsLoadedState(
            productStyleResponse: groceryEssentialsResponse,
          ),
        );
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getNutsDriedFruitsData(
    GetNutsDriedFruitsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var nutsDriedFruitsResponse = productStyleResponseFromJson(
          response.body,
        );
        emit(
          NutsDriedFruitsLoadedState(
            productStyleResponse: nutsDriedFruitsResponse,
          ),
        );
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getRiceCerelasData(GetRiceCerealsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?category_id=${event.mainCatId}&subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var riceCerealsResponse = productStyleResponseFromJson(response.body);
        emit(RiceCerealsLoadedState(productStyleResponse: riceCerealsResponse));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  onTap(GetScreenEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(NavigateState(index: event.index));
  }

  getlatlon(GetLatLonOnListEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    String url =
        "$getLatLonUrl${event.placeId}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var latlongLocationResponse = latLonLocationResponseFromJson(
          response.body,
        );
        emit(
          LatLongSuccessState(
            longitude:
                latlongLocationResponse.result!.geometry!.location!.lng
                    .toString(),
            latitude:
                latlongLocationResponse.result!.geometry!.location!.lat
                    .toString(),
          ),
        );
      } else {
        emit(HomeErrorState(message: "Failed to fetch data"));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getlocation(GetLocationEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      debugPrint("Location services are disabled.");
      // return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // locationMessage = "Location permission denied.";
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        "Location permission permanently denied. Enable from settings.",
      );
      // locationMessage =
      //     "Location permission permanently denied. Enable from settings.";
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    // );
    // if (placemarks.isNotEmpty) {
    //   place = placemarks.first.subLocality;
    //   // debugPrint(
    //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
    // }
    emit(
      LocationSuccessState(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        place: "place",
      ),
    );
    debugPrint(
      "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
    );
    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }

  getlatlongfromapi(
    GetLocationUsingLatLongFromApiEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    String url =
        "$latlonggetAddressUrl${event.latitude},${event.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = latLongLocationResponseFromJson(response.body);
        debugPrint("data:");
        debugPrint(result.results?.first.formattedAddress);
        emit(LatLongAddressSuccessState(latLongLocationResponse: result));
      } else {
        emit(HomeErrorState(message: "Failed to fetch data"));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  seachLocation(SearchLocationEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    String url = seachLocationUrl + event.searchText;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var searchedLocationResponse = searchedLocationResponseFromJson(
          response.body,
        );
        emit(
          SearchedLocationSuccessState(
            searchedLocationResponse: searchedLocationResponse,
          ),
        );
      } else {
        if (event.searchText.isEmpty) {
        } else {
          emit(HomeErrorState(message: "Failed to fetch data"));
        }
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //
  locationContinue(ContinueLocationEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      debugPrint("Location services are disabled.");
      // return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // locationMessage = "Location permission denied.";
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        "Location permission permanently denied. Enable from settings.",
      );
      // locationMessage =
      //     "Location permission permanently denied. Enable from settings.";
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    // );
    // if (placemarks.isNotEmpty) {
    //   place =
    //       "${placemarks.first.subLocality ?? ''} - ${placemarks.first.locality ?? ''}";
    //   // debugPrint(
    //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
    // }
    emit(
      LocationContinueSuccessState(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        place: "place",
      ),
    );
    debugPrint(
      "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
    );
    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }

  getGrabandGo(GrabAndGoEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final response = await http.get(Uri.parse(grabEssaentialsUrl));
      if (response.statusCode == 200) {
        var grabandessentials = grabandEssentialFromJson(response.body);
        emit(GrabandEssentialsLoadedState(grabandEssential: grabandessentials));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getBanner(GetBannerEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final response = await http.get(Uri.parse(bannerUrl));
      if (response.statusCode == 200) {
        var banners = bannerFromJson(response.body);
        emit(BannerLoadedState(banners: banners));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getMainCategoryData(
    GetMainCategoryDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final response = await http.get(Uri.parse(maincategoryUrl));
      if (response.statusCode == 200) {
        var mainCategories = mainCategoryFromJson(response.body);
        emit(MainCategoryLoadedState(mainCategory: mainCategories));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getCategoryData(GetCategoryDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final List<cat.Category> categories = categoryFromJson(response.body);
        emit(CategoryLoadedState(categories: categories));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getDynamicCategoryData(
    GetDynamicCategoryDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final dm.DynamicCategories categories = dm.dynamicCategoriesFromJson(
          response.body,
        );
        emit(DynamicCategoryLoadedState(categories: categories));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getDynamicHomeProductData(
    GetDynamicHomeProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      debugPrint('function statt');
      final prefs = await SharedPreferences.getInstance();
      phoneNumber = prefs.getString('phone') ?? '';
      isLoggedInvalue = prefs.getBool('isLoggedIn') ?? false;
      String url =
          isLoggedInvalue
              ? "$baseUrl/homeProduct/list?mobileNumber=${prefs.getString('phone')}"
              : "$baseUrl/homeProduct/list";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        debugPrint(response.body);
        DynamicProductStyleResponse riceCerealsResponse =
            dynamicProductStyleResponseFromJson(response.body);
        debugPrint(riceCerealsResponse.toJson().toString());
        emit(DynamicProductStyleResponseState(products: riceCerealsResponse));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }
}
