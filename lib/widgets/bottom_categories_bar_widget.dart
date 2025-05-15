import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selorgweb_main/utils/constant.dart';

class BottomCategoriesBarWidget extends StatelessWidget {
  const BottomCategoriesBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: double.infinity,
      color: whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 60,
          vertical: 50,
        ),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: TextStyle(
                color: blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    // height: 200,
                    width: 200,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Fruits & Vegitables",
                          style: TextStyle(color: blackColor),
                        ),
                        Text("Groceries", style: TextStyle(color: blackColor)),
                        Text(
                          "Fresh Fruits",
                          style: TextStyle(color: blackColor),
                        ),
                        Text(
                          "Fresh Veggies",
                          style: TextStyle(color: blackColor),
                        ),
                        Text(
                          "Leafy Herbs & Seasonings",
                          style: TextStyle(color: blackColor),
                        ),
                        Text(
                          "Dry Fruits & Nuts",
                          style: TextStyle(color: blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    // height: 200,
                    width: 200,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Dal", style: TextStyle(color: blackColor)),
                        Text("Millets", style: TextStyle(color: blackColor)),
                        Text(
                          "Rice & Cereals",
                          style: TextStyle(color: blackColor),
                        ),
                        Text(
                          "Grains & Pulses",
                          style: TextStyle(color: blackColor),
                        ),
                        Text("Seeds", style: TextStyle(color: blackColor)),
                        Text(
                          "Whole spices & Seasoning",
                          style: TextStyle(color: blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    // height: 200,
                    width: 200,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Oil", style: TextStyle(color: blackColor)),
                        Text(
                          "Honey & Spreads",
                          style: TextStyle(color: blackColor),
                        ),
                        Text(
                          "Sugar & Jaggery",
                          style: TextStyle(color: blackColor),
                        ),
                        Text(
                          "Attas & Flours",
                          style: TextStyle(color: blackColor),
                        ),
                        Text(
                          "Masalas & Powders",
                          style: TextStyle(color: blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    // height: 200,
                    width: 200,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Ghee", style: TextStyle(color: blackColor)),
                        Text(
                          "Honey & Spreads",
                          style: TextStyle(color: blackColor),
                        ),
                        Text("Salts", style: TextStyle(color: blackColor)),
                        Text("Beverages", style: TextStyle(color: blackColor)),
                        Text(
                          "Noodles & Vermicelli",
                          style: TextStyle(color: blackColor),
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
}
