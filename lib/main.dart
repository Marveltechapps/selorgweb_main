import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selorgweb_main/order/provider/navigationprovider.dart';
import 'package:selorgweb_main/presentation/banner/banner_screen.dart';
import 'package:selorgweb_main/presentation/cart/cart_screen.dart';
import 'package:selorgweb_main/presentation/entry/login/login_screen.dart';
import 'package:selorgweb_main/presentation/entry/otp/otp_screen.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
// import 'package:selorgweb_main/presentation/home/home_desktop_screen.dart';
import 'package:selorgweb_main/presentation/home/home_main_screen.dart';
import 'package:selorgweb_main/presentation/productdetails/product_details_screen.dart';
import 'package:selorgweb_main/presentation/productlist/product_list_main_screen.dart';
import 'package:selorgweb_main/presentation/search/search_main_screen.dart';
import 'package:selorgweb_main/presentation/settings/customer_support/customer_support_mobile_screen.dart';
import 'package:selorgweb_main/presentation/settings/general_info/general_info_mobile_screen.dart';
import 'package:selorgweb_main/presentation/settings/general_info/privacy_policy_mobile_screen.dart';
import 'package:selorgweb_main/presentation/settings/general_info/terms_conditions_mobile_screen.dart';
import 'package:selorgweb_main/presentation/settings/order/order_mobile_screen.dart';
import 'package:selorgweb_main/presentation/settings/setting_main_screen.dart';
import 'package:selorgweb_main/utils/constant.dart';

import 'package:selorg/presentation/home/home_screen.dart';
import 'package:selorg/presentation/category/categories_screen.dart';
import 'package:selorg/presentation/coupon/screens/applying_coupon_screen.dart';
// import 'package:selorg/presentation/entry/login/login_screen.dart';
import 'package:selorg/presentation/entry/splash/splash_screen.dart';
import 'package:selorg/presentation/payment/payment_screen.dart';
import 'package:selorg/presentation/settings/address/address_screen.dart';
import 'package:selorg/presentation/settings/customer_support/customer_support_screen.dart';
import 'package:selorg/presentation/settings/general_info/general_policies_screen.dart';
import 'package:selorg/presentation/settings/general_info/privacy_policy_screen.dart';
import 'package:selorg/presentation/settings/general_info/terms_conditions_screen.dart';
import 'package:selorg/presentation/settings/notifications/notifications_screen.dart';
import 'package:selorg/presentation/settings/order/order_screen.dart';
import 'package:selorg/presentation/settings/payment_management/payment_management_screen.dart';
import 'package:selorg/presentation/settings/profile/profile_screen.dart';
import 'package:selorg/presentation/settings/refunds/refunds_screen.dart';
import 'package:selorg/presentation/settings/settings_screen.dart';
import 'package:selorg/utils/constant.dart' as selorg_constants;
// import 'package:selorg/presentation/entry/otp/otp_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('💥 Flutter error: ${details.exception}');
    debugPrint('📌 Stack trace: ${details.stack}');
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeMainScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingMainScreen(),
      ),
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrderMobileScreen(),
      ),
      GoRoute(
        path: '/customersupport',
        name: 'customersupport',
        builder: (context, state) => const CustomerSupportMobileScreen(),
      ),
      GoRoute(
        path: '/generalinfo',
        name: 'generalinfo',
        builder: (context, state) => const GeneralInfoMobileScreen(),
      ),
      GoRoute(
        path: '/privacypolicy',
        name: 'privacypolicy',
        builder: (context, state) => const PrivacyPolicyMobileScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) => OtpScreen(),
      ),
      GoRoute(
        path: '/terms&conditions',
        name: 'terms&conditions',
        builder: (context, state) => const TermsConditionsMobileScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) {
          final searchTitle = state.uri.queryParameters['searchTitle'] ?? '';
          return SearchMainScreen(searchTitle: searchTitle);
        },
      ),
      GoRoute(
        path: '/banner',
        builder: (context, state) {
          final bannerId = state.uri.queryParameters['bannerId'] ?? '';
          return BannerScreen(bannerId: bannerId);
        },
      ),
      GoRoute(
        path: '/productdetail',
        builder: (context, state) {
          final productId = state.uri.queryParameters['productId'] ?? '';
          final screenType = state.uri.queryParameters['screenType'] ?? '';
          return ProductDetailsScreen(
            productId: productId,
            screenType: screenType,
          );
        },
      ),
      GoRoute(
        path: '/productslistscreen',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? '';
          final id = state.uri.queryParameters['id'] ?? '';
          final bool isMainCategory = ['true', '1'].contains(
            state.uri.queryParameters['isMainCategory']?.toLowerCase(),
          );
          final mainCatId = state.uri.queryParameters['mainCatId'] ?? '';
          final bool isCategory = [
            'true',
            '1',
          ].contains(state.uri.queryParameters['isCategory']?.toLowerCase());
          final catId = state.uri.queryParameters['catId'] ?? '';
          return ProductListMainScreen(
            title: title,
            id: id,
            isMainCategory: isMainCategory,
            mainCatId: mainCatId,
            isCategory: isCategory,
            catId: catId,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return MaterialApp(
            title: 'SelOrg',
            debugShowCheckedModeBanner: false,

            // ✅ Locks text and display scale
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child!,
              );
            },

            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFFAFAFA),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromRGBO(3, 71, 3, 1),
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 4,
              ),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: selorg_constants.appColor,
                selectionColor: selorg_constants.appColor,
                selectionHandleColor: selorg_constants.appColor,
              ),
              textTheme: const TextTheme(
                titleMedium: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                labelMedium: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                bodySmall: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: Colors.black,
                ),
                displayMedium: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Colors.black,
                ),
                bodyMedium: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Colors.white,
                ),
                bodyLarge: TextStyle(
                  fontFamily: "Poppins Bold",
                  fontSize: 30,
                  color: Colors.white,
                  height: 1,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            initialRoute: '/',
            routes: {
              '/login': (context) => LoginScreen(),
              '/otp': (context) => OtpScreen(),
              '/home': (context) => HomeScreen(),
              '/categories': (context) => CategoriesScreen(),
              '/payment': (context) => PaymentScreen(),
              '/ApplyingCouponScreen': (context) => ApplyingCouponScreen(),
              '/settings': (context) => SettingsScreen(),
              '/order': (context) => OrderScreen(),
              '/customerSupport': (context) => CustomerSupportScreen(),
              '/address': (context) => AddressScreen(),
              '/refunds': (context) => RefundsScreen(),
              '/profile': (context) => ProfileScreen(),
              '/generalPolicies': (context) => GeneralPoliciesScreen(),
              '/termsAndConditions': (context) => TermsConditionsScreen(),
              '/privacyPolicy': (context) => PrivacyPolicyScreen(),
              '/notifications': (context) => NotificationsScreen(),
              '/paymentManagementScreen':
                  (context) => PaymentManagementScreen(),
            },

            home: SplashScreen(),
          );
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => Navigationprovider()),
            ],
            child: LayoutBuilder(
              builder: (context, constraints) {
                return BlocProvider(
                  create: (context) => CounterCubit(),
                  child: MaterialApp.router(
                    routerConfig: router,
                    debugShowCheckedModeBanner: false,
                    title: 'Selorg',
                    theme: ThemeData(
                      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Color.fromRGBO(3, 71, 3, 1),
                        iconTheme: IconThemeData(color: Colors.white),
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        elevation: 4,
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: appColor,
                        selectionColor: appColor,
                        selectionHandleColor: appColor,
                      ),
                      textTheme: const TextTheme(
                        titleMedium: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        labelMedium: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                        bodySmall: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        displayMedium: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        bodyMedium: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        bodyLarge: TextStyle(
                          fontFamily: "Poppins Bold",
                          fontSize: 30,
                          color: Colors.white,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    //  home: HomeMainScreen(),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
