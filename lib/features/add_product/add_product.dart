import 'dart:io';
import 'package:e_commerce/core/services/firebase/firestore_product_service/firestore_product_service.dart';
import 'package:e_commerce/core/services/image_kit_io_service/Image_kit_service.dart';
import 'package:e_commerce/core/services/system_resource/image_picker_service/media_picker_service.dart';
import 'package:e_commerce/core/utility/id_generator.dart';
import 'package:e_commerce/core/widgets/loading.dart';
import 'package:e_commerce/features/authentication/widgets/gradient_button.dart';
import 'package:e_commerce/features/authentication/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/models/product.dart';
import '../authentication/widgets/auth_form_field.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;
  FireStoreProductService fireStoreProductService = FireStoreProductService();
  List<File> imageListFile = [];
  List<String> imageListUrl = [];

  MediaPickerService mediaPicker = MediaPickerService();
  ImageKitService imageKitService = ImageKitService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Product product;

  String? selectedCate;

  final TextEditingController _pNameController = TextEditingController();
  final TextEditingController _pDescController = TextEditingController();
  final TextEditingController _pPriceController = TextEditingController();
  final TextEditingController _pCategoryeController = TextEditingController();

  final List<String> categories = [
    "Electronics",
    "Fashion",
    "Beauty & Personal Care",
    "Home & Kitchen",
    "Grocery & Essentials",
    "Health & Wellness",
    "Baby & Kids",
    "Sports & Outdoor",
    "Books & Stationery",
    "Automotive",
    "Pet Supplies"
  ];

  @override
  void dispose() {
    _pNameController.dispose();
    _pDescController.dispose();
    _pPriceController.dispose();
    _pCategoryeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add a new Product'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  imageListFile = await mediaPicker.pickImages();
                  if (imageListFile.isNotEmpty) {
                    image = imageListFile[0];
                    setState(() {});
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: image != null
                        ? Image.file(image!, fit: BoxFit.cover)
                        : Image.asset('assets/images/add_image.png',
                            fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    AuthFormField(
                        label: ' Name',
                        textController: _pNameController,
                        validator: (value) {
                          if (value == null || value == '') {
                            return "Enter a valid value";
                          }
                          return null;
                        }),
                    SizedBox(height: 10),
                    AuthFormField(
                        label: ' Price',
                        textController: _pPriceController,
                        inputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value == '') {
                            return "Enter a valid value";
                          }
                          return null;
                        }),
                    SizedBox(height: 10),
                    AuthFormField(
                      lines: 3,
                      label: ' Description',
                      textController: _pDescController,
                      validator: (value) {
                        if (value == null || value == '') {
                          return "Enter a valid value";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        padding: EdgeInsets.all(10),
                        hint: Text(" Select Category"),
                        value: selectedCate,
                        isExpanded: true,
                        items: categories
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text('   $value'),
                                ))
                            .toList(),
                        onChanged: (value) {
                          selectedCate = value;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              GradientButton(
                title: 'Submit',
                onTap: () async {
                  Loading.showLoading(context, 'Uploading files...');
                  try {
                    imageListUrl = await imageKitService.uploadImages(
                        fileList: imageListFile);
                    if (_formKey.currentState!.validate() &&
                        selectedCate != null) {
                      product = Product(
                        productName: _pNameController.text,
                        productDescription: _pDescController.text,
                        productPrice: double.parse(_pPriceController.text),
                        productId: IdGenerator.genId(8),
                        productImageListUrl: imageListUrl,
                        category: selectedCate!,
                      );
                      await fireStoreProductService.addProduct(product);
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print('Error' + e.toString());
                    }
                    CustomSnackBar.showCustomSnackBar(
                        color: Colors.orange,
                        context: context,
                        content: 'Something Went Wrong While Uploading');
                  }
                  Navigator.of(context).pop();
                  if (kDebugMode) print(product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
