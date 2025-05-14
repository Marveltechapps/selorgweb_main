import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/utils/constant.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'store_button.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 991;

    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 70 : 20,
        81,
        isDesktop ? 70 : 20,
        140,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1195),
          child: Wrap(
            spacing: 20,
            runSpacing: 40,
            alignment: WrapAlignment.spaceBetween,
            children: [
              _buildLogoSection(),
              _buildLinksColumn(['Home', 'Careers', 'Customer support']),
              _buildLinksColumn(['Privacy Policy', 'Terms of use', 'Delivery areas']),
              _buildDownloadSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return SizedBox(
      width: 184,
      child: SvgPicture.asset(
        applogoImage,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildLinksColumn(List<String> links) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              link,
              style: AppTextStyles.footerText,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDownloadSection() {
    return SizedBox(
      width: 224,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Download App',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              height: 2,
            ),
          ),
          const SizedBox(height: 16),
          StoreButton(
            iconUrl: 'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/0ddf1bbcc89a31d95bc1fd67ec0e7293c1363d95?placeholderIfAbsent=true',
            topText: 'Get it On',
            bottomText: 'Google Play',
            backgroundColor: AppColors.black,
          ),
          const SizedBox(height: 24),
          StoreButton(
            iconUrl: 'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/b278934202df85dfaee2b292991858a374d4a6f4?placeholderIfAbsent=true',
            topText: 'Download on the',
            bottomText: 'App Store',
            backgroundColor: AppColors.black,
          ),
        ],
      ),
    );
  }
}