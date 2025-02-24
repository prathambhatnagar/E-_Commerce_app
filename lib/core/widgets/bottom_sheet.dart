import 'package:e_commerce/core/models/address_model.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

void showCartBottomSheet(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(top: 20, bottom: 15, left: 15, right: 15),
        height: MediaQuery.of(context).size.height / 4,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Added To Cart",
                  style: TextStyle(fontSize: 25, color: Colors.greenAccent),
                ),
                Icon(Icons.shopping_cart, size: 25)
              ],
            ),
            Card(
              color: Colors.white10,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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
                        errorBuilder: (context, _, __) => const Icon(
                            Icons.error,
                            size: 40,
                            color: Colors.red),
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
                                color: Colors.grey,
                                letterSpacing: .6),
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons - Sized and Flexible
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );

  Future.delayed(
    Duration(seconds: 2),
    () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    },
  );
}

void showWishListBottomSheet(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(top: 20, bottom: 15, left: 15, right: 15),
        height: MediaQuery.of(context).size.height / 4,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Added To Wishlist  ",
                  style: TextStyle(fontSize: 25, color: Colors.greenAccent),
                ),
                Icon(Icons.favorite_sharp, size: 25)
              ],
            ),
            Card(
              color: Colors.white10,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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
                        errorBuilder: (context, _, __) => const Icon(
                            Icons.error,
                            size: 40,
                            color: Colors.red),
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
                                color: Colors.grey,
                                letterSpacing: .6),
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons - Sized and Flexible
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );

  Future.delayed(
    Duration(seconds: 2),
    () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    },
  );
}

void showOrderBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(top: 20, bottom: 15, left: 15, right: 15),
        height: MediaQuery.of(context).size.height / 4,
        width: double.infinity,
        child: Center(
          child: Text('Order Placed'),
        ),
      );
    },
  );

  Future.delayed(
    Duration(seconds: 2),
    () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    },
  );
}

void showAddressBottomSheet(BuildContext context, Address address) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
          padding: EdgeInsets.only(top: 20, bottom: 15, left: 15, right: 15),
          // height: MediaQuery.of(context).size.height / 4,
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your Address has been updated!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(160),
                    },
                    children: [
                      TableRow(
                        children: [
                          Text(
                            'Locality:',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${address.locality}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            'SubLocality:',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${address.subLocality}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            'Street:',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${address.street}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(
                            'Postal Code:',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${address.postalCode}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ));
    },
  );

  Future.delayed(
    Duration(seconds: 2),
    () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    },
  );
}

void showOrderConfirmationBottomSheet({
  required BuildContext context,
  required VoidCallback placeOrder,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(top: 20, bottom: 15, left: 15, right: 15),
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Confirm Order?",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: placeOrder,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
