import 'package:e_commerce/core/models/product.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color_pallet.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

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
                product.productImageListUrl.isNotEmpty
                    ? product.productImageListUrl[0]
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
                    '\$${product.productPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  Text(
                    product.productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        color: ColorPallet.greyColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: 1),
                  ),
                  Text(
                    product.productDescription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        color: ColorPallet.greyColor,
                        letterSpacing: .6),
                  ),
                ],
              ),
            ),

            // Action Buttons - Sized and Flexible
          ],
        ),
      ),
    );
  }
}
