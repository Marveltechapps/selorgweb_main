import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selorgweb_main/utils/constant.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: appColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 150,
          vertical: 50,
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 1280),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(),
          child: Row(
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
                    children: [SvgPicture.asset(appLogo)],
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
                      Text("Home", style: TextStyle(color: whiteColor)),
                      Text("Career", style: TextStyle(color: whiteColor)),
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
                      Text(
                        "Privacy Policy",
                        style: TextStyle(color: whiteColor),
                      ),
                      Text(
                        "Terms & Conditions",
                        style: TextStyle(color: whiteColor),
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
                      Text("Download App", style: TextStyle(color: whiteColor)),
                      SvgPicture.asset(playStore),
                      SvgPicture.asset(appStore),
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
