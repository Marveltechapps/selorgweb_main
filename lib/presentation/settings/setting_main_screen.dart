import 'package:flutter/material.dart';
import 'package:selorgweb_main/presentation/settings/setting_desktop_screen.dart';
import 'package:selorgweb_main/presentation/settings/setting_mobile_screen.dart';
import 'package:selorgweb_main/utils/widgets/responsive.dart';

class SettingMainScreen extends StatelessWidget {
  const SettingMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: SettingsMobileScreen(),
        desktop: SettingDesktopScreen(),
      ),
    );
  }
}
