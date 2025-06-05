import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:selorgweb_main/utils/constant.dart';

class SettingsMobileScreen extends StatelessWidget {
  const SettingsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        leading: IconButton(
          onPressed: () {
            debugPrint("Back button pressed");
            context.goNamed('home');
          },
          icon: Icon(Icons.arrow_back_ios_new, color: whitecolor, size: 16),
        ),
        elevation: 0,
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: SvgPicture.asset(ordersvg),
                title: Text(
                  "Orders",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  context.go('/orders');
                },
              ),
              Divider(color: greyColor),
              ListTile(
                leading: SvgPicture.asset(customersvg),
                title: Text(
                  "Customer Support & FAQ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  context.go('/customersupport');
                },
              ),
              Divider(color: greyColor),
              ListTile(
                leading: SvgPicture.asset(addresssvg),
                title: Text(
                  "Addresses",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/address');
                },
              ),
              Divider(color: greyColor),
              ListTile(
                leading: SvgPicture.asset(refundssvg),
                title: Text(
                  "Refunds",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/refunds');
                },
              ),
              Divider(color: greyColor),
              ListTile(
                leading: SvgPicture.asset(profilessvg),
                title: Text(
                  "Profile",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              Divider(color: greyColor),
              // ListTile(
              //   leading: Image.asset(suggestIcon),
              //   title: Text("Suggest Products",
              //       style: Theme.of(context).textTheme.displayMedium),
              //   trailing:
              //       Icon(Icons.arrow_forward_ios_rounded, color: greyColor),
              //   onTap: () {
              //     //  Navigator.pushNamed(context, '/profile');
              //   },
              // ),
              // Divider(
              //   color: greyColor.shade400,
              // ),
              ListTile(
                leading: SvgPicture.asset(paymentsvg),
                title: Text(
                  "Payment management",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/paymentManagementScreen');
                },
              ),
              Divider(color: greyColor),
              ListTile(
                leading: SvgPicture.asset(generalInfosvg),
                title: Text(
                  "General Info",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  context.go('/generalinfo');
                },
              ),
              Divider(color: greyColor),
              ListTile(
                leading: SvgPicture.asset(notificationsvg),
                title: Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: greyColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
              Divider(color: greyColor),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  // showLogOutDialog(context);
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Color(0xFFCE1717), width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFCE1717),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
