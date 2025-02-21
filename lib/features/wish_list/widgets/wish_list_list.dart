import 'package:e_commerce/core/models/product.dart';
import 'package:e_commerce/core/services/firebase/firebase_user_service/firestore_user_service.dart';
import 'package:e_commerce/features/wish_list/widgets/wish_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListList extends StatefulWidget {
  const WishListList({super.key});

  @override
  State<WishListList> createState() => _WishListListState();
}

class _WishListListState extends State<WishListList> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    FirestoreUserService fus = FirestoreUserService(user: user);
    return Expanded(
      child: StreamBuilder(
        stream: FirestoreUserService(user: user).wishListStream,
        builder: (context, snapshot) {
          List<Product>? productList = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || productList!.isEmpty) {
            return Center(child: Text('Nothing Here!'));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return WishListTile(
                  product: productList[index],
                );
              },
            );
          } else {
            return Center(child: Text('Something Went Wrong!'));
          }
        },
      ),
    );
  }
}
