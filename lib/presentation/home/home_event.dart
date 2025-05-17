import 'package:selorgweb_main/model/category/product_style_model.dart';

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class GetLocationEvent extends HomeEvent {}

class ContinueLocationEvent extends HomeEvent {}

class GetCartCountEvent extends HomeEvent {
  final String userId;

  GetCartCountEvent({required this.userId});
}

class PlaceLocaitonEvent extends HomeEvent {
  final String locationText;

  PlaceLocaitonEvent({required this.locationText});
}

class GetLatLonOnListEvent extends HomeEvent {
  final String placeId;

  GetLatLonOnListEvent({required this.placeId});
}

class SearchLocationEvent extends HomeEvent {
  final String searchText;

  SearchLocationEvent({required this.searchText});
}

class GetLocationUsingLatLongFromApiEvent extends HomeEvent {
  final String latitude;
  final String longitude;

  GetLocationUsingLatLongFromApiEvent({
    required this.latitude,
    required this.longitude,
  });
}

class AddButtonClikedEvent extends HomeEvent {
  final ProductStyleResponse response;
  final String type;
  final bool isButtonPressed;
  final int index;

  AddButtonClikedEvent({
    required this.response,
    required this.type,
    required this.isButtonPressed,
    required this.index,
  });
}

class AddItemInCartApiEvent extends HomeEvent {
  final String userId;
  final String productId;
  final int quantity;
  final String variantLabel;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String deliveryInstructions;
  final String addNotes;

  AddItemInCartApiEvent({
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.variantLabel,
    required this.imageUrl,
    required this.price,
    required this.discountPrice,
    required this.deliveryInstructions,
    required this.addNotes,
  });
}

class RemoveItemButtonClikedEvent extends HomeEvent {
  final ProductStyleResponse response;
  final String type;
  final bool isButtonPressed;
  final int index;

  RemoveItemButtonClikedEvent({
    required this.response,
    required this.type,
    required this.isButtonPressed,
    required this.index,
  });
}

class RemoveItemInCartApiEvent extends HomeEvent {
  final String userId;
  final String productId;
  final String variantLabel;
  final int quantity;
  final int deliveryTip;
  final int handlingCharges;

  RemoveItemInCartApiEvent({
    required this.userId,
    required this.productId,
    required this.variantLabel,
    required this.quantity,
    required this.deliveryTip,
    required this.handlingCharges,
  });
}

class UpdateLocationEvent extends HomeEvent {
  final String location;

  UpdateLocationEvent({required this.location});
}

class GetScreenEvent extends HomeEvent {
  final int cartcount;
  final int index;

  GetScreenEvent({required this.cartcount, required this.index});
}

class GetOrganicFruitsEvent extends HomeEvent {
  final String mainCatId;
  final String subCatId;
  final String mobileNo;

  GetOrganicFruitsEvent({
    required this.mainCatId,
    required this.subCatId,
    required this.mobileNo,
  });
}

class GetGroceryEssentialsEvent extends HomeEvent {
  final String subCatId;
  final String mobileNo;

  GetGroceryEssentialsEvent({required this.subCatId, required this.mobileNo});
}

class GetNutsDriedFruitsEvent extends HomeEvent {
  final String subCatId;
  final String mobileNo;

  GetNutsDriedFruitsEvent({required this.mobileNo, required this.subCatId});
}

class GetRiceCerealsEvent extends HomeEvent {
  final String mainCatId;
  final String subCatId;
  final String mobileNo;

  GetRiceCerealsEvent({
    required this.mobileNo,
    required this.mainCatId,
    required this.subCatId,
  });
}

class GetMainCategoryDataEvent extends HomeEvent {}

class GetCategoryDataEvent extends HomeEvent {}

class ShowBottomSheetEvent extends HomeEvent {}

class GrabAndGoEvent extends HomeEvent {}

class GetBannerEvent extends HomeEvent {}
