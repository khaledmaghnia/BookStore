import 'package:book_store/providers/BooksProvider.dart';
import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/screens/MainCategoryScreen.dart';
import 'package:book_store/screens/SpecificCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create:(ctx)=> CategoriesProvider()),
        ChangeNotifierProvider(
            create:(ctx)=> BooksProvider()),

      ],
      child: MaterialApp(
          title: 'BookStore',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainCategoryScreen(),
          routes: {
            SpecificCategory.ROUTE_NAME: (ctx) => SpecificCategory()
          },
        ),
    );
  }
}
