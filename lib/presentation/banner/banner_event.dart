abstract class BannerEvent {}

class GetProductDetailsEvent extends BannerEvent {
  final String bannerId;

  GetProductDetailsEvent({required this.bannerId});
}

class AddButtonPressedEvent extends BannerEvent {
  final String type;
  final int index;
  final int varientindex;

  AddButtonPressedEvent(
      {required this.type, required this.index, required this.varientindex});
}

class ChangeVarientItemEvent extends BannerEvent {
  final int productIndex;
  final int varientIndex;

  ChangeVarientItemEvent(
      {required this.productIndex, required this.varientIndex});
}

class AddItemApiEvent extends BannerEvent {
  final String userId;
  final String productId;
  final int quantity;
  final String variantLabel;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String deliveryInstructions;
  final String addNotes;
  final String skuName;

  AddItemApiEvent(
      {required this.userId,
      required this.productId,
      required this.quantity,
      required this.variantLabel,
      required this.imageUrl,
      required this.price,
      required this.discountPrice,
      required this.deliveryInstructions,
      required this.addNotes,
      required this.skuName
      });
}

class RemoveItemApiEvent extends BannerEvent {
  final String userId;
  final String productId;
  final String variantLabel;
  final int quantity;
  final int deliveryTip;
  final int handlingcharges;

  RemoveItemApiEvent(
      {required this.userId,
      required this.productId,
      required this.variantLabel,
      required this.quantity,
      required this.deliveryTip,
      required this.handlingcharges});
}


class GetCartCountEvent extends BannerEvent {
  final String userId;

  GetCartCountEvent({required this.userId});
}

class GetCartCountLengthOnBannerEvent extends BannerEvent {
  final String userId;

  GetCartCountLengthOnBannerEvent({required this.userId});
}

class RemoveButtonPressedEvent extends BannerEvent {
  final String type;
  final int index;
  final int varientindex;

  RemoveButtonPressedEvent(
      {required this.type, required this.index, required this.varientindex});
}
