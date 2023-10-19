import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingListHistory extends StatelessWidget {
  final SharedPreferences sf;

  ShoppingListHistory({required this.sf});

  @override
  Widget build(BuildContext context) {
    List<String> deleteHistory = sf.getStringList('deleteHistory') ?? [];

    return AlertDialog(
      title: Text('History'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: deleteHistory.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: Text(deleteHistory[index]),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            // Hapus history dari SharedPreferences
            sf.remove('deleteHistory');
            Navigator.of(context).pop();
          },
          child: Text('Clear History'),
        ),
      ],
    );
  }
}

void showDeleteHistoryDialog(
    BuildContext context, SharedPreferences sharedPreferences) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ShoppingListHistory(
        sf: sharedPreferences,
      );
    },
  );
}
