import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<String> shoppingCart = [];

  void addItemToCart(String itemName) {
    shoppingCart.add(itemName);
    notifyListeners();
  }
}
