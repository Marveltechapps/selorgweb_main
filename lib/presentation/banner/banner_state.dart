import 'package:selorgweb_main/model/banner/banner_product_response_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/model/category/remove_cart_response_model.dart';

abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadingState extends BannerState {}

class PraductSuccessState extends BannerState {
  final BannerProductResponse bannerProductResponse;

  PraductSuccessState({required this.bannerProductResponse});
}

class CartUpdateLocal extends BannerState {
  final int noOfItems;

  CartUpdateLocal({required this.noOfItems});
}
class VarientChangedState extends BannerState {
  final int productIndex;
  final int varientIndex;

  VarientChangedState({required this.productIndex, required this.varientIndex});
}
class AddButtonPressedState extends BannerState {
  final int index;
  final int varientindex;
  final String type;

  AddButtonPressedState(
      {required this.index, required this.varientindex, required this.type});
}

class AddedToCartState extends BannerState {
  final AddItemToCartResponse addItemToCartResponse;

  AddedToCartState({required this.addItemToCartResponse});
}

class RemoveButtonPressedState extends BannerState {
  final int index;
  final int varientindex;
  final String type;

  RemoveButtonPressedState(
      {required this.index, required this.varientindex, required this.type});
}

class RemoveItemFromCartState extends BannerState {
  final RemoveCartResponse removeCartResponse;

  RemoveItemFromCartState({required this.removeCartResponse});
}

class CartCountLengthOnBannerSuccessState extends BannerState {
  final int countvalue;

  CartCountLengthOnBannerSuccessState({required this.countvalue});
}

class BannerErrorState extends BannerState {
  final String errorMsg;

  BannerErrorState({required this.errorMsg});
}
