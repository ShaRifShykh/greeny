import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greeny/views/category/category_page.dart';
import 'package:greeny/views/favorite/favorite_page.dart';
import 'package:greeny/views/home/home_page.dart';
import 'package:greeny/views/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _selectIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const FavoritePage(),
    CategoryPage(),
    const ProfilePage(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _screens,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectIndex,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              FontAwesomeIcons.house,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: "Nearby",
          //   icon: Icon(
          //     FontAwesomeIcons.mapLocation,
          //   ),
          // ),
          BottomNavigationBarItem(
            label: "Featured",
            icon: Icon(
              FontAwesomeIcons.solidHeart,
            ),
          ),
          BottomNavigationBarItem(
            label: "Categories",
            icon: Icon(
              Icons.category_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              FontAwesomeIcons.userLarge,
            ),
          ),
        ],
      ),
    );
  }
}
