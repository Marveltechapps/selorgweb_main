import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/utils/constant.dart';

class DeliveryTipWidget extends StatefulWidget {
  final Function(int)? onTipSelected;
  final Function()? onCancel;

  const DeliveryTipWidget({super.key, this.onTipSelected, this.onCancel});

  @override
  DeliveryTipWidgetState createState() => DeliveryTipWidgetState();
}

class DeliveryTipWidgetState extends State<DeliveryTipWidget> {
  int selectedTip = 50;

  Widget _buildTipButton(int amount, String imageUrl) {
    final bool isSelected = selectedTip == amount;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTip = amount;
        });
        widget.onTipSelected?.call(amount);
      },
      child: Container(
        width: 83,
        height: 41,
        decoration:
            isSelected
                ? DeliveryTipStyles.selectedTipDecoration
                : DeliveryTipStyles.tipButtonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isSelected) ...[
              Image.network(
                imageUrl,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 7),
            ],
            Text('₹$amount', style: DeliveryTipStyles.tipAmountStyle),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // constraints: BoxConstraints(maxWidth: 523),
      decoration: DeliveryTipStyles.cardDecoration,
      padding: EdgeInsets.fromLTRB(21, 19, 21, 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 451),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Partner Tip',
                        style: DeliveryTipStyles.titleStyle,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'We thank you for your generosity!',
                        style: DeliveryTipStyles.subtitleStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 55),
                Column(
                  children: [
                    Container(
                      width: 81,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: DeliveryTipStyles.tippedIndicatorDecoration,
                      child: Text(
                        'Rs.$selectedTip\nTipped',
                        style: DeliveryTipStyles.tippedTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 21),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTipButton(
                  10,
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/9e0b9dcb18ad0ca952db09dce74488e3258c7b38?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                ),
                SizedBox(width: 10),
                _buildTipButton(
                  20,
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/88f4fcda9e256dac734b77d4d17130120ec46859?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                ),
                SizedBox(width: 10),
                _buildTipButton(
                  30,
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/20267f2b60956aebb8a53c7c186f7f3ac23bdc64?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                ),
                SizedBox(width: 10),
                _buildTipButton(
                  50,
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/20267f2b60956aebb8a53c7c186f7f3ac23bdc64?placeholderIfAbsent=true&apiKey=06096b941d4746ae854b71463e363371',
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTip = 0;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Cancel', style: DeliveryTipStyles.cancelStyle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryTipStyles {
  static const Color primaryGreen = Color(0xFF24BB0C);
  static Color darkGreen = appColor;
  static const Color lightGreen = Color(0xFFE0FADC);
  static const Color textDark = Color(0xFF222222);
  static const Color textGrey = Color(0xFF444444);
  static const Color borderGrey = Color(0xFFCCCCCC);
  static const Color errorRed = Color(0xFFE21414);

  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(color: Color(0x40666666), blurRadius: 2, offset: Offset(0, 1)),
    ],
  );

  static BoxDecoration tipButtonDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: borderGrey, width: 1),
  );

  static BoxDecoration selectedTipDecoration = BoxDecoration(
    color: lightGreen,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: darkGreen, width: 1),
  );

  static BoxDecoration tippedIndicatorDecoration = BoxDecoration(
    color: lightGreen,
    borderRadius: BorderRadius.circular(7),
  );

  static TextStyle titleStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textDark,
    height: 1,
  );

  static TextStyle subtitleStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryGreen,
    height: 1.3,
  );

  static TextStyle tipAmountStyle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textGrey,
  );

  static TextStyle cancelStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: errorRed,
  );

  static TextStyle tippedTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textGrey,
    height: 1.2,
  );
}
