import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selorgweb_main/order/provider/navigationprovider.dart';
import './constants/colors.dart';

class AccountSidebarWidget extends StatelessWidget {
  const AccountSidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      decoration: BoxDecoration(
        color: AppColors.primary,
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
              color: AppColors.white,
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
          const Divider(color: AppColors.white),
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
          color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
          border: Border(
            bottom: BorderSide(color: AppColors.white.withOpacity(0.2)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(iconUrl, width: 27, height: 27),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
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
            Icon(Icons.chevron_right, size: 25, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
