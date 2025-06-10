import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/utils/widgets/header_widget.dart';
import '../constants/colors.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              HeaderWidget(
                isHomeScreen: false,
              ),
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
                                      color: Colors.black,
                                      offset: Offset(0, 2.53),
                                      blurRadius: 9.61,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Arrived',
                                      style: GoogleFonts.poppins(
                                        // fontFamily: 'Poppins',
                                        fontSize: 25.07,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Text(
                                      'MINS',
                                      style: GoogleFonts.poppins(
                                        // fontFamily: 'Poppins',
                                        fontSize: 25.07,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                      ),
                                    ),
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
                              color: AppColors.primary,
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
}
