import 'package:flutter/material.dart';

class AppStoreButton extends StatelessWidget {
  final String icon;
  final String topText;
  final String bottomText;
  final Size iconSize;
  final TextStyle? topTextStyle;
  final TextStyle? bottomTextStyle;

  const AppStoreButton({
    super.key,
    required this.icon,
    required this.topText,
    required this.bottomText,
    required this.iconSize,
    this.topTextStyle,
    this.bottomTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF444444),
        borderRadius: BorderRadius.circular(9.159),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            icon,
            width: iconSize.width - 10,
            height: iconSize.height - 10,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topText,
                style:
                    topTextStyle?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1,
                      fontSize: 15,
                    ) ??
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
              ),
              Text(
                bottomText,
                style:
                    bottomTextStyle?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1,
                      fontSize: 17,
                    ) ??
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
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
