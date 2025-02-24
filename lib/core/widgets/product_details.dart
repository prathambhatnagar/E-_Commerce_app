import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/core/widgets/bottom_sheet.dart';
import 'package:e_commerce/core/widgets/product_Image_carousel.dart';
import 'package:e_commerce/features/cart/screens/cart_screen.dart';
import 'package:e_commerce/features/cart/widget/cart_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    FirestoreUserService firestoreUserService =
        FirestoreUserService(user: FirebaseAuth.instance.currentUser);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ProductImageCarousel(product: product),
                  SizedBox(height: 15),
                  Text(
                    "₹ ${product.productPrice}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.productName,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product.productDescription,
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey, letterSpacing: .6),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            CartButton(
              label: 'Buy Now',
              onTap: () {
                showOrderConfirmationBottomSheet(
                  context: context,
                  placeOrder: () async {
                    firestoreUserService.placeOrder([product]);
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
              color: Colors.yellow[800],
            )
          ],
        ),
      ),
    );
  }
}
//
