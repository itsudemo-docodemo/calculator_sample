import 'package:book_list_sample/book_list/book_list_model.dart';
import 'package:book_list_sample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      //画面を開いたときに最初にfetchBookListを実行する。
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(title: Text('本一覧')),
        body: Center(
          //fetchBookList完了によって発火する。
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;
            //fetchBookList完了まではbooksがNULLなので待ち表示する。
            if (books == null) {
              return CircularProgressIndicator();
            }
            //booksをList<Widget>型に変換する。
            final List<Widget> widgets = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}