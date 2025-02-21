import 'dart:io';
import 'package:e_commerce/app_secret/app_secrets.dart';
import 'package:flutter_imagekit/flutter_imagekit.dart';

class ImageKitService {
  Future<List<String>> uploadImages({required List<File> fileList}) async {
    return await Future.wait(
      fileList.map(
        (file) async {
          return await ImageKit.io(file, privateKey: Secrets.pKey);
        },
      ),
    );
  }
}

// Future<List<String>> uploadImages({required List<File> fileList}) async {
//   return await Future.wait(fileList.map((file) async {
//     final response = await _imageInstance.upload(file);
//     return response.url;
//   }).toList());
// }
