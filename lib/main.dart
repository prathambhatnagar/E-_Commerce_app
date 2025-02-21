import 'package:e_commerce/core/models/product.dart';
import 'package:e_commerce/core/services/firebase/firestore_product_service/firestore_product_service.dart';
import 'package:e_commerce/core/theme/theme.dart';
import 'package:e_commerce/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/services/firebase/auth_services/user_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuthService authService = FirebaseAuthService();
  FireStoreProductService productService = FireStoreProductService();
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: authService.userStream,
          initialData: null,
        ),
        StreamProvider<List<Product>>.value(
          value: productService.productStream,
          initialData: [],
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
