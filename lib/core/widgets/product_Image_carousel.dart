import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import 'bottom_sheet.dart';

class ProductImageCarousel extends StatelessWidget {
  final Product product;

  const ProductImageCarousel({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    FirestoreUserService? firestoreUserService =
        user != null ? FirestoreUserService(user: user) : null;

    return Stack(
      children: [
        CarouselSlider(
          items: product.productImageListUrl.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 50),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 1,
            height: MediaQuery.of(context).size.height / 2.5,
            autoPlay: true,
            viewportFraction: 1,
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: GestureDetector(
            onTap: () {
              if (firestoreUserService != null) {
                showWishListBottomSheet(context, product);
                firestoreUserService.addToWishlist(
                    productId: product.productId);
              }
            },
            child: _iconButton(Icons.favorite_border_outlined),
          ),
        ),
        Positioned(
          bottom: 70,
          right: 16,
          child: GestureDetector(
            onTap: () {
              if (firestoreUserService != null) {
                showCartBottomSheet(context, product);
                firestoreUserService.addToCart(productId: product.productId);
              }
            },
            child: _iconButton(Icons.add_shopping_cart),
          ),
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          )
        ],
      ),
      child: Icon(icon, color: Colors.black, size: 26),
    );
  }
}
