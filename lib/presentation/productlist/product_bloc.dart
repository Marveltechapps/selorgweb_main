import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:selorgweb_main/apiservice/post_method.dart' as api;
import 'package:selorgweb_main/model/cart/cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/model/category/product_detail_model.dart';
import 'package:selorgweb_main/model/category/product_style_error_model.dart';
import 'package:selorgweb_main/model/category/product_style_model.dart';
import 'package:selorgweb_main/model/category/remove_cart_response_model.dart';
import 'package:selorgweb_main/model/category/remove_item_cart_model.dart';
import 'package:selorgweb_main/model/category/sub_category_model.dart';
import 'package:selorgweb_main/presentation/productlist/product_event.dart';
import 'package:selorgweb_main/presentation/productlist/product_state.dart';
import 'package:selorgweb_main/utils/constant.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<OnScrollEvent>(onScroll);
    on<OnSelectEvent>(onSelect);
    on<AddButtonClikedEvent>(onAddbuttonclicked);
    on<RemoveItemButtonClikedEvent>(onRemoveItembuttonclicked);
    on<GetSubCategoryEvent>(getSubCategorydata);
    on<ProductStyleEvent>(getProductStyle);
    on<AddItemInCartApiEvent>(addItemsToCartApifunction);
    on<RemoveItemInCartApiEvent>(removeItemsToCartApifunction);
    on<ChangeVarientItemEvent>(changeVarientFunction);
    on<GetProductDetailEvent>(getProductDetail);
    on<CartLengthEvent>(getCartfunction);
  }

  ScrollController scrollController = ScrollController();
  static List<ProductList> productList = [];
  int page = 1;

  void onScroll(OnScrollEvent event, Emitter<ProductState> emit) {
    emit(ProductLoadingState());
    if (scrollController.position.atEdge) {
      bool isTop = scrollController.position.pixels == 0;
      if (isTop) {
        debugPrint('At the top');
      } else {
        page++;
        emit(OnScrollSuccessState(page: page));
      }
    }
    // if (scrollController.position.pixels >=
    //     scrollController.position.maxScrollExtent) {
    //   page + 1;
    //   emit(OnScrollSuccessState(page: page));
    // }
  }

  onSelect(OnSelectEvent event, Emitter<ProductState> emit) {
    emit(ProductLoadingState());
    emit(ProductSelectedState(index: event.index, name: event.name));
  }

  onAddbuttonclicked(AddButtonClikedEvent event, Emitter<ProductState> emit) {
    emit(ProductLoadingState());
    emit(
      AddButtonClickedState(
        type: event.type,
        selectedIndexes: event.index,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  onRemoveItembuttonclicked(
    RemoveItemButtonClikedEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductLoadingState());
    emit(
      RemoveButtonClickedState(
        type: event.type,
        selectedIndexes: event.index,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  getProductDetail(
    GetProductDetailEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      String url =
          "$productDetailUrl${event.productId}?mobileNumber=${event.mobileNo}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var productDetail = productDetailResponseFromJson(response.body);
        debugPrint(response.body);
        emit(ProductDetailSuccessState(productDetailResponse: productDetail));
      } else {
        emit(AddToCartErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(AddToCartErrorState(message: e.toString()));
    }
  }

  addItemsToCartApifunction(
    AddItemInCartApiEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = event.userId;
    addItemToCartRequest.productId = event.productId;
    addItemToCartRequest.quantity = event.quantity;
    addItemToCartRequest.variantLabel = event.variantLabel;
    addItemToCartRequest.imageUrl = event.imageUrl;
    addItemToCartRequest.price = event.price;
    addItemToCartRequest.discountPrice = event.discountPrice;
    addItemToCartRequest.deliveryInstructions = event.deliveryInstructions;
    addItemToCartRequest.addNotes = event.addNotes;

    try {
      String url = addCartUrl;
      // debugPrint(url);
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
        emit(AddToCartErrorState(message: response.resBody));
      }
    } catch (e) {
      emit(AddToCartErrorState(message: e.toString()));
    }
  }

  removeItemsToCartApifunction(
    RemoveItemInCartApiEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    RemoveItemToCartRequest removeItemToCartRequest = RemoveItemToCartRequest();
    removeItemToCartRequest.userId = event.userId;
    removeItemToCartRequest.productId = event.productId;
    removeItemToCartRequest.variantLabel = event.variantLabel;
    removeItemToCartRequest.quantity = event.quantity;
    removeItemToCartRequest.deliveryTip = event.deliveryTip;
    removeItemToCartRequest.handlingCharges = event.handlingCharges;
    try {
      String url = removeCartUrl;
      //  debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        removeItemToCartRequestToJson(removeItemToCartRequest),
      );
      if (response.statusCode == 200) {
        var removeCartResponse = removeCartResponseFromJson(response.resBody);
        emit(ItemRemovedToCartState(removeCartResponse: removeCartResponse));
      } else {
        emit(AddToCartErrorState(message: response.resBody));
      }
    } catch (e) {
      emit(AddToCartErrorState(message: e.toString()));
    }
  }

  changeVarientFunction(
    ChangeVarientItemEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductLoadingState());
    emit(
      VarientChangedState(
        productIndex: event.productIndex,
        varientIndex: event.varientIndex,
      ),
    );
  }

  getSubCategorydata(
    GetSubCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      String url =
          event.isMainCategory
              ? '$subCategoryUrl?main_category_id=${event.mainCatId}&mobileNumber=${event.mobileNo}&userId=${event.userId}'
              : '$subCategoryUrl?category_id=${event.catId}';
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var subCategory = subCategoryFromJson(response.body);
        emit(SubCategoryLoadedState(subCategory: subCategory));
      } else {
        emit(ProductErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }

  getCartfunction(CartLengthEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var cartResponse = cartResponseFromJson(response.body);
        emit(CartCountSuccessState(cartResponse: cartResponse));
      } else {
        emit(ProductErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }

  getProductStyle(ProductStyleEvent event, Emitter<ProductState> emit) async {
    if (page >= event.page) {
      emit(ProductLoadingState());
      try {
        // {{local_URL}}v1/productStyle/list?main_category_id=676431a2edae32578ae6d220&subCategoryId=676ad87c756fa03a5d0d0616
        String url =
            event.isMainCategory && event.isSubCategory
                ? '$productUrl?main_category_id=${event.mainCatId}&subCategoryId=${event.subCatId}&page=${event.page}&limit=50&mobileNumber=${event.mobilNo}&userId=${event.userId}'
                : event.isMainCategory
                ? '$productUrl?main_category_id=${event.mainCatId}'
                : event.isSubCategory
                ? '$productUrl?subCategoryId=${event.subCatId}&mobileNumber=${event.mobilNo}&userId=${event.userId}'
                : productUrl;
        debugPrint(url);
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var productStyleResponse = productStyleResponseFromJson(
            response.body,
          );
          // productList = [];
          productList.addAll(productStyleResponse.data ?? []);
          page = productStyleResponse.pagination!.totalPages ?? 0;
          emit(
            ProductStyleLoadedState(
              productStyleResponse: ProductStyleResponse(data: productList),
            ),
          );
        } else {
          var error = productStyleErrorFromJson(response.body);
          emit(
            ProductErrorState(message: error.message ?? "Failed to fetch data"),
          );
        }
      } catch (e) {
        emit(ProductErrorState(message: e.toString()));
      }
    } else {
      productList = [];
    }
  }
}
