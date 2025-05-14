import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 550;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 15 : 19),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
                
                
              ],
            ),
            const SizedBox(height: 19),
            Text(
              '3 Items in Order',
              style: GoogleFonts.poppins(
                color: const Color(0xFF222222),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 19),
            _buildOrderItem(
              'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/005d2b5686daa41572fa4af8d6e799e579b87140?placeholderIfAbsent=true',
              'Ghee',
              '1/2 L',
              '1 Unit',
              '₹120',
              '₹145',
              context,
            ),
            const SizedBox(height: 19),
            _buildOrderItem(
              'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/e306874934321a11f90aeab628f86fa1452da62d?placeholderIfAbsent=true',
              'Bread',
              '350g',
              '1 Unit',
              '₹120',
              '₹145',
              context,
            ),
            const SizedBox(height: 19),
            _buildOrderItem(
              'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/23544cd7e2f90b73d73078cecc90cb304acc9d12?placeholderIfAbsent=true',
              'Whole Wheat atta',
              '500g',
              '1 Unit',
              '₹120',
              '₹145',
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(
    String imageUrl,
    String name,
    String weight,
    String quantity,
    String price,
    String originalPrice,
    BuildContext context,
  ) {
    final isMobile = MediaQuery.of(context).size.width < 550;
    return isMobile
        ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, width: 46, height: 46),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF444444),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  weight,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF666666),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  quantity,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF666666),
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF444444),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  originalPrice,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFED476B),
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        )
        : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, width: 46, height: 46),
            const SizedBox(width: 21),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF444444),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  weight,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF666666),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Text(
              quantity,
              style: GoogleFonts.poppins(
                color: const Color(0xFF666666),
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF444444),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  originalPrice,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFED476B),
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        );
  }
}
