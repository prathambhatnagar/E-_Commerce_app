import 'package:e_commerce/features/wish_list/widgets/wish_list_list.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color_pallet.dart';
import '../../home/widgets/drawer.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('WishList',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                letterSpacing: 1,
                color: Colors.white70)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            WishListList(),
          ],
        ),
      ),
      drawer: UserDrawer(),
    );
  }
}
