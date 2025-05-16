
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/presentation/cart/cart_event.dart';
import 'package:selorgweb_main/presentation/cart/cart_state.dart';
import 'package:selorgweb_main/utils/constant.dart';

class CartBloc extends Bloc<CartEvent , CartState>{
  CartBloc():super(CartInitialState()){
        on<GetCartDetailsEvent>(getCartDetails);

  }

    getCartDetails(GetCartDetailsEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var cartResponse = cartResponseFromJson(response.body);
        emit(CartDataSuccess(cartResponse: cartResponse));
      } else {
        emit(CartErrorState(errormsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CartErrorState(errormsg: e.toString()));
    }
  }
}