import 'package:flutter/material.dart';
import 'package:selorgweb_main/presentation/home/home_desktop_screen.dart';
import 'package:selorgweb_main/presentation/home/home_screen.dart';
import 'package:selorgweb_main/utils/widgets/responsive.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(mobile: HomeScreen(), desktop: HomeDesktopScreen()),
    );
  }
}
