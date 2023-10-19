import 'package:flutter/material.dart';
import 'Praktek/Screen.dart';
import 'package:provider/provider.dart';
import 'Praktek/Provider/myProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Screen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
