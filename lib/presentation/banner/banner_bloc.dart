import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/model/banner/banner_error_response.dart';
import 'package:selorgweb_main/model/banner/banner_product_response_model.dart';
import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/model/category/remove_cart_response_model.dart';
import 'package:selorgweb_main/model/category/remove_item_cart_model.dart';
import 'package:selorgweb_main/presentation/banner/banner_event.dart';
import 'package:selorgweb_main/presentation/banner/banner_state.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/apiservice/post_method.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitialState()) {
    on<GetProductDetailsEvent>(getProductDetails);
    on<AddButtonPressedEvent>(onAddPressed);
    on<RemoveButtonPressedEvent>(onRemovePressed);
    on<AddItemApiEvent>(addItemToApi);
    on<RemoveItemApiEvent>(removeItemFromCartApifunction);
    on<GetCartCountLengthOnBannerEvent>(getCartCountOnBannerfunction);
  }

  onAddPressed(AddButtonPressedEvent event, Emitter<BannerState> emit) {
    emit(BannerLoadingState());
    emit(
      AddButtonPressedState(
        index: event.index,
        varientindex: event.varientindex,
        type: event.type,
      ),
    );
  }

  addItemToApi(AddItemApiEvent event, Emitter<BannerState> emit) async {
    emit(BannerLoadingState());
    AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = event.userId;
    addItemToCartRequest.productId = event.productId;
    addItemToCartRequest.quantity = event.quantity;
    addItemToCartRequest.variantLabel = event.variantLabel;
    addItemToCartRequest.imageUrl = event.imageUrl;
    addItemToCartRequest.skuName = event.skuName;
    addItemToCartRequest.price = event.price;
    addItemToCartRequest.discountPrice = event.discountPrice;
    addItemToCartRequest.deliveryInstructions = event.deliveryInstructions;
    addItemToCartRequest.addNotes = event.addNotes;
    try {
      String url = addCartUrl;
      debugPrint(url);
      if (isLoggedInvalue) {
        api.Response response = await api.ApiService().postRequest(
          url,
          addItemToCartRequestToJson(addItemToCartRequest),
        );
        if (response.statusCode == 200) {
          var addItemToCartResponse = addItemToCartResponseFromJson(
            response.resBody,
          );
          emit(AddedToCartState(addItemToCartResponse: addItemToCartResponse));
        } else {
          emit(BannerErrorState(errorMsg: response.resBody));
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        List<dynamic> cartdata = jsonDecode(prefs.getString('cartdata') ?? '');
        String data = addItemToCartRequestToJson(addItemToCartRequest);
        cartdata.add(jsonDecode(data));
        debugPrint('add cart rough $cartdata');
        await prefs.setString('cartdata', jsonEncode(cartdata));
        emit(CartUpdateLocal(noOfItems: cartdata.length));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }

  onRemovePressed(RemoveButtonPressedEvent event, Emitter<BannerState> emit) {
    emit(BannerLoadingState());
    emit(
      RemoveButtonPressedState(
        index: event.index,
        varientindex: event.varientindex,
        type: event.type,
      ),
    );
  }

  removeItemFromCartApifunction(
    RemoveItemApiEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerLoadingState());
    RemoveItemToCartRequest removeItemToCartRequest = RemoveItemToCartRequest();
    removeItemToCartRequest.userId = event.userId;
    removeItemToCartRequest.productId = event.productId;
    removeItemToCartRequest.variantLabel = event.variantLabel;
    removeItemToCartRequest.quantity = event.quantity;
    removeItemToCartRequest.handlingCharges = event.handlingcharges;
    removeItemToCartRequest.deliveryTip = event.deliveryTip;
    try {
      String url = removeCartUrl;
      //  debugPrint(url);
      if (isLoggedInvalue) {
        api.Response response = await api.ApiService().postRequest(
          url,
          removeItemToCartRequestToJson(removeItemToCartRequest),
        );
        if (response.statusCode == 200) {
          var removeCartResponse = removeCartResponseFromJson(response.resBody);
          emit(RemoveItemFromCartState(removeCartResponse: removeCartResponse));
        } else {
          emit(BannerErrorState(errorMsg: response.resBody));
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
        emit(CartUpdateLocal(noOfItems: cartdata.length));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }

  getCartCountOnBannerfunction(
    GetCartCountLengthOnBannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerLoadingState());
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var cartResponse = cartResponseFromJson(response.body);
        cartResponse.items!.length;
        int countvalue = 0;
        for (int i = 0; i < cartResponse.items!.length; i++) {
          countvalue = countvalue + cartResponse.items![i].quantity!;
        }
        emit(CartCountLengthOnBannerSuccessState(countvalue: countvalue));
      } else {
        emit(BannerErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }

  getProductDetails(
    GetProductDetailsEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerLoadingState());
    try {
      String url =
          "$bannerProductUrl?banner_id=${event.bannerId}&mobileNumber=$phoneNumber";
      debugPrint("url: $url");
      //banner_id=677212d080a962bfdeb320e0&product_id=6793896361c4500641a079c2
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var bannerProduct = bannerProductResponseFromJson(response.body);
        emit(PraductSuccessState(bannerProductResponse: bannerProduct));
      } else {
        var res = bannerProductErrorResponseFromJson(response.body);
        emit(BannerErrorState(errorMsg: res.msg ?? ""));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }
}
