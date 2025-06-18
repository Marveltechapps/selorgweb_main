import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/utils/widgets/cart_tool_tip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderWidget extends StatefulWidget {
  final bool isHomeScreen;
  final Function()? onClick;
  const HeaderWidget({super.key, this.onClick, required this.isHomeScreen});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool showCartTooltip = false;
  // OverlayEntry? entry;

  void _showCartPopup(BuildContext context) {
    final overlay = Overlay.of(context);
    // if (entry != null) {
    //   debugPrint(entry.toString());

    //   return;
    // }
    final entry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).size.width < 991 ? 140 : 80,
            right: 30,
            child: Material(
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                // padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // border: B,
                  borderRadius: BorderRadius.circular(8),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 6,
                  //     offset: Offset(0, 4),
                  //   ),
                  // ],
                ),
                child: CartToolTip(overlay: overlay),
              ),
            ),
          ),
    );

    overlay.insert(entry);
    try {
      Future.delayed(Duration(seconds: 3), () {
        // debugPrint('hi' + entry!.mounted.toString());
        // if (entry!.mounted == true) {}
        entry.remove();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBarCubit, String>(
      listener: (context, state) {},
      builder: (context, locationvalue) {
        context.read<AppBarCubit>().updateTitle(location);
        return BlocConsumer<CounterCubit, int>(
          listenWhen: (prev, curr) {
            // debugPrint(prev.toString() + curr.toString());

            return (curr != prev) && (prev != 0);
          },
          listener: (context, state) {
            // debugPrint("changes");
            final currentRoute =
                GoRouter.of(context).routerDelegate.state.fullPath;
            // debugPrint('cart page or not : ${currentRoute.toString()}');
            if (currentRoute.toString() == '/cart') {
            } else {
              setState(() {
                _showCartPopup(context);
                showCartTooltip = true;
              });
            }

            // Optional: hide after a delay
          },
          builder: (context, count) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 991) {
                  // mobile view and tablet view
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
                    color: secondAppColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.isHomeScreen ? null : context.push('/');
                              },
                              child: SvgPicture.asset(appTextImage, height: 12),
                            ),
                            // Container(
                            //   width: 2,
                            //   height: 30,
                            //   margin: const EdgeInsets.symmetric(horizontal: 8),
                            //   color: Colors.white,
                            // ),
                            InkWell(
                              onTap: widget.onClick,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        constraints.maxWidth < 500 ? 130 : null,
                                    child: Text(
                                      locationvalue,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primarytextColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: primarytextColor,
                                    // size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            context.push('/search');
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return SearchMainScreen();
                            //     },
                            //   ),
                            // );
                          },
                          child: Container(
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
                                Icon(
                                  Icons.search,
                                  color: Color(0xFF666666),
                                  size: 20,
                                ),
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
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isLoggedInvalue
                                ? InkWell(
                                  onTap: () {
                                    context.push('/settings');
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) {
                                    //       return SettingMainScreen();
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    'My Account',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primarytextColor,
                                    ),
                                  ),
                                )
                                : InkWell(
                                  onTap: () {
                                    context.push('/login');
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) {
                                    //       return SettingMainScreen();
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primarytextColor,
                                    ),
                                  ),
                                ),
                            // const SizedBox(width: 28),
                            InkWell(
                              onTap: () {
                                debugPrint("cart screeen");

                                isLoggedInvalue
                                    ? context.push('/cart')
                                    : context.push('/login');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return CartScreen();
                                //     },
                                //   ),
                                // );
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'My Cart',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF052E16),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: appColor,
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            count.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                    color: secondAppColor,
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
                                  widget.isHomeScreen
                                      ? null
                                      : context.push('/');
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
                                color: primarytextColor,
                              ),
                              InkWell(
                                onTap: widget.onClick,
                                child: Row(
                                  children: [
                                    Text(
                                      location,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primarytextColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: primarytextColor,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              context.push("/search");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return SearchMainScreen();
                              //     },
                              //   ),
                              // );
                            },
                            child: Container(
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
                                  Icon(
                                    Icons.search,
                                    color: Color(0xFF666666),
                                    size: 20,
                                  ),
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              isLoggedInvalue
                                  ? InkWell(
                                    onTap: () {
                                      context.push('/settings');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return SettingMainScreen();
                                      //     },
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      'My Account',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primarytextColor,
                                      ),
                                    ),
                                  )
                                  : InkWell(
                                    onTap: () {
                                      context.push('/login');
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) {
                                      //       return SettingMainScreen();
                                      //     },
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primarytextColor,
                                      ),
                                    ),
                                  ),
                              const SizedBox(width: 28),
                              InkWell(
                                onTap: () {
                                  debugPrint("cart screeen");
                                  isLoggedInvalue == true
                                      ? context.push('/cart')
                                      : context.push('/login');
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return CartScreen();
                                  //     },
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  width: 127,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: appColor),
                                    boxShadow: [
                                      BoxShadow(
                                        color: appColor,
                                        blurRadius: 4,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'My Cart',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primarytextColor,
                                        ),
                                      ),
                                      if (count != 0)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: appColor,
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                              count.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
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
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
