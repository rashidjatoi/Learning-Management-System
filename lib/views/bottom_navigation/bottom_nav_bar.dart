import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/provider/home_provider.dart';
import 'package:agriconnect/views/bottom_navigation/custom_bottom_navigation_btn.dart';
import 'package:agriconnect/views/home/home_view.dart';
import 'package:agriconnect/views/job_posting/job_posting_view.dart';
import 'package:agriconnect/views/notifications/notifications_view.dart';
import 'package:agriconnect/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    debugPrint("build");

    var pagesList = [
      const HomeView(),
      const JobPostingView(),
      const NotificationsView(),
      const ProfileView()
    ];

    return Scaffold(
      extendBody: true,
      body: Consumer<HomeProvider>(
          builder: (context, value, child) => pagesList[value.currentIndex]),
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? customThemeColor
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius:
                    Theme.of(context).brightness == Brightness.dark ? 9.3 : 0.9,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<HomeProvider>(
              builder: (context, value, child) => CustomBottomNavigationButton(
                selectedIcon: IconlyBold.home,
                icon: IconlyLight.home,
                onPressed: () {
                  value.changeIndex(0);
                },
                isSelected: value.currentIndex == 0,
              ),
            ),
            Consumer<HomeProvider>(
                builder: (context, value, child) =>
                    CustomBottomNavigationButton(
                      selectedIcon: IconlyBold.search,
                      icon: IconlyLight.search,
                      onPressed: () {
                        value.changeIndex(1);
                      },
                      isSelected: value.currentIndex == 1,
                    )),
            Consumer<HomeProvider>(
              builder: (context, value, child) => CustomBottomNavigationButton(
                selectedIcon: IconlyBold.notification,
                icon: IconlyLight.notification,
                onPressed: () {
                  value.changeIndex(2);
                },
                isSelected: value.currentIndex == 2,
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, value, child) => CustomBottomNavigationButton(
                selectedIcon: IconlyBold.profile,
                icon: IconlyLight.profile,
                onPressed: () {
                  value.changeIndex(3);
                },
                isSelected: value.currentIndex == 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
