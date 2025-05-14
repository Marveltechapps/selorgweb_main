import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/order_details/screens/order_delivered_details.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

class OrderCardWidget extends StatelessWidget {
  final List<String> productImages;
  final String date;
  final double amount;

  const OrderCardWidget({
    Key? key,
    required this.productImages,
    required this.date,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 550;
    return Container(
      decoration: AppStyles.cardDecoration,
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
                  productImages.map((url) => _buildProductImage(url)).toList(),
            ),
          ),
          const SizedBox(height: 15),
          isMobile
              ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Order Delivered',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF444444),
                              fontSize: isMobile ? 18 : 21,

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.network(
                            'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/080c4ac15c2e085323af52959e560eb759d2fe5b?placeholderIfAbsent=true',
                            width: isMobile ? 20 : 28,
                            height: isMobile ? 20 : 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: AppColors.grey,
                          fontSize: isMobile ? 16 : 18,

                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Image.network(
                      //   'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/243adecf69d79ddad851dce8cfee5bb65fcb6908?placeholderIfAbsent=true',
                      //   width: 28,
                      //   height: 28,
                      // ),
                      Row(
                        children: [
                          Text(
                            '₹' + amount.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 23,

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                            size: 30,
                          ),
                        ],
                      ),
                      // Image.network(
                      //   'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/16ccaddff3253b0cbb5e22f209a01d3346840248?placeholderIfAbsent=true',
                      //   width: 26,
                      //   height: 26,
                      // ),
                    ],
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Order Delivered',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF444444),
                              fontSize: isMobile ? 18 : 21,

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.network(
                            'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/080c4ac15c2e085323af52959e560eb759d2fe5b?placeholderIfAbsent=true',
                            width: isMobile ? 20 : 28,
                            height: isMobile ? 20 : 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: AppColors.grey,
                          fontSize: isMobile ? 16 : 18,

                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Image.network(
                      //   'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/243adecf69d79ddad851dce8cfee5bb65fcb6908?placeholderIfAbsent=true',
                      //   width: 28,
                      //   height: 28,
                      // ),
                      Row(
                        children: [
                          Text(
                            '₹' + amount.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 23,

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                            size: 30,
                          ),
                        ],
                      ),
                      // Image.network(
                      //   'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/16ccaddff3253b0cbb5e22f209a01d3346840248?placeholderIfAbsent=true',
                      //   width: 26,
                      //   height: 26,
                      // ),
                    ],
                  ),
                ],
              ),
          const Divider(color: Color(0xFFBDBDBD)),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return OrderDeliveredDetails();
              //     },
              //   ),
              // );
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Order Again',
                    style: GoogleFonts.poppins(
                      color: Color(0xFFE54444),
                      fontSize: 20,

                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(String url) {
    return Container(
      width: 91,
      height: 96,
      margin: const EdgeInsets.only(right: 21),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.all(10),
      child: Image.network(url, fit: BoxFit.contain),
    );
  }
}
