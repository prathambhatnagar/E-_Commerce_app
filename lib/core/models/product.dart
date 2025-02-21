import 'dart:io';

class Product {
  double rating = 0.0;
  double productPrice;
  final String productId;

  @override
  String toString() {
    return 'Product{rating: $rating, productPrice: $productPrice, productId: $productId, productName: $productName, productDescription: $productDescription, category: $category, productImageListUrl: $productImageListUrl}';
  }

  final String productName;
  final String productDescription;
  final String category;
  final List<String> productImageListUrl;
  // final List<File> productImageListFile;

  Product({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.category,
    required this.productImageListUrl,
    // required this.productImageListFile,
    this.rating = 0,
  });
}
