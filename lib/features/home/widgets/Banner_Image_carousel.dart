import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class BannerImageCarousel extends StatelessWidget {
  final List<String>? imageListUrl;

  const BannerImageCarousel({
    super.key,
    required this.imageListUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: CarouselSlider(
        items: imageListUrl?.map((url) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              url,
              fit: BoxFit.fill,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height / 4.8,
          viewportFraction: 1,
          autoPlay: true,
        ),
      ),
    );
  }
}
