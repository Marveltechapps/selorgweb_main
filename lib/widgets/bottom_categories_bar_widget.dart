import 'package:flutter/material.dart';
import 'package:selorgweb_main/utils/constant.dart';

class BottomCategoriesBarWidget extends StatelessWidget {
  const BottomCategoriesBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: MediaQuery.of(context).size.width,

      color: whiteColor,
      child: Container(
        constraints: BoxConstraints(maxWidth: 1280),
        // width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 60,
            vertical: 50,
          ),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              SizedBox(height: 5),
              // Wrap(
              //   spacing: 4,
              //   children: [
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Fruits & Vegitables",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Groceries", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Fresh Fruits",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Fresh Veggies",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Leafy Herbs & Seasonings",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Dry Fruits & Nuts",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Dal", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Millets", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Rice & Cereals",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Grains & Pulses",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Seeds", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Whole spices & Seasoning",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Oil", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Honey & Spreads",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Sugar & Jaggery",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Attas & Flours",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Masalas & Powders",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Ghee", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Honey & Spreads",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Salts", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text("Beverages", style: TextStyle(color: blackColor)),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 5,
              //       child: Text(
              //         "Noodles & Vermicelli",
              //         style: TextStyle(color: blackColor),
              //       ),
              //     ),
              //   ],
              // ),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
