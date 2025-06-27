abstract class OtpEvent {}

class InitialEvent extends OtpEvent {}

class StartTimer extends OtpEvent {}

class ResetTimer extends OtpEvent {}

class AddMultipleItemtoCartEvent extends OtpEvent {
  final String userId;

  AddMultipleItemtoCartEvent({required this.userId});
}

class ClearCartDataEvent extends OtpEvent {
  final String mobileNumber;

  ClearCartDataEvent({required this.mobileNumber});
}

class OtpEnteredEvent extends OtpEvent {
  final bool isEntered;
  final int index;
  final String otp;

  OtpEnteredEvent(
      {required this.isEntered, required this.index, required this.otp});
}

class Tick extends OtpEvent {
  final int duration;
  Tick(this.duration);

  List<Object> get props => [duration];
}

class VerifyOtpEvent extends OtpEvent {
  final String mobileNumber;
  final String otp;

  VerifyOtpEvent({required this.mobileNumber, required this.otp});
}

class SaveDataEvent extends OtpEvent {
  final String phoneNo;
  final String userId;

  SaveDataEvent({required this.phoneNo, required this.userId});
}

class AddItemInCartApiEvent extends OtpEvent {
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
    required this.skuName
  });
}

class ResendOtpEvent extends OtpEvent {
  final String mobileNumber;

  ResendOtpEvent({required this.mobileNumber});
}
