import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/models/product.dart';

class CartTile extends StatefulWidget {
  final Product product;

  const CartTile({
    super.key,
    required this.product,
  });

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  FirestoreUserService firestoreUserService =
      FirestoreUserService(user: FirebaseAuth.instance.currentUser);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.product.productImageListUrl.isNotEmpty
                    ? widget.product.productImageListUrl[0]
                    : 'https://via.placeholder.com/80', // Placeholder Image
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, _, __) =>
                    const Icon(Icons.error, size: 40, color: Colors.red),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${widget.product.productPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.product.productName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        letterSpacing: 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
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
            SizedBox(
              height: 105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        firestoreUserService.addToWishlist(
                            productId: widget.product.productId);
                        firestoreUserService.removeFromCart(
                            productId: widget.product.productId);
                      },
                      icon: Icon(Icons.favorite, color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () async {
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
                                              .removeFromCart(
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
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
