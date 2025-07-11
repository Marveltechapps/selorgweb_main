import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/model/category/add_item_cart_model.dart';
import 'package:selorgweb_main/model/category/add_item_cart_response_model.dart';
import 'package:selorgweb_main/presentation/entry/otp/otp_event.dart';
import 'package:selorgweb_main/apiservice/post_method.dart' as api;
import 'package:selorgweb_main/model/otp/verify_otp_response_model.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitialState()) {
    on<OtpEnteredEvent>(otpenterfunction);
    on<StartTimer>(onStart);
    on<Tick>(onTick);
    on<ResetTimer>(onReset);
    on<VerifyOtpEvent>(verifyOtp);
    on<ResendOtpEvent>(resendOtp);
    on<SaveDataEvent>(saveData);
    on<AddItemInCartApiEvent>(addItemToCart);
    on<AddMultipleItemtoCartEvent>(addMultipleItemToCart);
    on<ClearCartDataEvent>(clearCart);
  }
  static const int initialDuration = 20 * 1; // 20 minutes in seconds
  late StreamSubscription<int> tickerSubscription;
clearCart(ClearCartDataEvent event, Emitter<OtpState> emit) async {
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
  saveData(SaveDataEvent event, Emitter<OtpState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', event.phoneNo);
    await prefs.setString('userid', event.userId);
    await prefs.setBool('isLoggedIn', true);
    isLoggedInvalue = true;
    emit(SPsaveSucess());
  }

  void onStart(StartTimer event, Emitter<OtpState> emit) {
    emit(OtpLoadingState());
    emit(TimerRunning(duration: initialDuration));
    startTicker(initialDuration);
  }

  void startTicker(int duration) {
    tickerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (x) => duration - x - 1,
    ).take(duration).listen((remaining) => add(Tick(remaining)));
  }

  void onTick(Tick event, Emitter<OtpState> emit) {
    if (event.duration >= 0) {
      emit(TimerRunning(duration: event.duration));
    } else {
      emit(TimerCompleted(duration: event.duration));
    }
  }

  void onReset(ResetTimer event, Emitter<OtpState> emit) {
    tickerSubscription.cancel();
    startTicker(initialDuration);
    emit(TimerRunning(duration: initialDuration));
  }

  otpenterfunction(OtpEnteredEvent event, Emitter<OtpState> emit) {
    emit(OtpLoadingState());
    emit(
      OtpEnteredState(
        isEntered: event.isEntered,
        index: event.index,
        otp: event.otp,
      ),
    );
  }

  verifyOtp(VerifyOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
        verifyOtpUrl,
        jsonEncode({
          "mobileNumber": event.mobileNumber,
          "enteredOTP": event.otp,
        }),
      );

      if (res.statusCode == 200) {
        var body = verifyOtpResponseFromJson(res.resBody);
        emit(OtpSuccessState(verifyOtpResponse: body));
      } else {
        var body = jsonDecode(res.resBody);
        emit(OtpErrorState(errorMessage: body["message"]));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }

  resendOtp(ResendOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
        resendOtpUrl,
        jsonEncode({"mobileNumber": event.mobileNumber}),
      );

      if (res.statusCode == 200) {
        var body = jsonDecode(res.resBody);
        emit(OtpResendState(message: body["message"]));
      } else {
        var body = jsonDecode(res.resBody);
        emit(OtpErrorState(errorMessage: body["message"]));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }
  addMultipleItemToCart(AddMultipleItemtoCartEvent event , Emitter<OtpState> emit)async{
    emit(OtpLoadingState());
         final prefs = await SharedPreferences.getInstance();
            List<dynamic> cartdata = jsonDecode(
              prefs.getString('cartdata') ?? '[]',
            );
            debugPrint('cartdata $cartdata');
    List<dynamic> updatedCartItems = cartdata.map((item) {
  return {
    ...item,
    "userId": userId,
  };
}).toList();

        for(var e in cartdata){
           AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = userId;
    addItemToCartRequest.productId = e['productId'];
    addItemToCartRequest.skuName = e['skuName'];
    addItemToCartRequest.quantity = e['quantity'];
    addItemToCartRequest.variantLabel = e['variantLabel'];
    addItemToCartRequest.imageUrl = e['imageUrl'];
    addItemToCartRequest.price = e['price'];
    addItemToCartRequest.discountPrice = e['discountPrice'];
    addItemToCartRequest.deliveryInstructions = e['deliveryInstructions'];
    addItemToCartRequest.addNotes = e['addNotes'];
      debugPrint(addItemToCartRequest.toJson().toString());
String url = addCartUrl;
        debugPrint(url);
        api.Response response = await api.ApiService().postRequest(
          addCartUrl,
          addItemToCartRequestToJson(addItemToCartRequest),
        );
        if (response.statusCode == 200) {
          if(updatedCartItems.indexOf(e) == updatedCartItems.length -1){
            emit(CartDataSuccess());
            break;
          }

          continue;
        } else {
          continue;
        }
        }
        if(cartdata.isEmpty){
          emit(CartDataSuccess());
        }
        emit(CartDataSuccess());
  }
  addItemToCart(AddItemInCartApiEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoadingState());
    AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = event.userId;
    addItemToCartRequest.productId = event.productId;
    addItemToCartRequest.skuName = event.skuName;
    addItemToCartRequest.quantity = event.quantity;
    addItemToCartRequest.variantLabel = event.variantLabel;
    addItemToCartRequest.imageUrl = event.imageUrl;
    addItemToCartRequest.price = event.price;
    addItemToCartRequest.discountPrice = event.discountPrice;
    addItemToCartRequest.deliveryInstructions = event.deliveryInstructions;
    addItemToCartRequest.addNotes = event.addNotes;
    try {
      if (isLoggedInvalue == true) {
        String url = addCartUrl;
        debugPrint(url);
        api.Response response = await api.ApiService().postRequest(
          addCartUrl,
          addItemToCartRequestToJson(addItemToCartRequest),
        );
        if (response.statusCode == 200) {
          var addItemToCartResponse = addItemToCartResponseFromJson(
            response.resBody,
          );

          return;
        } else {
          emit(OtpErrorState(errorMessage: response.resBody));
        }
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    tickerSubscription.cancel();
    return super.close();
  }
}
