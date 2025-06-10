import 'package:flutter/material.dart';
import 'package:selorgweb_main/presentation/search/search_desktop_screen.dart';
import 'package:selorgweb_main/presentation/search/search_mobile_screen.dart';
import 'package:selorgweb_main/utils/widgets/responsive.dart';

class SearchMainScreen extends StatelessWidget {
  final String? searchTitle;
  const SearchMainScreen({super.key, this.searchTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: SearchMobileScreen(searchTitle: searchTitle),
        desktop: SearchDesktopScreen(searchTitle: searchTitle ?? ''),
      ),
    );
  }
}
