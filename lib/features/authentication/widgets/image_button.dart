import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final Function onTap;
  final Image image;
  final String label;

  const ImageButton({
    super.key,
    required this.image,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image,
              ),
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: Colors.black, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
