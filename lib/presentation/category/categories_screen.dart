import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/model/category/category_model.dart';
import 'package:selorgweb_main/model/category/main_category_model.dart';
import 'package:selorgweb_main/presentation/category/category_bloc.dart';
import 'package:selorgweb_main/presentation/category/category_event.dart';
import 'package:selorgweb_main/presentation/category/category_state.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_menu.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:selorgweb_main/widgets/bottom_app_bar_widget.dart';
import 'package:selorgweb_main/widgets/bottom_categories_bar_widget.dart';
import 'package:selorgweb_main/widgets/bottom_image_widget.dart';
import 'package:selorgweb_main/widgets/header_widget.dart';
import 'package:selorgweb_main/widgets/network_image.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static List<Category> categories = [];
  static MainCategory mainCategory = MainCategory();

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width < 991;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is MainCategoryLoadedState) {
            debugPrint("mainCategoryLoaded");
            mainCategory = state.mainCategory;
          } else if (state is CategoryLoadedState) {
            debugPrint("CategoryLoadedState");
            categories = state.categories;
          } else if (state is CategoryErrorState) {
            debugPrint("CategoryErrorState");
          }
        },
        builder: (context, state) {
          if (state is CategoryInitialState) {
            debugPrint("CategoryInitialState");
            context.read<CategoryBloc>().add(GetMainCategoryDataEvent());
            context.read<CategoryBloc>().add(GetCategoryDataEvent());
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  HeaderWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 60,
                    ),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Explore by Categories',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                              ),
                            ),
                            // if (mainCategory.data != null)
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) {
                            //           return CategoriesScreen();
                            //         },
                            //       ),
                            //     );
                            //   },
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         'See All',
                            //         style: GoogleFonts.poppins(
                            //           fontSize: 13,
                            //           fontWeight: FontWeight.w600,
                            //           color: Color(0xFF034703),
                            //         ),
                            //       ),
                            //       const SizedBox(width: 6),
                            //       Icon(
                            //         Icons.arrow_forward_ios_rounded,
                            //         size: 14,
                            //         color: appColor,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        // Row(
                        //   spacing: 16,
                        //   children: [
                        //     if (mainCategory.data != null)
                        //       for (
                        //         int i = 0;
                        //         i < mainCategory.data!.length;
                        //         i++
                        //       )
                        //         Expanded(
                        //           child: InkWell(
                        //             onTap: () {
                        //               // Navigator.push(
                        //               //   context,
                        //               //   MaterialPageRoute(
                        //               //     builder:
                        //               //         (context) =>
                        //               //             ProductListMenuScreen(
                        //               //               title:
                        //               //                   mainCategory
                        //               //                       .data![i]
                        //               //                       .name ??
                        //               //                   "",
                        //               //               id:
                        //               //                   mainCategory
                        //               //                       .data![i]
                        //               //                       .id ??
                        //               //                   "",
                        //               //               isMainCategory:
                        //               //                   true,
                        //               //               mainCatId:
                        //               //                   mainCategory
                        //               //                       .data![i]
                        //               //                       .id ??
                        //               //                   "",
                        //               //               isCategory: false,
                        //               //               catId: "",
                        //               //             ),
                        //               //   ),
                        //               // );
                        //             },
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   height: 130,
                        //                   decoration: BoxDecoration(
                        //                     color: const Color(0xFFE5EEC3),
                        //                     borderRadius:
                        //                         BorderRadius.circular(5),
                        //                     boxShadow: [
                        //                       BoxShadow(
                        //                         color: greyColor,
                        //                         blurRadius: 4,
                        //                         offset: const Offset(0, 0),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   // child: Center(
                        //                   //   child: Image.network(
                        //                   //     mainCategory
                        //                   //             .data![i]
                        //                   //             .imageUrl ??
                        //                   //         "",
                        //                   //     fit: BoxFit.contain,
                        //                   //   ),
                        //                   // ),
                        //                 ),
                        //                 const SizedBox(height: 8),
                        //                 Text(
                        //                   mainCategory.data![i].name ?? "",
                        //                   textAlign: TextAlign.center,
                        //                   style: const TextStyle(
                        //                     fontSize: 13,
                        //                     fontWeight: FontWeight.w600,
                        //                     color: Color(0xFF222222),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //   ],
                        // ),
                        isTablet
                            ? Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    // width: 130,
                                    //  color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 16,
                                      children: [
                                        if (mainCategory.data != null)
                                          for (
                                            int i = 0;
                                            i < mainCategory.data!.length;
                                            i++
                                          )
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      mainCategory
                                                          .data![i]
                                                          .name ??
                                                      "";
                                                  id =
                                                      mainCategory
                                                          .data![i]
                                                          .id ??
                                                      "";
                                                  isMainCategory = true;
                                                  mainCatId =
                                                      mainCategory
                                                          .data![i]
                                                          .id ??
                                                      "";
                                                  isCategory = false;
                                                  catId = "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                mainCategory
                                                                    .data![i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                mainCategory
                                                                    .data![i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                true,
                                                            mainCatId:
                                                                mainCategory
                                                                    .data![i]
                                                                    .id ??
                                                                "",
                                                            isCategory: false,
                                                            catId: "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      width: null,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                mainCategory
                                                                    .data![i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      mainCategory
                                                              .data![i]
                                                              .name ??
                                                          "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    // width: 130,
                                    // color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        if (categories.isNotEmpty)
                                          for (int i = 0; i < 3; i++)
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      categories[i].name ?? "";
                                                  id = categories[i].id ?? "";
                                                  isMainCategory = false;
                                                  mainCatId = "";
                                                  isCategory = true;
                                                  catId =
                                                      categories[i].id ?? "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                categories[i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                false,
                                                            mainCatId: "",
                                                            isCategory: true,
                                                            catId:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      width: null,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                categories[i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      categories[i].name ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    // width: 130,
                                    //  color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 16,
                                      children: [
                                        if (mainCategory.data != null)
                                          for (
                                            int i = 0;
                                            i < mainCategory.data!.length;
                                            i++
                                          )
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      mainCategory
                                                          .data![i]
                                                          .name ??
                                                      "";
                                                  id =
                                                      mainCategory
                                                          .data![i]
                                                          .id ??
                                                      "";
                                                  isMainCategory = true;
                                                  mainCatId =
                                                      mainCategory
                                                          .data![i]
                                                          .id ??
                                                      "";
                                                  isCategory = false;
                                                  catId = "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                mainCategory
                                                                    .data![i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                mainCategory
                                                                    .data![i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                true,
                                                            mainCatId:
                                                                mainCategory
                                                                    .data![i]
                                                                    .id ??
                                                                "",
                                                            isCategory: false,
                                                            catId: "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      width: null,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                mainCategory
                                                                    .data![i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      mainCategory
                                                              .data![i]
                                                              .name ??
                                                          "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    // width: 130,
                                    // color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        if (categories.isNotEmpty)
                                          for (int i = 0; i < 3; i++)
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      categories[i].name ?? "";
                                                  id = categories[i].id ?? "";
                                                  isMainCategory = false;
                                                  mainCatId = "";
                                                  isCategory = true;
                                                  catId =
                                                      categories[i].id ?? "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                categories[i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                false,
                                                            mainCatId: "",
                                                            isCategory: true,
                                                            catId:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      width: null,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                categories[i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      categories[i].name ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        isTablet
                            ? Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    // width: 130,
                                    //   color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        if (categories.isNotEmpty)
                                          for (int i = 3; i < 6; i++)
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      categories[i].name ?? "";
                                                  id = categories[i].id ?? "";
                                                  isMainCategory = false;
                                                  mainCatId = "";
                                                  isCategory = true;
                                                  catId =
                                                      categories[i].id ?? "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                categories[i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                false,
                                                            mainCatId: "",
                                                            isCategory: true,
                                                            catId:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      // width: 130,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                categories[i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      categories[i].name ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    // width: 130,
                                    //   color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        if (categories.isNotEmpty)
                                          for (
                                            int i = 6;
                                            i < categories.length;
                                            i++
                                          )
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      categories[i].name ?? "";
                                                  id = categories[i].id ?? "";
                                                  isMainCategory = false;
                                                  mainCatId = "";
                                                  isCategory = true;
                                                  catId =
                                                      categories[i].id ?? "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                categories[i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                false,
                                                            mainCatId: "",
                                                            isCategory: true,
                                                            catId:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      // width: 130,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                categories[i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      categories[i].name ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    width: 130,
                                    //   color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        if (categories.isNotEmpty)
                                          for (int i = 3; i < 6; i++)
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      categories[i].name ?? "";
                                                  id = categories[i].id ?? "";
                                                  isMainCategory = false;
                                                  mainCatId = "";
                                                  isCategory = true;
                                                  catId =
                                                      categories[i].id ?? "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                categories[i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                false,
                                                            mainCatId: "",
                                                            isCategory: true,
                                                            catId:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      // width: 130,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                categories[i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      categories[i].name ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    // height: 150,
                                    width: 130,
                                    //   color: redColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 20,
                                      children: [
                                        if (categories.isNotEmpty)
                                          for (
                                            int i = 6;
                                            i < categories.length;
                                            i++
                                          )
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  title =
                                                      categories[i].name ?? "";
                                                  id = categories[i].id ?? "";
                                                  isMainCategory = false;
                                                  mainCatId = "";
                                                  isCategory = true;
                                                  catId =
                                                      categories[i].id ?? "";
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => ProductListMenuScreen(
                                                            title:
                                                                categories[i]
                                                                    .name ??
                                                                "",
                                                            id:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                            isMainCategory:
                                                                false,
                                                            mainCatId: "",
                                                            isCategory: true,
                                                            catId:
                                                                categories[i]
                                                                    .id ??
                                                                "",
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 130,
                                                      // width: 130,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFE5EEC3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: greyColor,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageNetworkWidget(
                                                            url:
                                                                categories[i]
                                                                    .imageUrl ??
                                                                "",
                                                            height: 100,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      categories[i].name ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                  SizedBox(height: 40),
                  BottomImageWidget(),
                  BottomCategoriesBarWidget(),
                  BottomAppBarWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
