import 'package:abhedya_flutter_assessment/ui/account_screen.dart';
import 'package:abhedya_flutter_assessment/ui/home_screen.dart';
import 'package:abhedya_flutter_assessment/ui/services_screen.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final String username;
  MainScreen(this.username, {Key? key}) : super(key: key);

  //
  final Map<String, List<String>> bottomIcons = {
    "Home": [SvgAssets.homeOutline, SvgAssets.home],
    "Accounts": [SvgAssets.viewListOutline, SvgAssets.viewList],
    "Services": [SvgAssets.shapeOutline, SvgAssets.shape],
  };
  //
  final _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: [
          HomeScreen(username),
          const AccountScreen(),
          const ServicesScreen()
        ][_currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex.value,
            onTap: (value) {
              _currentIndex.value = value;
            },
            items: [
              for (var entry in bottomIcons.entries)
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(entry.value.last), label: entry.key)
            ])));
  }
}
