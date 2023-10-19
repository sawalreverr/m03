import 'package:flutter/material.dart';
import '../DB/DBhelper.dart';
import '../model/ShoppingList.dart';

class ShoppingListDialog {
  DBHelper db;
  ShoppingListDialog(this.db);

  final txtName = TextEditingController();
  final txtSum = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    if (!isNew) {
      txtName.text = list.name;
      txtSum.text = list.sum.toString();
    } else {
      txtName.text = "";
      txtSum.text = "";
    }
    return AlertDialog(
        title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Shopping List Name')),
            TextField(
              controller: txtSum,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Sum'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Save Shopping List'),
                onPressed: () {
                  list.name = txtName.text != "" ? txtName.text : "Empty";
                  list.sum = txtSum.text != "" ? int.parse(txtSum.text) : 0;
                  db.insertShoppingList(list);

                  Navigator.pop(context);
                },
              ),
            ),
          ]),
        ));
  }
}
