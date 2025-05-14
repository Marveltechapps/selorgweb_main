import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class StoreButton extends StatelessWidget {
  final String iconUrl;
  final String topText;
  final String bottomText;
  final double iconSize;
  final Color backgroundColor;

  const StoreButton({
    super.key,
    required this.iconUrl,
    required this.topText,
    required this.bottomText,
    this.iconSize = 47,
    this.backgroundColor = AppColors.buttonBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 7,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            iconUrl,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topText,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                  height: 1.6,
                ),
              ),
              Text(
                bottomText,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}