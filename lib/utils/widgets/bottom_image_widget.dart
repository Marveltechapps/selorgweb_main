import 'package:flutter/material.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/utils/widgets/app_store_button_widget.dart';
import 'package:web/web.dart' as html;

class BottomImageWidget extends StatelessWidget {
  const BottomImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width < 991;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return isTablet
        ? SizedBox()
        : Stack(
          alignment: Alignment.center,
          children: [
            // Background Image
            Image.asset(
              bannerimage,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              width: double.infinity,
              height: 450,
            ),
            // Content
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 1280),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Download the Selorg app',
                              style: TextStyle(
                                color: appColor,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 17),
                            Text(
                              'Download Selorg app available on Android & iOS',
                              style: TextStyle(
                                color: const Color(0xFF555555),
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 21),
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                InkWell(
                                  onTap: () {
                                    html.window.open(
                                      'https://play.google.com/store/apps/details?id=com.selorg.app', // Replace with your app URL
                                      '_blank', // Opens in new tab
                                    );
                                  },
                                  child: AppStoreButton(
                                    icon:
                                        'https://cdn.builder.io/api/v1/image/assets/TEMP/e63616af6b1623990b6e73b5785ab42480319283?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                    topText: 'Get it On',
                                    bottomText: 'Google Play',
                                    iconSize: const Size(47, 47),
                                  ),
                                ),
                                AppStoreButton(
                                  icon:
                                      'https://cdn.builder.io/api/v1/image/assets/TEMP/bc7388ec939068717da235abdfc46ffc125d7ead?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                  topText: 'Get it on',
                                  bottomText: 'App Store',
                                  iconSize: const Size(47, 47),
                                  // topTextStyle: const TextStyle(fontSize: 19),
                                  // bottomTextStyle: const TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          bannerimage.replaceAll(r'.png', '1.png'),
                          height: 450,
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}
