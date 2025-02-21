import 'package:flutter/material.dart';

class Loading {
  static showLoading(BuildContext context, String label) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(height: 20),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
