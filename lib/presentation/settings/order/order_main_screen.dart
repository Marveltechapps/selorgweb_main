import 'package:flutter/material.dart';
import 'package:selorgweb_main/presentation/settings/order/order_mobile_screen.dart';
import 'package:selorgweb_main/utils/widgets/responsive.dart';

class OrderMainScreen extends StatelessWidget {
  const OrderMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(mobile: OrderMobileScreen(), desktop: SizedBox()),
    );
  }
}
