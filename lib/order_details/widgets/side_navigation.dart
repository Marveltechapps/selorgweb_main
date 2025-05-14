import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF034703),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4),
        ],
      ),
      padding: const EdgeInsets.all(39),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Account',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '+91 944444999',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(color: Colors.white),
          const SizedBox(height: 29),
          _buildNavItem(
            'Orders',
            'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/a1207c356a1e6d231434afe72717a06d3e7923f6?placeholderIfAbsent=true',
            true,
          ),
          _buildNavItem(
            'Customer Support & FAQ',
            'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/4d0e58e2b40b3bf6bd2ea8ef20a6e89047882623?placeholderIfAbsent=true',
            false,
          ),
          _buildNavItem(
            'Addresses',
            'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/e027655d680aec9a378e72032ba6cd15c84b503b?placeholderIfAbsent=true',
            false,
          ),
          _buildNavItem(
            'Profile',
            'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/a7ee372dc5fe3260d0f408901e367ae8d64b00bc?placeholderIfAbsent=true',
            false,
          ),
          const SizedBox(height: 27),
          Center(
            child: Container(
              width: 133,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(37),
                border: Border.all(color: const Color(0xFFCE1717)),
              ),
              child: Center(
                child: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFCE1717),
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

  Widget _buildNavItem(String title, String iconUrl, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0x1A034703) : null,
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          // Image.network(iconUrl, width: 27, height: 27),
          const SizedBox(width: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          // if (isSelected) ...[
          //   const Spacer(),
          //   Image.network(
          //     'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/7581d64ec8acfa0430e8247b1933965a473ab556?placeholderIfAbsent=true',
          //     width: 23,
          //     height: 23,
          //   ),
          // ],
        ],
      ),
    );
  }
}
