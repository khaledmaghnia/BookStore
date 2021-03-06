import 'package:book_store/providers/BooksProvider.dart';
import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/providers/UserProvider.dart';
import 'package:book_store/screens/AuthScreen.dart';
import 'package:book_store/screens/BookDetails.dart';
import 'package:book_store/screens/MainCategoryScreen.dart';
import 'package:book_store/screens/MyUploadedBooks.dart';
import 'package:book_store/screens/PDFPreviewScreen.dart';
import 'package:book_store/screens/PinnedBooks.dart';
import 'package:book_store/screens/SpecificCategory.dart';
import 'package:book_store/screens/SplashScreen.dart';
import 'package:book_store/screens/UploadBookScreen.dart';
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
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProxyProvider<UserProvider, CategoriesProvider>(
          create: (_) => CategoriesProvider(),
          update: (_, myModel, myNotifier) =>
              myNotifier..update(myModel.userData),
        ),
        ChangeNotifierProxyProvider<CategoriesProvider, BooksProvider>(
          create: (_) => BooksProvider(),
          update: (_, myModel, myNotifier) => myNotifier
            ..update(myModel.token, myModel.userID, myModel.categoryList),
        ),
      ],
      child: Consumer<UserProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'BookStore',
          theme: ThemeData(
              primaryColor: Color.fromRGBO(12,5,109, 1.0),
              accentColor: Color.fromRGBO(242,93,156, 1),
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontSize: 20, color: Colors.black))),
          home: auth.isAuth
              ? MainCategoryScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            AuthScreen.ROUTE_NAME: (ctx) => AuthScreen(),
            SpecificCategory.ROUTE_NAME: (ctx) => SpecificCategory(),
            UploadBookScreen.ROUTE_NAME: (ctx) => UploadBookScreen(),
            BookDetails.ROUTE_NAME:(ctx)=> BookDetails(),
            PDFPreviewScreen.ROUTE_NAME:(ctx)=> PDFPreviewScreen(),
            PinnedBooks.ROUTE_NAME:(ctx)=> PinnedBooks(),
            MyUploadedBooks.ROUTE_NAME:(ctx)=> MyUploadedBooks()
          },
        ),
      ),
    );
  }
}
