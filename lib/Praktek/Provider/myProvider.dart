import 'package:flutter/cupertino.dart';

import '../model/ShoppingList.dart';

class ListProductProvider extends ChangeNotifier {
  List<ShoppingList> _shoppingList = [];
  List<ShoppingList> get getShoppingList => _shoppingList;
  set setShoppingList(value) {
    _shoppingList = value;
    notifyListeners();
  }

  void deleteById(ShoppingList) {
    _shoppingList.remove(ShoppingList);
    notifyListeners();
  }
}
