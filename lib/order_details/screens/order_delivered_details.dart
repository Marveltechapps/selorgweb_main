import 'package:flutter/material.dart';
import 'package:selorgweb_main/presentation/search/search_desktop_screen.dart';
import 'package:selorgweb_main/widgets/header_widget.dart';
import '../widgets/side_navigation.dart';
import '../widgets/order_items.dart';
import '../widgets/bill_summary.dart';
import '../widgets/order_info.dart';

class OrderDeliveredDetails extends StatelessWidget {
  const OrderDeliveredDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 70.0,
                vertical: 44.0,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 991) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 350, child: SideNavigation()),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: const [
                              OrderItems(),
                              SizedBox(height: 10),
                              BillSummary(),
                              SizedBox(height: 10),
                              OrderInfo(),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: const [
                        SideNavigation(),
                        SizedBox(height: 20),
                        OrderItems(),
                        SizedBox(height: 10),
                        BillSummary(),
                        SizedBox(height: 10),
                        OrderInfo(),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
