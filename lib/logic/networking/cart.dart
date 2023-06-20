import 'package:flutter/cupertino.dart';

import 'package:food/logic/dish.dart';

class Cart with ChangeNotifier {
  List<Dish> _cartItems = [];
  List<Dish> get cartItems => _cartItems;
  Set<String> _cartUniqueItemsSet = {};
  List<Dish> _cartUniqueItems = [];
  List<Dish> get cartUniqueItems => _cartUniqueItems;
  Map<String, int> _eachItemInCart = {};
  Map<String, int> get eachItemInCart => _eachItemInCart;

  void addToCart(Dish dish) {
    _cartItems.add(dish);
    if (_eachItemInCart.containsKey(dish.name)) {
      _eachItemInCart.update(
          dish.name, (value) => _eachItemInCart[dish.name]! + 1);
    } else {
      _eachItemInCart[dish.name] = 1;
    }
    if (_cartUniqueItemsSet.add(dish.name)) {
      _cartUniqueItemsSet.add(dish.name);
      _cartUniqueItems.add(dish);
    }
    notifyListeners();
  }

  void removeFromCart(Dish dish) {
    if (_eachItemInCart[dish.name]! > 1) {
      _cartItems.remove(dish);
      _eachItemInCart.update(
          dish.name, (value) => _eachItemInCart[dish.name]! - 1);
    } else if (_eachItemInCart[dish.name]! == 1) {
      _cartItems.remove(dish);
      _cartUniqueItems.remove(dish);
      _cartUniqueItemsSet.remove(dish.name);
      _eachItemInCart.remove(dish.name);
    }
    notifyListeners();
  }

  void pay() {
    _cartItems.clear();
    _cartUniqueItemsSet.clear();
    _cartUniqueItems.clear();
    _eachItemInCart.clear();
    notifyListeners();
  }

  int cartSum() {
    int totalSum = 0;
    for (Dish d in _cartItems) {
      totalSum += d.price;
    }
    return totalSum;
  }
}
