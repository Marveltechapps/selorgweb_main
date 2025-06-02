import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/presentation/search/search_screen.dart';
import 'package:selorgweb_main/widgets/header_widget.dart';
import '../constants/colors.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final isArrived = true;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              HeaderWidget(),
              Container(
                constraints: BoxConstraints(maxWidth: 556),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 258,
                          height: 295,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30.0,
                                  left: 5,
                                ),
                                child: SvgPicture.asset('icons/timer.svg'),
                              ),
                              Container(
                                width: 128.94,
                                height: 128.94,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: AppColors.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: Offset(0, 2.53),
                                      blurRadius: 9.61,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    !isArrived
                                        ? Text(
                                          '10',
                                          style: GoogleFonts.poppins(
                                            // fontFamily: 'Poppins',
                                            fontSize: 40.03,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        )
                                        : Text(
                                          'Arrived',
                                          style: GoogleFonts.poppins(
                                            // fontFamily: 'Poppins',
                                            fontSize: 25.07,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.white,
                                          ),
                                        ),
                                    !isArrived
                                        ? Text(
                                          'MINS',
                                          style: GoogleFonts.poppins(
                                            // fontFamily: 'Poppins',
                                            fontSize: 25.07,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.white,
                                          ),
                                        )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Your order is getting Packed',
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            // fontFamily: 'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 22 / 34,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.645),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.133),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0),
                              width: 0.713,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60.76,
                                height: 60.76,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                  child: SvgPicture.string(
                                    '''<svg width="40" height="40" viewBox="0 0 40 40" fill="none">
                <rect width="40" height="40" fill="white"/>
                <!-- Add the QR code SVG paths here -->
              </svg>''',
                                    width: 39.95,
                                    height: 39.95,
                                  ),
                                ),
                              ),
                              SizedBox(width: 14.27),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '2 Items',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.black,
                                        // fontFamily: 'Poppins',
                                        fontSize: 21,
                                        fontWeight: FontWeight.w500,
                                        height: 31 / 23,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Delivering to home: 1 floor, 14/78, 3rd East...',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.black,
                                        // fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        height: 31 / 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 223,
                          height: 40.83,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'View Details',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    // fontFamily: 'Poppins',
                                    fontSize: 22.83,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.white,
                                  size: 22.83,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF034703),
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 185,
                child: Row(
                  children: [
                    Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/31d4d778479f952ae221f593c1d7e3928c27fd63?placeholderIfAbsent=true',
                      width: 69,
                    ),
                    Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/a98c1b6843a1698817b4c568832647026eb3943d?placeholderIfAbsent=true',
                      width: 27,
                    ),
                    Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/b22d0ed08c69bcdabcd8e1453ead8cac4dfa60eb?placeholderIfAbsent=true',
                      width: 23,
                    ),
                    Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/1a94e5694a04b931f73c0b539960528b9722ebf7?placeholderIfAbsent=true',
                      width: 24,
                    ),
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
                Image.network(
                  'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/5f7c7f866dbfb3ee292dbd5cbbfb31ff1026a32c?placeholderIfAbsent=true',
                  width: 17,
                ),
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
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                    ),
                  ],
                  border: Border.all(color: const Color(0x40666666)),
                ),
                child: Text(
                  'My Cart',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF034703),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
