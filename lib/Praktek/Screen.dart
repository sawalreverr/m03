import 'package:flutter/material.dart';
import '../Praktek/ui/shopping_list_history.dart';
import 'DB/DBhelper.dart';
import 'ItemsScreen.dart';
import 'model/ShoppingList.dart';
import 'ui/shopping_list_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/myProvider.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int id = 0;
  DBHelper db = DBHelper();
  late SharedPreferences sf;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    sf = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var tmp = Provider.of<ListProductProvider>(context, listen: true);
    db.getmyShopingList().then((value) => tmp.setShoppingList = value);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete All',
            onPressed: () {
              var now = DateTime.now().toLocal();
              var tanggal = 'Tanggal: ${now.year}-${now.month}-${now.day}\n';
              var jam = 'Waktu: ${now.hour}.${now.minute}';
              var fix = tanggal + jam;

              addDeleteHistory(fix, sf);
              db.clearAll();
              db
                  .getmyShopingList()
                  .then((value) => tmp.setShoppingList = value);
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount:
              tmp.getShoppingList != null ? tmp.getShoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(tmp.getShoppingList[index].id.toString()),
                onDismissed: (direction) {
                  String tmpName = tmp.getShoppingList[index].name;
                  int tmpId = tmp.getShoppingList[index].id;
                  setState(() {
                    tmp.deleteById(tmp.getShoppingList[index]);
                  });
                  db.deleteShoppingList(tmpId);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$tmpName deleted"),
                  ));
                },
                child: ListTile(
                  title: Text(tmp.getShoppingList[index].name),
                  leading: CircleAvatar(
                    child: Text("${tmp.getShoppingList[index].sum}"),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ItemsScreen(tmp.getShoppingList[index]);
                    }));
                  },
                  trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ShoppingListDialog(db).buildDialog(
                                  context, tmp.getShoppingList[index], false);
                            });
                      }),
                ));
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ShoppingListHistory(sf: sf);
                  },
                );
              },
              child: Icon(Icons.history),
            ),
            Expanded(child: Container()),
            FloatingActionButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return ShoppingListDialog(db).buildDialog(
                          context, ShoppingList(++id, "", 0), true);
                    });
                db
                    .getmyShopingList()
                    .then((value) => tmp.setShoppingList = value);
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  void addDeleteHistory(
      String deletedItem, SharedPreferences sharedPreferences) {
    List<String> deleteHistory =
        sharedPreferences.getStringList('deleteHistory') ?? [];
    deleteHistory.add(deletedItem);
    sharedPreferences.setStringList('deleteHistory', deleteHistory);
  }

  @override
  void dispose() {
    db.closeDB();
    super.dispose();
  }
}
