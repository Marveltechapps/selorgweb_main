import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/order_details/widgets/bill_summary.dart';
import 'package:selorgweb_main/order_details/widgets/order_info.dart';
import 'package:selorgweb_main/order_details/widgets/order_items.dart';

class Orderdetails extends StatefulWidget {
  const Orderdetails({super.key});

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.network(
              'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/5dd15b4849236915d8437d3bd8834c5bbb94596f?placeholderIfAbsent=true',
              width: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Order Delivered',
              style: GoogleFonts.poppins(
                color: const Color(0xFF444444),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  'Arrived in',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF222222),
                    fontSize: 12,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCDE19A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Image.network(
                      //   'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/0190ebbe4dd7d673fe2ba14fb80b0cc67fb5adc3?placeholderIfAbsent=true',
                      //   width: 13,
                      // ),
                      const SizedBox(width: 4),
                      Text(
                        '6 MINS',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF496308),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 10),
        OrderItems(),
        SizedBox(height: 10),
        BillSummary(),
        SizedBox(height: 10),
        OrderInfo(),
      ],
    );
  }
}
