import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillSummary extends StatelessWidget {
  const BillSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 550;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4),
        ],
      ),
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? Wrap(
                // spacing: 10,
                alignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Bill Summary',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF222222),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF034703),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Saved ₹88',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFE7F9E7),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 29,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF034703)),
                      borderRadius: BorderRadius.circular(20.359),
                    ),
                    child: Text(
                      'Download Invoice',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF034703),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
              : Row(
                // spacing: 10,
                // alignment: WrapAlignment.spaceBetween,
                // direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Bill Summary',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF222222),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF034703),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Saved ₹88',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFE7F9E7),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 29,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF034703)),
                      borderRadius: BorderRadius.circular(20.359),
                    ),
                    child: Text(
                      'Download Invoice',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF034703),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
          const SizedBox(height: 17),
          _buildBillItem('Item Total & GST', '₹96', '₹87', showInfo: true),
          _buildBillItem('Handling charge', '₹15', '₹05'),
          _buildBillItem('Delivery Fee', '₹35', 'Free'),
          _buildBillItem('Delivery Tip', '', '₹20'),
          const Divider(color: Color(0xFFD9D4D4), thickness: 1, height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Bill',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444444),
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '₹192',
                style: GoogleFonts.inter(
                  color: const Color(0xFF444444),
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillItem(
    String title,
    String originalPrice,
    String price, {
    bool showInfo = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF222222),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (showInfo) ...[
                const SizedBox(width: 2),
                Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA9D046),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'i',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          Row(
            children: [
              if (originalPrice.isNotEmpty) ...[
                Text(
                  originalPrice,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF777777),
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 7),
              ],
              Text(
                price,
                style: GoogleFonts.inter(
                  color: const Color(0xFF444444),
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
