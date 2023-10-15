import 'package:flutter/material.dart';
import 'package:starter/feature/map/ui/map_screen.dart';
import 'package:starter/feature/profile/ui/profile_screen.dart';
import 'package:starter/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [const MapScreen(), const ProfileScreen()];
  int selectedTab = 0;
  onSelectTab(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: pages[selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Карта'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
        onTap: onSelectTab,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primary,
      ),
    ));
  }
}
