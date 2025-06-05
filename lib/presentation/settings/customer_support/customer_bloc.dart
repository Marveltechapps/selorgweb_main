import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/model/settings/faq_model.dart';
import 'package:selorgweb_main/presentation/settings/customer_support/customer_event.dart';
import 'package:selorgweb_main/presentation/settings/customer_support/customer_state.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:http/http.dart' as http;

class FaqsBloc extends Bloc<FaqsEvent, FaqsState> {
  FaqsBloc() : super(FaqsInitialState()) {
    on<GetFaqsEvent>(getFaqs);
  }

  getFaqs(GetFaqsEvent event, Emitter<FaqsState> emit) async {
    emit(FaqsLoadingState());
    try {
      String url = faqsUrl;
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var faqsResponse = faqsResponseFromJson(response.body);
        emit(FaqsSuccessState(faqsResponse: faqsResponse));
      } else {
        emit(FaqsErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(FaqsErrorState(errorMsg: e.toString()));
    }
  }
}
