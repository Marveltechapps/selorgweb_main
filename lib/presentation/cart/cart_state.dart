
import 'package:selorgweb_main/model/cart/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartDataSuccess extends CartState {
  final CartResponse cartResponse;

  CartDataSuccess({required this.cartResponse});
}

class CartErrorState extends CartState {
  final String errormsg;

  CartErrorState({required this.errormsg});
}