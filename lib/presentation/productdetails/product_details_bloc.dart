import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/apiservice/post_method.dart' as api;
import 'package:selorgweb_main/apiservice/secure_storage/secure_storage.dart';
import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/model/category/product_detail_error_response_model.dart';
import 'package:selorgweb_main/model/category/product_detail_model.dart';
import 'package:selorgweb_main/model/category/remove_cart_response_model.dart';
import 'package:selorgweb_main/model/category/remove_item_cart_model.dart';
import 'package:selorgweb_main/model/category/similar_product_detail_response_model.dart';
import 'package:selorgweb_main/model/category/similar_product_response_model.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_event.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_state.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitialState()) {
    on<GetProductDetailEvent>(getProductDetail);
    on<LabelVarientItemEvent>(changeVarientFunction);
    on<AddButtonClikedEvent>(onAddbuttonclicked);
    on<RemoveItemButtonClikedEvent>(onRemoveItembuttonclicked);
    on<AddItemInCartApiEvent>(addItemsToCartApifunction);
    on<RemoveItemInCartApiEvent>(removeItemsToCartApifunction);
    on<GetSimilarProductEvent>(getSimiralProductfunction);
    on<GetCartCountLengthEvent>(getCartCountfunction);
    on<GetSimilarProductDetailEvent>(getSimiralProductDetailfunction);
    on<UpdateSimilarIndexEvent>(updateSimilarIndex);
  }

  updateSimilarIndex(
    UpdateSimilarIndexEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(ProductDetailLoadingState());
    emit(
      UpdateSimilarProductIndexState(
        index: event.index,
        similarIndex: event.similarIndex,
      ),
    );
  }

  changeVarientFunction(
    LabelVarientItemEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(ProductDetailLoadingState());
    emit(
      LabelChangedState(
        productIndex: event.productIndex,
        varientIndex: event.varientIndex,
      ),
    );
  }

  onAddbuttonclicked(
    AddButtonClikedEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(ProductDetailLoadingState());
    emit(
      AddButtonClickedState(
        type: event.type,
        selectedIndexes: event.index,
        similarIndex: event.similarIndex,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  onRemoveItembuttonclicked(
    RemoveItemButtonClikedEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(ProductDetailLoadingState());
    emit(
      RemoveButtonClickedState(
        type: event.type,
        selectedIndexes: event.index,
        similarIndex: event.similarIndex,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  addItemsToCartApifunction(
    AddItemInCartApiEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadingState());
    AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = event.userId;
    addItemToCartRequest.productId = event.productId;
    addItemToCartRequest.quantity = event.quantity;
    addItemToCartRequest.skuName = event.skuName;
    addItemToCartRequest.variantLabel = event.variantLabel;
    addItemToCartRequest.imageUrl = event.imageUrl;
    addItemToCartRequest.price = event.price;
    addItemToCartRequest.discountPrice = event.discountPrice;
    addItemToCartRequest.deliveryInstructions = event.deliveryInstructions;
    addItemToCartRequest.addNotes = event.addNotes;
    try {
      String url = addCartUrl;
      // debugPrint(url);
      if (isLoggedInvalue) {
        api.Response response = await api.ApiService().postRequest(
          url,
          addItemToCartRequestToJson(addItemToCartRequest),
        );
        if (response.statusCode == 200) {
          var addItemToCartResponse = addItemToCartResponseFromJson(
            response.resBody,
          );
          emit(
            ItemAddedToCartState(addItemToCartResponse: addItemToCartResponse),
          );
        } else {
          emit(ProductDetailErrorState(errorMsg: response.resBody));
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        List<dynamic> cartdata = jsonDecode(prefs.getString('cartdata') ?? '');
        String data = addItemToCartRequestToJson(addItemToCartRequest);
        cartdata.add(jsonDecode(data));
        debugPrint('add cart rough $cartdata');
        await prefs.setString('cartdata', jsonEncode(cartdata));
        debugPrint('hello');
        emit(CartUpdateLocal(noOfcartResponse: cartdata.length));
      }
    } catch (e) {
      emit(ProductDetailErrorState(errorMsg: e.toString()));
    }
  }

  removeItemsToCartApifunction(
    RemoveItemInCartApiEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadingState());
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
          emit(ItemRemovedToCartState(removeCartResponse: removeCartResponse));
        } else {
          emit(ProductDetailErrorState(errorMsg: response.resBody));
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
        emit(CartUpdateLocal(noOfcartResponse: cartdata.length));
      }
    } catch (e) {
      emit(ProductDetailErrorState(errorMsg: e.toString()));
    }
  }

  getCartCountfunction(
    GetCartCountLengthEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadingState());
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url) , headers: {
          "Authorization":"Bearer ${await TokenService.getToken()}"
        });
      if (response.statusCode == 200) {
        var cartResponse = cartResponseFromJson(response.body);
        emit(CartCountLengthSuccessState(cartResponse: cartResponse));
      } else {
        emit(ProductDetailErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(ProductDetailErrorState(errorMsg: e.toString()));
    }
  }

  getProductDetail(
    GetProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadingState());
    try {
      String url =
          "$productDetailUrl${event.productId}?mobileNumber=${event.mobileNo}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var productDetail = productDetailResponseFromJson(response.body);
        emit(ProductDetailSuccessState(productDetailResponse: productDetail));
      } else {
        var errorResponse = productErrorResponseFromJson(response.body);
        emit(
          ProductDetailErrorState(
            errorMsg: errorResponse.message ?? "Failed to fetch data",
          ),
        );
      }
    } catch (e) {
      emit(ProductDetailErrorState(errorMsg: e.toString()));
    }
  }

  getSimiralProductfunction(
    GetSimilarProductEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadingState());
    try {
      String url =
          "$similarProductUrl${event.productId}&mobileNumber=$phoneNumber";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var similarProductResponse = similarProductResponseFromJson(
          response.body,
        );
        emit(
          SimilarProductSuccessState(
            similarProductResponse: similarProductResponse,
          ),
        );
      } else {
        emit(ProductDetailErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(ProductDetailErrorState(errorMsg: e.toString()));
    }
  }

  getSimiralProductDetailfunction(
    GetSimilarProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadingState());
    try {
      String url = "$similarProductDetailUrl${event.productId}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var similarProductDetailResponse = similarProductDetailResponseFromJson(
          response.body,
        );
        emit(
          SimilarProductDetailSuccessState(
            similarProductDetailResponse: similarProductDetailResponse,
          ),
        );
      } else {
        emit(ProductDetailErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(ProductDetailErrorState(errorMsg: e.toString()));
    }
  }
}
