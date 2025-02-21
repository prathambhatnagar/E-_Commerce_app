import 'dart:ffi';

import 'package:e_commerce/core/models/address_model.dart';
import 'package:e_commerce/core/services/firebase/auth_services/user_auth_service.dart';
import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/core/services/geo_location_service/geo_location_service.dart';
import 'package:e_commerce/core/theme/color_pallet.dart';
import 'package:e_commerce/core/widgets/bottom_sheet.dart';
import 'package:e_commerce/features/home/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../cart/screens/cart_screen.dart';
import '../order_screens/screens/order_screen.dart';
import '../wish_list/screens/wish_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    FirebaseAuthService authService = FirebaseAuthService();
    FirestoreUserService firestoreUserService =
        FirestoreUserService(user: user);
    LocationService locationService = LocationService();
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Profile', style: TextStyle(color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Card(
              color: ColorPallet.backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.network(user?.photoURL ??
                          'https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg'),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user?.displayName ?? 'Name Not Available',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            user?.email ?? 'Email Not Available',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            user?.phoneNumber ?? '',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_4_outlined,
                              size: 30, color: Colors.black),
                          Text('  Your Details',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey.shade400),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 30, color: Colors.black),
                          Text('  Cart',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey.shade400),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishListScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border_outlined,
                              size: 30, color: Colors.black),
                          Text('  WishList',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey.shade400),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.shopping_bag_outlined,
                              size: 30, color: Colors.black),
                          Text('  Orders',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey.shade400),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () async {
                        await locationService.requestPermission();
                        Address address = await locationService.getLocation();
                        await firestoreUserService.setAddress(address);
                        showAddressBottomSheet(context, address);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 30, color: Colors.black),
                          Text('  Address',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    await authService.signOut();
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange)),
            )
          ],
        ),
      ),
      drawer: UserDrawer(),
    );
  }
}
