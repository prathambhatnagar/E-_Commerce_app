import 'package:e_commerce/core/theme/color_pallet.dart';
import 'package:e_commerce/features/cart/screens/cart_screen.dart';
import 'package:e_commerce/features/home/screens/home_screen.dart';
import 'package:e_commerce/features/order_screens/screens/order_screen.dart';
import 'package:e_commerce/features/profile/profile_screen.dart';
import 'package:e_commerce/features/wish_list/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> screen = [
    WishListScreen(),
    CartScreen(),
    HomeScreen(),
    ProfileScreen(),
    OrderScreen()
  ];
  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.whiteColor,
      body: screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 30, color: Colors.black),
        unselectedIconTheme: IconThemeData(size: 25, color: Colors.red),
        selectedFontSize: 15,

        selectedLabelStyle:
            TextStyle(color: Colors.black), // Selected label color
        unselectedLabelStyle:
            TextStyle(color: Colors.grey), // Unselected label color

        onTap: (index) {
          print(index);
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border_outlined,
              color: Colors.grey,
              size: 26,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.grey,
              size: 26,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white70,
            icon: Icon(
              Icons.home,
              color: Colors.grey,
              size: 26,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              color: Colors.grey,
              size: 26,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.grey,
              size: 26,
            ),
            label: 'Orders',
          )
        ],
      ),
    );
  }
}
