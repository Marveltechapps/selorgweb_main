import 'package:flutter/material.dart';
import 'package:selorgweb_main/presentation/location/location_desktop_screen.dart';
import 'package:selorgweb_main/presentation/location/location_mobile_screen.dart';
import 'package:selorgweb_main/utils/widgets/responsive.dart';

class LocationMainScreen extends StatelessWidget {
  final String screenType;

  const LocationMainScreen({super.key, required this.screenType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: LocationMobileScreen(screenType: screenType),
        desktop: LocationDesktopScreen(screenType: screenType),
      ),
    );
  }
}
