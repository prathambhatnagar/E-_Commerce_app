import 'package:e_commerce/core/models/product.dart';
import 'package:e_commerce/features/admin_pannel/admin_pannel.dart';
import 'package:e_commerce/features/authentication/screens/authenticate.dart';
import 'package:e_commerce/features/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/firebase/firestore_product_service/firestore_product_service.dart';
import 'features/bottom_navigation_bar.dart';
import 'features/home/screens/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    if (user != null) {
      return NavigationScreen();
    } else {
      return Authenticate();
    }
  }
}

// StreamProvider<List<Product>>.value(
//   value: FireStoreProductService().productStream,
//   initialData: [],
// );
