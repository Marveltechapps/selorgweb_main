// import 'package:selorg/model/cart/cart_model.dart';
// import 'package:selorg/model/category/add_item_cart_response_model.dart';
// import 'package:selorg/model/category/product_detail_model.dart';
// import 'package:selorg/model/category/product_style_model.dart';
// import 'package:selorg/model/category/remove_cart_response_model.dart';
// import 'package:selorg/model/category/sub_category_model.dart';

import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/model/category/product_detail_model.dart';
import 'package:selorgweb_main/model/category/product_style_model.dart';
import 'package:selorgweb_main/model/category/remove_cart_response_model.dart';
import 'package:selorgweb_main/model/category/sub_category_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class OnScrollSuccessState extends ProductState {
  final int page;

  OnScrollSuccessState({required this.page});
}

class VarientChangedState extends ProductState {
  final int productIndex;
  final int varientIndex;

  VarientChangedState({required this.productIndex, required this.varientIndex});
}

class ProductSelectedState extends ProductState {
  final int index;
  final String name;

  ProductSelectedState({required this.index, required this.name});
}

class SubCategoryLoadedState extends ProductState {
  final SubCategory subCategory;

  SubCategoryLoadedState({required this.subCategory});
}

class ProductStyleLoadedState extends ProductState {
  final ProductStyleResponse productStyleResponse;

  ProductStyleLoadedState({required this.productStyleResponse});
}

class CartCountSuccessState extends ProductState {
  final CartResponse cartResponse;

  CartCountSuccessState({required this.cartResponse});
}

class AddButtonClickedState extends ProductState {
  String type;
  int selectedIndexes;
  bool isSelected;
  AddButtonClickedState(
      {required this.type,
      required this.selectedIndexes,
      required this.isSelected});
}

class ItemAddedToCartState extends ProductState {
  final AddItemToCartResponse addItemToCartResponse;

  ItemAddedToCartState({required this.addItemToCartResponse});
}

class ItemRemovedToCartState extends ProductState {
  final RemoveCartResponse removeCartResponse;

  ItemRemovedToCartState({required this.removeCartResponse});
}

class RemoveButtonClickedState extends ProductState {
  String type;
  int selectedIndexes;
  bool isSelected;
  RemoveButtonClickedState(
      {required this.type,
      required this.selectedIndexes,
      required this.isSelected});
}

class ProductDataState extends ProductState {}

class ProductDetailSuccessState extends ProductState {
  final ProductDetailResponse productDetailResponse;

  ProductDetailSuccessState({required this.productDetailResponse});
}

class AddToCartErrorState extends ProductState {
  final String message;

  AddToCartErrorState({required this.message});
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});
}
