import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selorgweb_main/apiservice/secure_storage/secure_storage.dart';
import 'package:selorgweb_main/order/provider/navigationprovider.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';

class AccountSidebarWidget extends StatelessWidget {
  const AccountSidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      decoration: BoxDecoration(
        color: backgroundAppColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(39, 56, 28, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Account',
            style: GoogleFonts.poppins(
              color: primarytextColor,
              fontSize: 25,

              fontWeight: FontWeight.w500,
            ),
          ),
          // Text(
          //   '+91 944444999',
          //   style: GoogleFonts.poppins(
          //     color: const Color.fromRGBO(255, 255, 255, 0.8),
          //     fontSize: 21,

          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          Divider(color: primarytextColor),
          const SizedBox(height: 29),
          _buildMenuItem(
            'Orders',
            'icons/solar_bag-5-outline.svg',
            0,
            context,
            isSelected: true,
          ),
          _buildMenuItem(
            'Customer Support & FAQ',
            'icons/iconamoon_comment-light.svg',
            1,
            context,
          ),
          _buildMenuItem(
            'Addresses',
            'icons/mingcute_location-line.svg',
            2,
            context,
          ),
          _buildMenuItem(
            'Profile',
            'icons/iconamoon_profile-circle.svg',
            3,
            context,
          ),
          const SizedBox(height: 27),
          Center(
            child: InkWell(
              onTap: () async {
                await TokenService.deleteToken();
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('phone', '');
                await prefs.setString('userid', '');
                await prefs.setBool('isLoggedIn', false);
                isLoggedInvalue = false;
                phoneNumber = '';
                userId = '';
                context.push('/');
              },
              child: Container(
                width: 133,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(37),
                  border: Border.all(color: AppColors.red),
                ),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.poppins(
                      color: AppColors.red,
                      fontSize: 16,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    String iconUrl,
    int sectionId,
    BuildContext context, {
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: () {
        context.read<Navigationprovider>().updatesectionId(sectionId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          // color: isSelected ? secondAppColor : null,
          color: null,
          border: Border(bottom: BorderSide(color: primarytextColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(
                    iconUrl,
                    width: 27,
                    height: 27,
                    colorFilter: ColorFilter.mode(
                      primarytextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: primarytextColor,
                        fontSize: 16,

                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 25, color: primarytextColor),
          ],
        ),
      ),
    );
  }
}
