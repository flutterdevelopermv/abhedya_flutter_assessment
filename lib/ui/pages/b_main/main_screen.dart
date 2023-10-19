import 'package:abhedya_flutter_assessment/ui/pages/b_main/bloc/main_bloc.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../d_accounts/account_screen.dart';

class MainScreen extends StatelessWidget {
  final String username;
  const MainScreen(this.username, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is BottomBarState) {
            currentIndex = state.index;
          }
          return Scaffold(
              body: MainPageModel.list(username)[currentIndex].page,
              bottomNavigationBar: bottomBar(context, currentIndex));
        },
      ),
    );
  }

  BottomNavigationBar bottomBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (clickedIndex) {
          context.read<MainBloc>().add(BottomBarClickedEvent(clickedIndex));
        },
        items: [
          for (var pageModel in MainPageModel.list(username))
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(pageModel.activeIconName),
                icon: SvgPicture.asset(pageModel.inActiveIconName),
                label: pageModel.name)
        ]);
  }
}

class MainPageModel {
  final Widget page;
  final String name;
  final String activeIconName;
  final String inActiveIconName;

  //
  MainPageModel({
    required this.page,
    required this.name,
    required this.activeIconName,
    required this.inActiveIconName,
  });

  //
  static List<MainPageModel> list(String username) => [
        MainPageModel(
            page: MainScreen(username),
            name: "Home",
            activeIconName: SvgAssets.home,
            inActiveIconName: SvgAssets.homeOutline),
        MainPageModel(
            page: const AccountScreen(),
            name: "Accounts",
            activeIconName: SvgAssets.viewList,
            inActiveIconName: SvgAssets.viewListOutline),
        MainPageModel(
            page: const AccountScreen(),
            name: "Services",
            activeIconName: SvgAssets.shape,
            inActiveIconName: SvgAssets.shapeOutline),
      ];
}
