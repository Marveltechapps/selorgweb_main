abstract class LoginEvent {}

class PhoneNumberEnteredvent extends LoginEvent {
  final bool isEnable;

  PhoneNumberEnteredvent({required this.isEnable});
}

class ClearCartDataEvent extends LoginEvent {
  final String mobileNumber;

  ClearCartDataEvent({required this.mobileNumber});
}

class SendOtpEvent extends LoginEvent {
  final String mobileNumber;

  SendOtpEvent({required this.mobileNumber});
}
