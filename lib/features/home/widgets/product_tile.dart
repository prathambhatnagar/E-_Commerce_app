import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/core/widgets/bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    FirestoreUserService firestoreUserService =
        FirestoreUserService(user: user);

    return Container(
      height: 280,
      width: 180,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      product.productImageListUrl[0],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 3),
                Text('₹ ' + product.productPrice.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black)),
                Text(product.productName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                Text(
                  product.productDescription,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(.8, -.9),
            child: GestureDetector(
              onTap: () async {
                showWishListBottomSheet(context, product);
                await firestoreUserService.addToWishlist(
                    productId: product.productId);
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                showCartBottomSheet(context, product);
                firestoreUserService.addToCart(productId: product.productId);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
