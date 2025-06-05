import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selorgweb_main/model/settings/privacy_policy_response_model.dart';
import 'package:selorgweb_main/model/settings/terms_and_condition_response_model.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_event.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_state.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:http/http.dart' as http;

class GeneralInfoBloc extends Bloc<GeneralInfoEvent, GeneralInfoState> {
  GeneralInfoBloc() : super(GeneralInfoInitialState()) {
    on<GetTermsAndConditionEvent>(getTermsAndCondition);
    on<GetPrivacyPolicyEvent>(getPrivacyPolicy);
  }

  getTermsAndCondition(
      GetTermsAndConditionEvent event, Emitter<GeneralInfoState> emit) async {
    emit(GeneralInfoLoadingState());
    try {
      String url = termsAndConditionUrl;
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var gerTermsAndConditionResponse =
            termsAndConditionResponseFromJson(response.body);
        emit(TermsAndConditionSuccessState(
            termsAndConditionResponse: gerTermsAndConditionResponse));
      } else {
        emit(GeneralInfoErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(GeneralInfoErrorState(errorMsg: e.toString()));
    }
  }

  getPrivacyPolicy(
      GetPrivacyPolicyEvent event, Emitter<GeneralInfoState> emit) async {
    emit(GeneralInfoLoadingState());
    try {
      String url = privacyPolicyUrl;
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var privacyPolicyResponse =
            privacyPolicyResponseFromJson(response.body);
        emit(PrivacyPolicySuccessState(
            privacyPolicyResponse: privacyPolicyResponse));
      } else {
        emit(GeneralInfoErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(GeneralInfoErrorState(errorMsg: e.toString()));
    }
  }
}
