import 'package:flutter/material.dart';
import 'package:selorgweb_main/widgets/app_store_button_widget.dart';

class BottomImageWidget extends StatelessWidget {
  const BottomImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width < 991;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return isTablet
        ? SizedBox()
        : Stack(
          children: [
            // Background Image
            Image.asset(
              'download_banner.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              width: double.infinity,
              height: 450,
            ),
            // Content
            Positioned(
              left: 180,
              top: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 10),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1280),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Download the Selorg app',
                            style: TextStyle(
                              color: const Color(0xFF034703),
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 17),
                          Text(
                            'Download Selorg app available on Android & iOS',
                            style: TextStyle(
                              color: const Color(0xFF555555),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 21),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              AppStoreButton(
                                icon:
                                    'https://cdn.builder.io/api/v1/image/assets/TEMP/e63616af6b1623990b6e73b5785ab42480319283?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                topText: 'Get it On',
                                bottomText: 'Google Play',
                                iconSize: const Size(47, 47),
                              ),
                              AppStoreButton(
                                icon:
                                    'https://cdn.builder.io/api/v1/image/assets/TEMP/bc7388ec939068717da235abdfc46ffc125d7ead?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                                topText: 'Download on the',
                                bottomText: 'App Store',
                                iconSize: const Size(44, 50),
                                topTextStyle: const TextStyle(fontSize: 19),
                                bottomTextStyle: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  }
}
