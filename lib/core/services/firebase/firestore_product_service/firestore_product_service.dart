import 'package:e_commerce/core/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreProductService {
  CollectionReference productCollectionReference =
      FirebaseFirestore.instance.collection('products');

  CollectionReference getProductCollectionReference() {
    return productCollectionReference;
  }

  Future<void> addProduct(Product product) async {
    await productCollectionReference.doc(product.productId).set(
      {
        'productId': product.productId,
        'productName': product.productName,
        'productPrice': product.productPrice,
        'productDescription': product.productDescription,
        'productCategory': product.category,
        'productImageListUrl': product.productImageListUrl,
      },
    );
  }

  Stream<List<Product>> get productStream {
    return productCollectionReference.snapshots().map(
      (snapShot) {
        return snapShot.docs.map(
          (doc) {
            return Product(
              productId: doc.get('productId'),
              productName: doc.get('productName'),
              productDescription: doc.get('productDescription'),
              productPrice: doc.get('productPrice'),
              category: doc.get('productCategory'),
              productImageListUrl:
                  List<String>.from(doc.get('productImageListUrl')),
            );
          },
        ).toList();
      },
    );
  }

//
}
