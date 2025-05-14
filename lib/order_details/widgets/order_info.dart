import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Details',
            style: GoogleFonts.poppins(
              color: const Color(0xFF222222),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 26),
          _buildInfoItem('Order ID', '#C142345678912MC3'),
          const SizedBox(height: 26),
          _buildInfoItem(
            'Delivery at',
            'E101, 1st Floor, AB Avenue, Indira Nagar, Adyar, Chennai, Tamil Nadu',
          ),
          const SizedBox(height: 26),
          _buildInfoItem('Order Placed', '21 May 2024, 12:04 Pm'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: const Color(0xFF444444),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: const Color(0xFF666666),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
