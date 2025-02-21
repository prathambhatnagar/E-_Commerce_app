import 'dart:ffi';

class Customer {
  String uid;
  String? phone;
  String? email;
  List<String>? cartList;
  List<String>? wishList;
  // List<Map<String, UnsignedInt>>? cartList;

  Customer({required this.uid});
}
