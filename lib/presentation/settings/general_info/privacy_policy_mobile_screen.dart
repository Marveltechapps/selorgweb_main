import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:selorgweb_main/model/settings/privacy_policy_response_model.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_bloc.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_event.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_state.dart';
import 'package:selorgweb_main/presentation/settings/general_info/utils/mobile_html_viewer.dart';
import 'package:selorgweb_main/utils/constant.dart';

class PrivacyPolicyMobileScreen extends StatelessWidget {
  const PrivacyPolicyMobileScreen({super.key});

  static PrivacyPolicyResponse privacyPolicyResponse = PrivacyPolicyResponse();

  @override
  Widget build(BuildContext context) {
    final staticAnchorKey = GlobalKey();
    return BlocProvider(
      create: (context) => GeneralInfoBloc(),
      child: BlocConsumer<GeneralInfoBloc, GeneralInfoState>(
        listener: (context, state) {
          if (state is PrivacyPolicySuccessState) {
            privacyPolicyResponse = state.privacyPolicyResponse;
            privacyPolicyResponse.content = privacyPolicyResponse.content!
                .replaceAll(r'\n', '');
          }
        },
        builder: (context, state) {
          if (state is GeneralInfoInitialState) {
            // privacyPolicyResponse = PrivacyPolicyResponse();
            context.read<GeneralInfoBloc>().add((GetPrivacyPolicyEvent()));
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is GeneralInfoLoadingState,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
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
                  ),
                ),
                elevation: 0,
                title: Text("Privacy Policy"),
              ),
              body: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 1280),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child:
                          kIsWeb
                              ? (privacyPolicyResponse.content != null
                                  ? Html(
                                    shrinkWrap: true,
                                    key: staticAnchorKey,
                                    data:
                                        privacyPolicyResponse.content ??
                                        "<html><head></head><body><p>Privacy Policy Not loaded Properly</p></html>",
                                    style: {
                                      'p': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'h1': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'h2': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'h3': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'h4': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'h5': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'h6': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'span': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'ul': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                      'li': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: blackColor,
                                      ),
                                    },
                                  )
                                  : Text('loading...'))
                              : MobileHtmlView(
                                assetPath:
                                    privacyPolicyResponse.content ??
                                    "<html><head></head><body><p>Privacy Policy Not loaded Properly</p></html>",
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
