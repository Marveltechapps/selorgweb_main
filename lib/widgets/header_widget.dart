import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/order/screens/my_account_orders.dart';
import 'package:selorgweb_main/presentation/cart/cart_screen.dart';
import 'package:selorgweb_main/presentation/home/home_screen.dart';
import 'package:selorgweb_main/presentation/settings/setting_screen.dart';
import 'package:selorgweb_main/utils/constant.dart';

class HeaderWidget extends StatelessWidget {
  final Function()? onClick;
  const HeaderWidget({super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 991) {
          // mobile view and tablet view
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth < 991 ? 20 : 52,
              vertical: 7,
            ),
            color: const Color(0xFF052E16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: SvgPicture.asset(appTextImage, height: 15),
                    ),
                    Container(
                      width: 2,
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: onClick,
                      child: Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth < 500 ? 130 : null,
                            child: Text(
                              location,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            // size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width:
                      constraints.maxWidth < 991
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 3,
                  height: 40,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Color(0xFF666666), size: 20),
                      const SizedBox(width: 14),
                      Text(
                        'Search For Products...',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SettingScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'My Account',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 28),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CartScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'My Cart',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF052E16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // desktop view
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 7),
            color: const Color(0xFF052E16),
            height: 112,
            child: FittedBox(
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: SvgPicture.asset(appTextImage, height: 20),
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                      ),
                      InkWell(
                        onTap: onClick,
                        child: Row(
                          children: [
                            Text(
                              location,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Color(0xFF666666), size: 20),
                        const SizedBox(width: 14),
                        Text(
                          'Search For Products...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SettingScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'My Account',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 28),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CartScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 127,
                          height: 37,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'My Cart',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF052E16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
