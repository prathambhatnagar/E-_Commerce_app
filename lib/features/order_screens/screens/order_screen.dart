import 'package:e_commerce/core/models/product.dart';
import 'package:e_commerce/core/services/firebase/auth_services/user_auth_service.dart';
import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/features/order_screens/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color_pallet.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreUserService firestoreUserService =
        FirestoreUserService(user: FirebaseAuth.instance.currentUser);
    return Scaffold(
      backgroundColor: ColorPallet.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Your Orders',
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: firestoreUserService.orderStream,
            builder: (context, snapshot) {
              List<Product>? productList = snapshot.data;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return (Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty_box2.gif',
                      height: 200,
                      scale: .1,
                    ),
                    Text(
                      'Your haven\'t Placed any Orders Yet ',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                )));
              } else {
                return ListView.builder(
                    itemCount: productList?.length,
                    itemBuilder: (context, index) =>
                        ProductCard(product: productList![index]));
              }
            }),
      ),
    );
  }
}
