import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/screens/tabs/favorite_tab.dart';
import 'package:frontend/screens/tabs/home_tab.dart';
import 'package:frontend/screens/tabs/profile-tab.dart';
import 'package:frontend/screens/tabs/settings.dart';

import '../../themes/theme_default.dart';
import 'navigate_view_model.dart';

class Navigate extends StatelessWidget {
  static const String routeName = "home";

  final String id;
  late final List<Widget> tabs;
  final NavigateViewModel viewModel = NavigateViewModel();

  Navigate({super.key, required this.id}) {
    tabs = [
      HomeTab(userId:id),
      FavoriteScreen(),
      ProfilePage(id: id),
      SettingsPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          body: tabs[viewModel.currentTabIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomAppBar(
              child: BottomNavigationBar(
                backgroundColor: Color(0xff004182),
                unselectedItemColor: paletteLightGrey,
                selectedItemColor: paletteYellow,
                showSelectedLabels: false,
                onTap: (index) {
                  viewModel.changeSelectedTab(index);
                },
                iconSize: 35,
                currentIndex: viewModel.currentTabIndex,
                items: [
                  buildBottomNavIcon(Icons.home, viewModel.currentTabIndex == 0),
                  buildBottomNavIcon(Icons.favorite, viewModel.currentTabIndex == 1),
                  buildBottomNavIcon(Icons.person, viewModel.currentTabIndex == 2),
                  buildBottomNavIcon(Icons.settings, viewModel.currentTabIndex == 3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem buildBottomNavIcon(IconData iconData, bool selected) {
    return BottomNavigationBarItem(
      icon: selected
          ? CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(
          iconData,
          size: 30,
          color: paletteBlue, // Ensure consistency in color
        ),
      )
          : Icon(
        iconData,
        size: 30,
        color: paletteLightGrey, // Ensure consistency in color
      ),
      label: "",
    );
  }
}
