import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/presentation/entry/login/login_event.dart';
import 'package:selorgweb_main/presentation/entry/login/login_state.dart';
import 'package:selorgweb_main/apiservice/post_method.dart' as api;
import 'package:selorgweb_main/utils/constant.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<PhoneNumberEnteredvent>(phonenumbercheck);
    on<SendOtpEvent>(sendOtp);
    on<ClearCartDataEvent>(clearCart);
  }

  clearCart(ClearCartDataEvent event, Emitter<LoginState> emit) async {
    String url = "$clearCartUrl${event.mobileNumber}";
    debugPrint(url);
    try {
      api.Response res = await api.ApiService().postRequest(url, null);

      if (res.statusCode == 200) {
        // var body = jsonDecode(res.resBody);
        // emit(OtpSuccessState(message: "${body["message"]}"));
      } else {
        // emit(OtpErrorState(errorMessage: "Request Failed!"));
      }
    } catch (e) {
      // emit(OtpErrorState(errorMessage: e.toString()));
    }
  }

  phonenumbercheck(PhoneNumberEnteredvent event, Emitter<LoginState> emit) {
    emit(PhoneNumberCheckState());
    emit(PhoneNumberSuccessState(isEnable: event.isEnable));
  }

  sendOtp(SendOtpEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
          otpUrl, jsonEncode({"mobileNumber": event.mobileNumber}));

      if (res.statusCode == 200) {
        var body = jsonDecode(res.resBody);
        emit(OtpSuccessState(message: "${body["message"]}"));
      } else {
        emit(OtpErrorState(errorMessage: "Request Failed!"));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }
}
