import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/models/product.dart';
import '../../../core/widgets/bottom_sheet.dart';

class WishListTile extends StatefulWidget {
  final Product product;

  const WishListTile({
    super.key,
    required this.product,
  });

  @override
  State<WishListTile> createState() => _WishListTileState();
}

class _WishListTileState extends State<WishListTile> {
  FirestoreUserService firestoreUserService =
      FirestoreUserService(user: FirebaseAuth.instance.currentUser);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.product.productImageListUrl.isNotEmpty
                    ? widget.product.productImageListUrl[0]
                    : 'https://via.placeholder.com/80', // Placeholder Image
                width: 105,
                height: 105,
                fit: BoxFit.cover,
                errorBuilder: (context, _, __) =>
                    const Icon(Icons.error, size: 40, color: Colors.red),
              ),
            ),
            const SizedBox(width: 12),

            // Product Details - Expand to prevent overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${widget.product.productPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  Text(
                    widget.product.productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: 1),
                  ),
                  Text(
                    widget.product.productDescription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16, color: Colors.grey, letterSpacing: .6),
                  ),
                ],
              ),
            ),

            // Action Buttons - Sized and Flexible
            SizedBox(
              height: 105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(
                    icon: Icons.add_shopping_cart_rounded,
                    onPressed: () async {
                      await firestoreUserService.addToCart(
                          productId: widget.product.productId);
                      await firestoreUserService.removeFromWishlist(
                          productId: widget.product.productId);
                    },
                  ),
                  _actionButton(
                      icon: Icons.delete,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Are Your Sure  ?',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ))),
                                    GestureDetector(
                                        onTap: () async {
                                          await firestoreUserService
                                              .removeFromWishlist(
                                                  productId:
                                                      widget.product.productId);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}
