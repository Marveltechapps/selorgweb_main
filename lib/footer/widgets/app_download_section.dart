import 'package:flutter/material.dart';
import '../constants/text_styles.dart';
import 'store_button.dart';

class AppDownloadSection extends StatelessWidget {
  const AppDownloadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 991;

    return Container(
      height: 528,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 70 : 20,
        vertical: 2,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/39b197c3a429c1029594858a847ed515aae2beaf?placeholderIfAbsent=true',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(maxWidth: 1349),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isDesktop)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Download the Selorg app',
                            style: AppTextStyles.heading1,
                          ),
                          const SizedBox(height: 17),
                          Text(
                            'Download Selorg app available on Android & iOS',
                            style: AppTextStyles.subheading,
                          ),
                          const SizedBox(height: 21),
                          Row(
                            children: [
                              StoreButton(
                                iconUrl:
                                    'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/91f1d2ecbfed859875d9ee1352a58bdd784a90b0?placeholderIfAbsent=true',
                                topText: 'Get it On',
                                bottomText: 'Google Play',
                              ),
                              const SizedBox(width: 20),
                              StoreButton(
                                iconUrl:
                                    'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/c5758b92cb3afde06f6043a255521e6218ed1012?placeholderIfAbsent=true',
                                topText: 'Download on the',
                                bottomText: 'App Store',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (isDesktop)
                    Expanded(
                      child: Image.network(
                        'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/f91cd906195f2b6052bdc4debe35168b4ab0e78c?placeholderIfAbsent=true',
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
