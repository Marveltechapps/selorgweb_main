import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
        children: [
          _buildCartItem(
            image:
                'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/504e40f705e47b5bc342223346b459397e4e7efa?placeholderIfAbsent=true',
            name: 'Orange(Organic)',
            weight: '500g',
            price: '₹37',
            originalPrice: '₹45',
            quantity: '1',
            isMobile: isMobile,
          ),
          const SizedBox(height: 24),
          _buildCartItem(
            image:
                'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/56b733b678ffce3598605ad3de10990a3b4cbf62?placeholderIfAbsent=true',
            name: 'Orange(Organic)',
            weight: '1 kg',
            price: '₹87',
            originalPrice: '₹95',
            quantity: '1',
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required String image,
    required String name,
    required String weight,
    required String price,
    required String originalPrice,
    required String quantity,
    required bool isMobile,
  }) {
    return ResponsiveRowColumn(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.network(image, width: isMobile ? 70 : 90),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 15 : 19,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF444444),
                  ),
                ),
                Text(
                  weight,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 10 : 13,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF666666),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 15 : 19,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF444444),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      originalPrice,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 10 : 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF777777),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          width: isMobile ? 200 : null,
          // constraints: BoxConstraints(minWidth: 400),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 20,
            vertical: 0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF326A32),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                icon: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: isMobile ? 20 : 24,
                ),
              ),

              const SizedBox(width: 5),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 15 : 20,
                  vertical: 0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Text(
                  quantity,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16 : 24,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF326A32),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: isMobile ? 20 : 24,
                ),
              ),
              //Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/32c07b56fcedf450d98dd12ef6d9a409a8d074af?placeholderIfAbsent=true', width: 23),
            ],
          ),
        ),
      ],
    );
  }
}

class ResponsiveRowColumn extends StatelessWidget {
  final List<Widget> children;
  ResponsiveRowColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return isMobile
        ? Column(children: children)
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        );
  }
}
