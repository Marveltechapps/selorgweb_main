import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selorgweb_main/order/pages/addressdetails.dart';
import 'package:selorgweb_main/order/pages/faqscreen.dart';
import 'package:selorgweb_main/order/pages/orderdetails.dart';
import 'package:selorgweb_main/order/pages/ordersinsidebar.dart';
import 'package:selorgweb_main/order/pages/profilesection.dart';
import 'package:selorgweb_main/order/provider/navigationprovider.dart';
import 'package:selorgweb_main/utils/widgets/header_widget.dart';
import '../constants/colors.dart';
import '../widgets/account_sidebar_widget.dart';

class MyAccountOrders extends StatefulWidget {
  const MyAccountOrders({super.key});

  @override
  State<MyAccountOrders> createState() => _MyAccountOrdersState();
}

class _MyAccountOrdersState extends State<MyAccountOrders> {
  final List<Widget> pages = [
    Center(child: OrdersList()),
    FAQScreen(),
    Addressdetails(),
    Profilesection(),
    Orderdetails(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).size.width < 991) {
        context.read<Navigationprovider>().updatesectionId(6);
      } else {
        context.read<Navigationprovider>().updatesectionId(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 991;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(
              isHomeScreen: false,
            ),
            SizedBox(height: 0),
            context.watch<Navigationprovider>().sectionId == 6 || isDesktop
                ? SizedBox()
                : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                    // horizontal: isDesktop ? 70 : 10,
                  ),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    elevation: 4,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            context.read<Navigationprovider>().updatesectionId(
                              6,
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                  color: Colors.black87,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 70 : 10),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 1280,
                  maxHeight: isDesktop ? 700 : double.infinity,
                ),
                margin: const EdgeInsets.only(top: 44),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child:
                    isDesktop
                        ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Scrollbar(
                                thumbVisibility: false,
                                child: SingleChildScrollView(
                                  child: AccountSidebarWidget(),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RawScrollbar(
                                padding: EdgeInsets.only(top: 8, right: 2),
                                thumbColor: Color(0xFF034703),
                                radius: Radius.circular(20),
                                thickness: 8,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child:
                                        context
                                                    .read<Navigationprovider>()
                                                    .sectionId ==
                                                6
                                            ? pages[0]
                                            : pages[context
                                                .watch<Navigationprovider>()
                                                .sectionId],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Wrap(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RawScrollbar(
                              padding: EdgeInsets.only(top: 8, right: 2),
                              thumbColor: Color(0xFF034703),
                              radius: Radius.circular(20),
                              thickness: 8,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    context
                                                .watch<Navigationprovider>()
                                                .sectionId ==
                                            6
                                        ? AccountSidebarWidget()
                                        : SizedBox(),
                                    context
                                                .watch<Navigationprovider>()
                                                .sectionId ==
                                            6
                                        ? SizedBox()
                                        : Padding(
                                          padding: const EdgeInsets.all(15),
                                          child:
                                              pages[context
                                                  .watch<Navigationprovider>()
                                                  .sectionId],
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ),
            const SizedBox(height: 156),
          ],
        ),
      ),
    );
  }
}
