abstract class ProductEvent {}

class OnScrollEvent extends ProductEvent {}

class OnSelectEvent extends ProductEvent {
  final int index;
  final String name;

  OnSelectEvent({required this.index, required this.name});
}

class CartLengthEvent extends ProductEvent {
  final String userId;

  CartLengthEvent({required this.userId});
}

class GetSubCategoryEvent extends ProductEvent {
  final bool isMainCategory;
  final String mainCatId;
  final bool isCat;
  final String catId;
  final String mobileNo;
  final String userId;

  GetSubCategoryEvent(
      {required this.isMainCategory,
      required this.mainCatId,
      required this.isCat,
      required this.catId,
      required this.mobileNo,
      required this.userId});
}

class ProductStyleEvent extends ProductEvent {
  final String mobilNo;
  final String userId;
  final bool isMainCategory;
  final String mainCatId;
  final bool isSubCategory;
  final String subCatId;
  final int page;

  ProductStyleEvent(
      {required this.mobilNo,
      required this.userId,
      required this.isMainCategory,
      required this.mainCatId,
      required this.isSubCategory,
      required this.subCatId,
      required this.page});
}

class AddItemInCartApiEvent extends ProductEvent {
  final String userId;
  final String productId;
  final int quantity;
  final String variantLabel;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String deliveryInstructions;
  final String addNotes;

  AddItemInCartApiEvent(
      {required this.userId,
      required this.productId,
      required this.quantity,
      required this.variantLabel,
      required this.imageUrl,
      required this.price,
      required this.discountPrice,
      required this.deliveryInstructions,
      required this.addNotes});
}

class RemoveItemInCartApiEvent extends ProductEvent {
  final String userId;
  final String productId;
  final String variantLabel;
  final int quantity;
  final int deliveryTip;
  final int handlingCharges;

  RemoveItemInCartApiEvent(
      {required this.userId,
      required this.productId,
      required this.variantLabel,
      required this.quantity,
      required this.deliveryTip,
      required this.handlingCharges});
}

class GetProductDetailEvent extends ProductEvent {
  final String mobileNo;
  final String productId;

  GetProductDetailEvent({required this.mobileNo, required this.productId});
}

class ChangeVarientItemEvent extends ProductEvent {
  final int productIndex;
  final int varientIndex;

  ChangeVarientItemEvent(
      {required this.productIndex, required this.varientIndex});
}

class AddButtonClikedEvent extends ProductEvent {
  final String type;
  final bool isButtonPressed;
  final int index;

  AddButtonClikedEvent(
      {required this.type, required this.isButtonPressed, required this.index});
}

class RemoveItemButtonClikedEvent extends ProductEvent {
  final String type;
  final bool isButtonPressed;
  final int index;

  RemoveItemButtonClikedEvent(
      {required this.type, required this.isButtonPressed, required this.index});
}
