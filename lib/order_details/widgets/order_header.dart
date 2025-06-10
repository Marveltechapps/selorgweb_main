import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF034703),
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 70),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 185,
                    child: Row(
                      children: [
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/31d4d778479f952ae221f593c1d7e3928c27fd63?placeholderIfAbsent=true', width: 69),
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/c3cae70f28f3f84dc6a299bd39eabd685806a84c?placeholderIfAbsent=true', width: 27),
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/0e8e6b510c3c64945c665bb0aae3521cd04f9b09?placeholderIfAbsent=true', width: 23),
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/16a0d223f778c0286b1ca0ebffbf4c2b166a58b8?placeholderIfAbsent=true', width: 24),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 19),
                    color: const Color(0x80DEE3CF),
                  ),
                  Text(
                    'Lattice Bridge',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (constraints.maxWidth > 991) ...[
                Container(
                  width: 524,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    children: [
                      Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/5f7c7f866dbfb3ee292dbd5cbbfb31ff1026a32c?placeholderIfAbsent=true', width: 17),
                      const SizedBox(width: 13),
                      Text(
                        'Search For Products...',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF666666),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'My Account',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 29),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color(0x40666666),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            'My Cart',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF034703),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 11),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Color(0xFF034703),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '6',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}