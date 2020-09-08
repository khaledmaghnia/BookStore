import 'package:book_store/models/Books.dart';
import 'package:book_store/screens/PDFPreviewScreen.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  static const String ROUTE_NAME = "BookDetails";

  List<Widget> ratingBar(int rating) {
    List<Widget> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add(Image.asset(
        "assets/images/${i <= rating ? "star" : "favorites"}.png",
        height: 20,
        width: 20,
      ));
      list.add(SizedBox(
        width: 4,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Books books = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                books.bookTitle,
              ),
              background: Hero(
                tag: books.bookId,
                child: Image.network(
                  books.bookCover,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Rating: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          ...ratingBar(books.rating),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Image.asset("assets/images/book.png", color: Colors.white,),
                                  color: Theme.of(context).accentColor,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(PDFPreviewScreen.ROUTE_NAME, arguments: books.bookPDF);
                                  },
                                ),
                                SizedBox(width: 4,),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child:
                                      Image.asset("assets/images/download.png", color: Colors.white),
                                  color: Theme.of(context).accentColor,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: Container(
                        child: Text(
                          "Description: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                      )),
                      Text(
                        books.bookDescription,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}