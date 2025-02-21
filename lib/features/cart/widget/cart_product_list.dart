import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/product.dart';
import '../../../core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'cart_tile.dart';

class CartProductList extends StatelessWidget {
  final ValueNotifier<double> totalAmountNotifier;
  final ValueNotifier<List<Product>> productListNotifier;

  const CartProductList({
    super.key,
    required this.totalAmountNotifier,
    required this.productListNotifier,
  });

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return Expanded(
      child: StreamBuilder<List<Product>>(
        stream: FirestoreUserService(user: user).cartStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              totalAmountNotifier.value = 0.0;
              productListNotifier.value = [];
            });
            return const Center(child: Text("Nothing Here!"));
          }

          List<Product> productList = snapshot.data!;

          double total =
              productList.fold(0.0, (sum, item) => sum + item.productPrice);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            totalAmountNotifier.value = total;
            productListNotifier.value = productList;
          });

          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return CartTile(product: productList[index]);
            },
          );
        },
      ),
    );
  }
}
