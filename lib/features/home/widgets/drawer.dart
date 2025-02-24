import 'package:e_commerce/core/services/firebase/auth_services/user_auth_service.dart';
import 'package:e_commerce/features/admin_pannel/admin_pannel.dart';
import 'package:e_commerce/features/cart/screens/cart_screen.dart';
import 'package:e_commerce/features/home/screens/home_screen.dart';
import 'package:e_commerce/features/order_screens/screens/order_screen.dart';
import 'package:e_commerce/features/profile/profile_screen.dart';
import 'package:e_commerce/features/wish_list/screens/wish_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/color_pallet.dart';
import '../../add_product/add_product.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return Drawer(
      backgroundColor: ColorPallet.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    user?.photoURL ?? 'assets/images/profile_place_holder.png'),
              ),
              currentAccountPictureSize: Size(75, 75),
              decoration: BoxDecoration(color: Colors.transparent),
              accountName: Text(user?.displayName.toString() ?? 'no name'),
              accountEmail:
                  Text(user?.email.toString() ?? 'email not registered'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Account"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text("Your Orders"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Cart"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_sharp),
              title: Text("Wishlist"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishListScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text("Admin Login ?"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminPannel()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Product"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () async {
                await FirebaseAuthService().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
