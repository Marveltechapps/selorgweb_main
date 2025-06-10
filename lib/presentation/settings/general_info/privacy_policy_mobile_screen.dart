import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:selorgweb_main/model/settings/privacy_policy_response_model.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_bloc.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_event.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_state.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyMobileScreen extends StatelessWidget {
  const PrivacyPolicyMobileScreen({super.key});

  static PrivacyPolicyResponse privacyPolicyResponse = PrivacyPolicyResponse();
  static WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GeneralInfoBloc(),
        child: BlocConsumer<GeneralInfoBloc, GeneralInfoState>(
            listener: (context, state) {
          if (state is PrivacyPolicySuccessState) {
            privacyPolicyResponse = state.privacyPolicyResponse;
            controller = WebViewController()
              ..loadHtmlString(privacyPolicyResponse.content ?? "");
          }
        }, builder: (context, state) {
          if (state is GeneralInfoInitialState) {
            // privacyPolicyResponse = PrivacyPolicyResponse();
            context.read<GeneralInfoBloc>().add((GetPrivacyPolicyEvent()));
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is GeneralInfoLoadingState,
            appIcon: Image.asset(
              loadGif,
              fit: BoxFit.fill,
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: appColor,
                leading: IconButton(
                    onPressed: () {
                    context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: whitecolor,
                      size: 16,
                    )),
                elevation: 0,
                title: Text("Privacy Policy"),
              ),
              body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: WebViewWidget(controller: controller)),
            ),
          );
        }));
  }
}
