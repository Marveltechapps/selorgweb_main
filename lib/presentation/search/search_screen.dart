import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/footer/screens/home_screen.dart';
import 'package:selorgweb_main/presentation/settings/setting_screen.dart';
import 'package:selorgweb_main/screens/cart_screen.dart';
import 'package:selorgweb_main/utils/constant.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(
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
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
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
                              onTap: () {},
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        constraints.maxWidth < 500 ? 130 : null,
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black54),
                          ),
                          //  width: size.width,
                          height: 50,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(backsvg),
                              ),
                              SizedBox(width: 8),
                              // Expanded(
                              //   child: TextFormField(
                              //     //   controller: searchController,
                              //     cursorColor: appColor,
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       height: 1.5,
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //     textInputAction: TextInputAction.search,
                              //     onFieldSubmitted: (value) {
                              //       // context.read<SearchBloc>().add(SearchApiEvent(
                              //       //       searchText: searchController.text,
                              //       //     ));
                              //     },
                              //     decoration: InputDecoration(
                              //       fillColor: Color(0xFFFFFFFF),
                              //       hintText: 'Search For ""',
                              //       hintStyle: TextStyle(color: Colors.black54),
                              //       border: InputBorder.none,
                              //     ),
                              //     onChanged: (value) {
                              //       // context.read<SearchBloc>().add(SearchApiEvent(
                              //       //       searchText: value,
                              //       //     ));
                              //     },
                              //   ),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  // context
                                  //     .read<SearchBloc>()
                                  //     .add(ClickCloseButtonEvent());
                                },
                                child: SvgPicture.asset(closesvg),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150,
                      vertical: 7,
                    ),
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
                                child: SvgPicture.asset(
                                  appTextImage,
                                  height: 20,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 40,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                color: Colors.white,
                              ),
                              InkWell(
                                onTap: () {},
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black54),
                            ),
                            //  width: size.width,
                            height: 50,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(backsvg),
                                ),
                                SizedBox(width: 8),
                                // Expanded(
                                //   child: TextFormField(
                                //     //   controller: searchController,
                                //     cursorColor: appColor,
                                //     style: TextStyle(
                                //       fontSize: 16,
                                //       height: 1.5,
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.w600,
                                //     ),
                                //     textInputAction: TextInputAction.search,
                                //     onFieldSubmitted: (value) {
                                //       // context.read<SearchBloc>().add(SearchApiEvent(
                                //       //       searchText: searchController.text,
                                //       //     ));
                                //     },
                                //     decoration: InputDecoration(
                                //       fillColor: Color(0xFFFFFFFF),
                                //       hintText: 'Search For ""',
                                //       hintStyle: TextStyle(
                                //         color: Colors.black54,
                                //       ),
                                //       border: InputBorder.none,
                                //     ),
                                //     onChanged: (value) {
                                //       // context.read<SearchBloc>().add(SearchApiEvent(
                                //       //       searchText: value,
                                //       //     ));
                                //     },
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    // context
                                    //     .read<SearchBloc>()
                                    //     .add(ClickCloseButtonEvent());
                                  },
                                  child: SvgPicture.asset(closesvg),
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
            ),
          ],
        ),
      ),
    );
  }
}
