import 'package:e_commerce/core/widgets/product_Image_carousel.dart';
import 'package:e_commerce/features/cart/screens/cart_screen.dart';
import 'package:e_commerce/features/cart/widget/cart_button.dart';

import '../models/product.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
            )
          ],
        ),
      ),
    );
  }
}
