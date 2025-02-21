// import 'package:e_commerce/core/models/product.dart';
// import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
// import 'package:e_commerce/core/services/firebase/firestore_product_service/firestore_product_service.dart';
import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/features/cart/widget/cart_button.dart';
import 'package:e_commerce/features/cart/widget/cart_product_list.dart';
import 'package:e_commerce/features/cart/widget/cart_tile.dart';
import 'package:e_commerce/features/home/widgets/drawer.dart';
import 'package:e_commerce/features/home/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../core/models/product.dart';
import '../../../core/theme/color_pallet.dart';
import '../../../core/widgets/bottom_sheet.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final ValueNotifier<double> totalAmountNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier<List<Product>> productListNotifier =
      ValueNotifier<List<Product>>([]);

  @override
  Widget build(BuildContext context) {
    FirestoreUserService firestoreUserService =
        FirestoreUserService(user: FirebaseAuth.instance.currentUser);
    return Scaffold(
      backgroundColor: ColorPallet.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 25, color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            CartProductList(
              totalAmountNotifier: totalAmountNotifier,
              productListNotifier: productListNotifier,
            ),
            const SizedBox(height: 20),
            const Divider(height: 5, color: Colors.grey),
            const SizedBox(height: 20),
            ValueListenableBuilder<double>(
              valueListenable: totalAmountNotifier,
              builder: (context, totalAmount, child) {
                return Text(
                  'Total : \$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                );
              },
            ),
            const SizedBox(height: 20),
            CartButton(
                label: 'Check Out',
                onTap: () async {
                  List<Product> productList = productListNotifier.value;
                  await firestoreUserService.placeOrder(productList);
                  showOrderBottomSheet(context);
                  await firestoreUserService.clearCart();
                },
                color: Colors.grey),
            const SizedBox(height: 20),
          ],
        ),
      ),
      drawer: UserDrawer(),
    );
  }
}
