import 'package:flutter/material.dart';
import 'model/ShoppingList.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  ItemsScreen(this.shoppingList);

  @override
  _ItemsScreenState createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;
  _ItemsScreenState(this.shoppingList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(shoppingList.name)));
  }
}
