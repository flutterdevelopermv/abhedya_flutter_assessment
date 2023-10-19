import 'package:abhedya_flutter_assessment/ui/views/d_accounts/account_screen.dart';
import 'package:abhedya_flutter_assessment/ui/views/c_home/home_screen.dart';
import 'package:abhedya_flutter_assessment/ui/views/e_services/services_screen.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
        body: [
          HomeScreen(username),
          const AccountScreen(),
          const ServicesScreen()
        ][currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              currentIndex = value;
            },
            items: [
              for (var entry in bottomIcons.entries)
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(entry.value.last), label: entry.key)
            ]));
  }
}
