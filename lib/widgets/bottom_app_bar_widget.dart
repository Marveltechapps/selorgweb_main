import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selorgweb_main/footer/screens/home_screen.dart';
import 'package:selorgweb_main/presentation/general/privacy_policy.dart';
import 'package:selorgweb_main/presentation/general/terms_conditions.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/widgets/app_store_button_widget.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 991;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: appColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 60,
          vertical: 50,
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 1280),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(),
          child:
              isTablet
                  ? Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 20,
                    runSpacing: 50,
                    children: [
                      SizedBox(
                        // height: 200,
                        width: 200,
                        child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(appLogo),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // height: 200,
                        width: 200,
                        child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Home",
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                            Text("Career", style: TextStyle(color: whiteColor)),
                            Text(
                              "Customer Support",
                              style: TextStyle(color: whiteColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // height: 200,
                        width: 200,
                        child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PrivacyPolicy(),
                                  ),
                                );
                              },
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TermsConditions(),
                                  ),
                                );
                              },
                              child: Text(
                                "Terms & Conditions",
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                            Text(
                              "Delivery Areas",
                              style: TextStyle(color: whiteColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // height: 200,
                        width: 200,
                        child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Download App",
                              style: TextStyle(color: whiteColor),
                            ),
                            Column(
                              spacing: 20,
                              // runSpacing: 20,
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
                                  topText: 'Get it On',
                                  bottomText: 'App Store',
                                  iconSize: const Size(47, 47),
                                  // topTextStyle: const TextStyle(fontSize: 19),
                                  // bottomTextStyle: const TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(appLogo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Home",
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                              Text(
                                "Career",
                                style: TextStyle(color: whiteColor),
                              ),
                              Text(
                                "Customer Support",
                                style: TextStyle(color: whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PrivacyPolicy(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TermsConditions(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Terms & Conditions",
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                              Text(
                                "Delivery Areas",
                                style: TextStyle(color: whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Download App",
                                style: TextStyle(color: whiteColor),
                              ),
                              Column(
                                spacing: 20,
                                // runSpacing: 20,
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
                                    topText: 'Get it On',
                                    bottomText: 'App Store',
                                    iconSize: const Size(47, 47),
                                    // topTextStyle: const TextStyle(fontSize: 19),
                                    // bottomTextStyle: const TextStyle(fontSize: 22),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
