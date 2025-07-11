import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:selorgweb_main/model/settings/terms_and_condition_response_model.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_bloc.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_event.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_state.dart';
import 'package:selorgweb_main/presentation/settings/general_info/utils/mobile_html_viewer.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionsMobileScreen extends StatelessWidget {
  const TermsConditionsMobileScreen({super.key});

  static List<TermsAndConditionResponse> termsAndConditionResponse = [];
  static WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    final staticAnchorKey = GlobalKey();
    return BlocProvider(
      create: (context) => GeneralInfoBloc(),
      child: BlocConsumer<GeneralInfoBloc, GeneralInfoState>(
        listener: (context, state) {
          if (state is TermsAndConditionSuccessState) {
            termsAndConditionResponse = state.termsAndConditionResponse;
            termsAndConditionResponse[0].content = termsAndConditionResponse[0]
                .content!
                .replaceAll(r'\n', '');
          }
        },
        builder: (context, state) {
          if (state is GeneralInfoInitialState) {
            //  termsAndConditionResponse = TermsAndConditionResponse();
            context.read<GeneralInfoBloc>().add((GetTermsAndConditionEvent()));
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
                title: Text("Terms & Conditions"),
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
                              ? (termsAndConditionResponse.isNotEmpty
                                  ? Html(
                                    shrinkWrap: true,
                                    key: staticAnchorKey,
                                    data:
                                        termsAndConditionResponse[0].content ??
                                        "<html><head></head><body><p>Terms & Conditions Not loaded Properly</p></html>",
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
                                    termsAndConditionResponse[0].content ??
                                    "<html><head></head><body><p>Terms & Conditions Not loaded Properly</p></html>",
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
