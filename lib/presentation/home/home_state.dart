import 'package:selorgweb_main/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:selorgweb_main/model/addaddress/search_location_response_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/category_model.dart' as cat;
import 'package:selorgweb_main/model/category/dynamic_category_model.dart' as dm;
import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/model/category/product_style_model.dart';
import 'package:selorgweb_main/model/category/remove_cart_response_model.dart';
import 'package:selorgweb_main/model/home/banner_model.dart';
import 'package:selorgweb_main/model/home/dynamic_product_style_response_model.dart';
import 'package:selorgweb_main/model/home/grab_essentials_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeDummyState extends HomeState {}

class HomeLoadingState extends HomeState {}

class UpdateLocationState extends HomeState {
  final String location;

  UpdateLocationState({required this.location});
}

class AddButtonClickedState extends HomeState {
  Product response;
  String type;
  int selectedIndexes;
  bool isSelected;
  AddButtonClickedState({
    required this.response,
    required this.type,
    required this.selectedIndexes,
    required this.isSelected,
  });
}

class CartDataSuccess extends HomeState {
  final int noOfItems;

  CartDataSuccess({required this.noOfItems});
}

class NavigateState extends HomeState {
  final int index;

  NavigateState({required this.index});
}

class LocationSuccessState extends HomeState {
  String? latitude;
  String? longitude;
  String? place;

  LocationSuccessState({
    required this.latitude,
    required this.longitude,
    required this.place,
  });
}

class LocationContinueSuccessState extends HomeState {
  String? latitude;
  String? longitude;
  String? place;

  LocationContinueSuccessState({
    required this.latitude,
    required this.longitude,
    required this.place,
  });
}


class LatLongSuccessState extends HomeState {
  String latitude;
  String longitude;

  LatLongSuccessState({required this.latitude, required this.longitude});
}

class PlaceLocaitonState extends HomeState {
  final String locationText;

  PlaceLocaitonState({required this.locationText});
}

class SearchedLocationSuccessState extends HomeState {
  final List<SearchedLocationResponse> searchedLocationResponse;

  SearchedLocationSuccessState({required this.searchedLocationResponse});
}

class LatLongAddressSuccessState extends HomeState {
 final LatLongLocationResponse latLongLocationResponse;

  LatLongAddressSuccessState({required this.latLongLocationResponse});
}

class BottomSheetVisible extends HomeState {}

class RemoveButtonClickedState extends HomeState {
  Product response;
  String type;
  int selectedIndexes;
  bool isSelected;
  RemoveButtonClickedState({
    required this.response,
    required this.type,
    required this.selectedIndexes,
    required this.isSelected,
  });
}

class ItemRemovedToCartState extends HomeState {
  final RemoveCartResponse removeCartResponse;

  ItemRemovedToCartState({required this.removeCartResponse});
}

class OrganicFreshFruitsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  OrganicFreshFruitsLoadedState({required this.productStyleResponse});
}

class ItemAddedToCartInHomeScreenState extends HomeState {
  final AddItemToCartResponse addItemToCartResponse;

  ItemAddedToCartInHomeScreenState({required this.addItemToCartResponse});
}

class GroceryEssentialsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  GroceryEssentialsLoadedState({required this.productStyleResponse});
}

class NutsDriedFruitsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  NutsDriedFruitsLoadedState({required this.productStyleResponse});
}

class RiceCerealsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  RiceCerealsLoadedState({required this.productStyleResponse});
}

class GrabandEssentialsLoadedState extends HomeState {
  final GrabandEssential grabandEssential;

  GrabandEssentialsLoadedState({required this.grabandEssential});
}

class MainCategoryLoadedState extends HomeState {
  final MainCategory mainCategory;

  MainCategoryLoadedState({required this.mainCategory});
}

class CategoryLoadedState extends HomeState {
  final List<cat.Category> categories;

  CategoryLoadedState({required this.categories});
}

class BannerLoadedState extends HomeState {
  final Banner banners;

  BannerLoadedState({required this.banners});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}

class DynamicCategoryLoadedState extends HomeState {
  final dm.DynamicCategories categories;

  DynamicCategoryLoadedState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class DynamicProductStyleResponseState extends HomeState{
  final DynamicProductStyleResponse products;

  DynamicProductStyleResponseState({required this.products});
}