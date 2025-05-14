import 'package:flutter/material.dart';
import 'package:selorgweb_main/cart/widgets/cart_with_no_address.dart';
import 'package:selorgweb_main/footer/widgets/app_download_section.dart';
import 'package:selorgweb_main/footer/widgets/categories_section.dart';
import 'package:selorgweb_main/footer/widgets/footer_section.dart';
// import 'package:selorgweb_main/widgets/custom_appbar.dart';
import 'package:selorgweb_main/widgets/header_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            CartWithNoAddress(),
            AppDownloadSection(),
            CategoriesSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
