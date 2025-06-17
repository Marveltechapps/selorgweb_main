import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/utils/constant.dart';

class BillSummaryWidget extends StatelessWidget {
  const BillSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x40666666),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Bill Summary',
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF222222),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Saved ₹88',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFFE7F9E7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          _buildBillItem(
            title: 'Item Total & GST',
            originalPrice: '₹96',
            price: '₹87',
            showInfo: true,
          ),
          _buildBillItem(
            title: 'Handling charge',
            originalPrice: '₹15',
            price: '₹05',
          ),
          _buildBillItem(
            title: 'Delivery Fee',
            originalPrice: '₹35',
            price: 'Free',
          ),
          _buildBillItem(title: 'Delivery Tip', price: '₹20'),
          Container(
            height: 1,
            color: const Color(0xFFD9D4D4),
            margin: const EdgeInsets.symmetric(vertical: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Bill',
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF444444),
                ),
              ),
              Text(
                '₹192',
                style: GoogleFonts.inter(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF444444),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillItem({
    required String title,
    required String price,
    String? originalPrice,
    bool showInfo = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: showInfo ? 17 : 16,
                  fontWeight: showInfo ? FontWeight.w500 : FontWeight.w400,
                  color:
                      showInfo
                          ? const Color(0xFF222222)
                          : const Color(0xFF666666),
                ),
              ),
              if (showInfo)
                Container(
                  width: 11,
                  height: 11,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: const BoxDecoration(
                    color: Color(0xFFA9D046),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'i',
                      style: TextStyle(fontSize: 7, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              if (originalPrice != null) ...[
                Text(
                  originalPrice,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF777777),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 7),
              ],
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
