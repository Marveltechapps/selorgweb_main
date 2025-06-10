import 'package:flutter/material.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_desktop.dart';
import 'package:selorgweb_main/utils/widgets/responsive.dart';

class ProductListMainScreen extends StatelessWidget {
  final String title;
  final String id;
  final bool isMainCategory;
  final String mainCatId;
  final bool isCategory;
  final String catId;
  const ProductListMainScreen({
    super.key,
    required this.title,
    required this.id,
    required this.isMainCategory,
    required this.mainCatId,
    required this.isCategory,
    required this.catId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: ProductListDesktopScreen(
          title: title,
          id: id,
          isMainCategory: isMainCategory,
          mainCatId: mainCatId,
          isCategory: isCategory,
          catId: catId,
        ),
        desktop: ProductListDesktopScreen(
          title: title,
          id: id,
          isMainCategory: isMainCategory,
          mainCatId: mainCatId,
          isCategory: isCategory,
          catId: catId,
        ),
      ),
    );
  }
}
