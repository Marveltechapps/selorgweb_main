import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:selorgweb_main/utils/constant.dart';

class GeneralInfoMobileScreen extends StatelessWidget {
  const GeneralInfoMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: whitecolor, size: 16),
        ),
        elevation: 0,
        title: Text("General Policies"),
      ),
      body: Column(
        spacing: 15,
        children: [
          ListTile(
            tileColor: whitecolor,
            leading: SvgPicture.asset(termssvg),
            title: Text(
              "Terms & Conditions",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: greyColor),
            onTap: () {
              context.push('terms&conditions');
            },
          ),
          ListTile(
            tileColor: whitecolor,
            leading: SvgPicture.asset(privacysvg),
            title: Text(
              "Privacy Policy",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: greyColor),
            onTap: () {
              context.push('/privacypolicy');
            },
          ),
        ],
      ),
    );
  }
}
