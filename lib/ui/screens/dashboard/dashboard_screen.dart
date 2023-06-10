import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/screens/caffe/caffe_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/favorite/favorite_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/setting/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  List<Widget> menuList = [
    const CaffeScreen(),
    const FavoriteScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: menuList[_currentIndex],
    );
  }

  Widget _bottomNavBar() {
    return CustomNavigationBar(
      iconSize: 25,
      selectedColor: primaryColor,
      unSelectedColor: grayColor.withOpacity(0.4),
      strokeColor: primaryColor,
      backgroundColor: Colors.white,
      borderRadius: const Radius.circular(15),
      currentIndex: _currentIndex,
      onTap: (index) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.local_restaurant_rounded),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Caffe",
            style: styleSubtitle,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Favorite",
            style: styleSubtitle,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.settings),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Setting",
            style: styleSubtitle,
          ),
        ),
      ],
    );
  }
}
