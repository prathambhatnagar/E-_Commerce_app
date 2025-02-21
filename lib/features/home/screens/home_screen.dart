import 'package:e_commerce/core/services/firebase/firestore_product_service/firestore_product_service.dart';
import 'package:e_commerce/core/widgets/product_Image_carousel.dart';
import 'package:e_commerce/core/widgets/product_details.dart';
import 'package:e_commerce/features/home/widgets/Banner_Image_carousel.dart';
import 'package:e_commerce/features/home/widgets/drawer.dart';
import 'package:e_commerce/features/home/widgets/product_tile.dart';
import 'package:e_commerce/features/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/product.dart';
import '../../../core/theme/color_pallet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> productList = Provider.of<List<Product>>(context);
    User? user = Provider.of<User?>(context);
    String? userName =
        user?.displayName?.substring(0, user.displayName?.indexOf(' '));
    String title = userName != null ? 'hey $userName !' : 'Welcome';

    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 800
            ? 3
            : 2;

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  user?.photoURL ??
                      'https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg',
                  height: 40,
                ),
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
        title: Text(
          title,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      // backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deal of The Day',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            BannerImageCarousel(
              imageListUrl: [
                // currently using a static list
                'https://ik.imagekit.io/zisvbncoe/flutter_imagekit/clothingBanner.png?updatedAt=1740074927165',
                'https://ik.imagekit.io/zisvbncoe/flutter_imagekit/flightBanner.png?updatedAt=1740074927168',
                'https://ik.imagekit.io/zisvbncoe/flutter_imagekit/phoneBanner.png?updatedAt=1740074926862',
                'https://ik.imagekit.io/zisvbncoe/flutter_imagekit/bagBanner.png?updatedAt=1740074926798',
                'https://ik.imagekit.io/zisvbncoe/flutter_imagekit/iPhoneBanner.png?updatedAt=1740074926645'
              ],
            ),
            const SizedBox(height: 5),
            Text('${productList.length} Products',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            const SizedBox(height: 5),
            Expanded(
              child: GridView.builder(
                itemCount: productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: screenWidth > 600 ? 0.75 : 0.65,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              product: productList[index],
                            ),
                          ),
                        );
                      },
                      child: ProductTile(product: productList[index]));
                },
              ),
            ),
          ],
        ),
      ),
      drawer: UserDrawer(),
    );
  }
}
