import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/models/address_model.dart';
import 'package:e_commerce/core/models/customer.dart';
import 'package:e_commerce/core/models/product.dart';
import 'package:e_commerce/core/services/firebase/firestore_product_service/firestore_product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FirestoreUserService {
  User? user;
  CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('userDate');

  FirestoreUserService({required this.user});

  Future<void> setAddress(Address address) async {
    Map<String, String> addressMap = {
      'name': address.name,
      'postalCode': address.postalCode,
      'subLocality': address.subLocality,
      'street': address.street,
      'locality': address.locality,
    };

    await userCollectionReference
        .doc(user?.uid)
        .set({'address': addressMap}, SetOptions(merge: true));
  }

  Future<void> printCartList() async {
    List<String> cartIdList = [];
    DocumentSnapshot snapshot =
        await userCollectionReference.doc(user?.uid).get();

    if (snapshot.exists) {
      cartIdList = List<String>.from(snapshot.get('cart'));
      print(cartIdList);
    } else {
      print('data not found');
    }
  }

  Stream<List<Product>> get cartStream {
    return userCollectionReference
        .doc(user?.uid)
        .snapshots()
        .asyncMap((userSnap) async {
      if (!userSnap.exists) return [];

      // Get cart product IDs
      List<String> cartIdList = List<String>.from(userSnap.get('cart') ?? []);

      print(cartIdList);
      print('Cart Item Ids Fetched');

      int counter = 0;

      // Fetch all product details in parallel
      List<Future<Product?>> productFutures = cartIdList.map((productId) async {
        // print('Fetching product ${counter++}: $productId');

        try {
          DocumentSnapshot productSnap = await FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .get();

          if (!productSnap.exists) {
            print('Product snapshot for $productId is empty, returning null');
            return null;
          }

          print('Returning product for $productId');
          return Product(
            productId: productSnap.get('productId'),
            productName: productSnap.get('productName'),
            productDescription: productSnap.get('productDescription'),
            productPrice: productSnap.get('productPrice'),
            category: productSnap.get('productCategory'),
            productImageListUrl:
                List<String>.from(productSnap.get('productImageListUrl')),
          );
        } catch (e) {
          print('Error fetching product $productId: $e');
          return null;
        }
      }).toList();

      print('Waiting for ${productFutures.length} product fetches...');

      List<Product?> products =
          await Future.wait(productFutures).catchError((error) {
        print('Error in Future.wait: $error');
        return <Product?>[];
      });

      print('Product Length: ${products.length}');

      return products.whereType<Product>().toList();
    });
  }

  Stream<List<Product>> get wishListStream {
    return userCollectionReference
        .doc(user?.uid)
        .snapshots()
        .asyncMap((userSnap) async {
      if (!userSnap.exists) return [];

      // Get cart product IDs
      List<String> cartIdList =
          List<String>.from(userSnap.get('wishList') ?? []);

      print(cartIdList);
      print('Cart Item Ids Fetched');

      int counter = 0;

      // Fetch all product details in parallel
      List<Future<Product?>> productFutures = cartIdList.map((productId) async {
        print('Fetching product ${counter++}: $productId');

        try {
          DocumentSnapshot productSnap = await FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .get();

          if (!productSnap.exists) {
            print('Product snapshot for $productId is empty, returning null');
            return null;
          }

          print('Returning product for $productId');
          return Product(
            productId: productSnap.get('productId'),
            productName: productSnap.get('productName'),
            productDescription: productSnap.get('productDescription'),
            productPrice: productSnap.get('productPrice'),
            category: productSnap.get('productCategory'),
            productImageListUrl:
                List<String>.from(productSnap.get('productImageListUrl')),
          );
        } catch (e) {
          print('Error fetching product $productId: $e');
          return null;
        }
      }).toList();

      print('Waiting for ${productFutures.length} product fetches...');

      List<Product?> products =
          await Future.wait(productFutures).catchError((error) {
        print('Error in Future.wait: $error');
        return <Product?>[];
      });

      print('Product Length: ${products.length}');

      return products.whereType<Product>().toList();
    });
  }

  // initial data added to fireStore
  Future<void> createUser() async {
    userCollectionReference.doc(user?.uid).set({
      'uid': user?.uid,
      'email': user?.email,
      'name': user?.displayName,
    }, SetOptions(merge: true));
  }

  // Place Order
  Future<void> placeOrder(List<Product> orders) async {
    List<String> productIds = orders.map((order) => order.productId).toList();
    print('Placing order with Product IDs: $productIds');

    await userCollectionReference.doc(user?.uid).set({
      'orders': FieldValue.arrayUnion([
        {
          'ProductId': productIds,
          'Timestamp': Timestamp.now(),
        }
      ])
    }, SetOptions(merge: true));

    print('Order placed.');
  }
// Order Stream

  Stream<List<Product>> get orderStream {
    return userCollectionReference
        .doc(user?.uid)
        .snapshots()
        .asyncMap((userSnap) async {
      if (!userSnap.exists) {
        print("User document does not exist.");
        return [];
      }

      // Get order product IDs
      List<String> orderIdList = [];

      // Iterate through orders to extract all ProductId values
      final orders = userSnap.get('orders') as List<dynamic>;
      for (var order in orders) {
        orderIdList.addAll(List<String>.from(order['ProductId'] ?? []));
      }

      print('Fetched Order IDs: $orderIdList');

      if (orderIdList.isEmpty) {
        print("No orders found.");
        return [];
      }

      // Fetch all product details in parallel
      List<Future<Product?>> productFutures =
          orderIdList.map((productId) async {
        print('Fetching product: $productId');

        try {
          DocumentSnapshot productSnap = await FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .get();

          if (!productSnap.exists) {
            print('Product snapshot for $productId is empty, returning null');
            return null;
          }

          return Product(
            productId: productSnap.get('productId'),
            productName: productSnap.get('productName'),
            productDescription: productSnap.get('productDescription'),
            productPrice: productSnap.get('productPrice'),
            category: productSnap.get('productCategory'),
            productImageListUrl:
                List<String>.from(productSnap.get('productImageListUrl')),
          );
        } catch (e) {
          print('Error fetching product $productId: $e');
          return null;
        }
      }).toList();

      List<Product?> products =
          await Future.wait(productFutures).catchError((error) {
        print('Error in Future.wait: $error');
        return <Product?>[];
      });

      return products.whereType<Product>().toList();
    });
  }

  // Add to WishList
  Future<void> addToWishlist({required String productId}) async {
    userCollectionReference.doc(user?.uid).set({
      'wishList': FieldValue.arrayUnion([productId])
    }, SetOptions(merge: true));
  }

// Remove from WishList
  Future<void> removeFromWishlist({required String productId}) async {
    userCollectionReference.doc(user?.uid).set({
      'wishList': FieldValue.arrayRemove([productId]),
    }, SetOptions(merge: true));
  }

// Add to Cart
  Future<void> addToCart({required String productId}) async {
    userCollectionReference.doc(user?.uid).set({
      'cart': FieldValue.arrayUnion([productId])
    }, SetOptions(merge: true));
  }

// Remove From Cart
  Future<void> removeFromCart({required String productId}) async {
    userCollectionReference.doc(user?.uid).set({
      'cart': FieldValue.arrayRemove([productId])
    }, SetOptions(merge: true));
  }

  Future<void> clearCart() async {
    userCollectionReference
        .doc(user?.uid)
        .set({'cart': []}, SetOptions(merge: true));
  }

  // Get admin creds
  Future<Map<String, String>> getAdminCreds() async {
    DocumentSnapshot credSnap = await FirebaseFirestore.instance
        .collection('adminCreds')
        .doc('creds')
        .get();
    return {
      'userName': credSnap.get('userName'),
      'password': credSnap.get('password')
    };
  }
}
