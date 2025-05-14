import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';

class TopNavigationWidget extends StatelessWidget {
  const TopNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 26),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo Section
              Row(
                children: [
                  SizedBox(
                    width: 185,
                    child: Row(
                      children: [
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/31d4d778479f952ae221f593c1d7e3928c27fd63?placeholderIfAbsent=true', width: 69),
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/c3cae70f28f3f84dc6a299bd39eabd685806a84c?placeholderIfAbsent=true', width: 27),
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/0e8e6b510c3c64945c665bb0aae3521cd04f9b09?placeholderIfAbsent=true', width: 23),
                        Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/16a0d223f778c0286b1ca0ebffbf4c2b166a58b8?placeholderIfAbsent=true', width: 24),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 19),
                    color: const Color(0xFFDEE3CF).withOpacity(0.5),
                  ),
                  const Text(
                    'Lattice Bridge',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              // Search Bar
              Container(
                width: 524,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Row(
                  children: [
                    Image.network('https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/5f7c7f866dbfb3ee292dbd5cbbfb31ff1026a32c?placeholderIfAbsent=true', width: 17, height: 17),
                    const SizedBox(width: 13),
                    const Text(
                      'Search For Products...',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),

              // Account Section
              Row(
                children: [
                  const Text(
                    'My Account',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 29),
                  Container(
                    width: 127,
                    height: 37,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.grey.withOpacity(0.25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'My Cart',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 11),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '6',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}