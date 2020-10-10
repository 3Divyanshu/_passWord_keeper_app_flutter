import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

class PasswordGen extends StatefulWidget {
  final bool isBright;
  PasswordGen({Key key, @required this.isBright}) : super(key: key);
  @override
  _PasswordGenState createState() => _PasswordGenState();
}

class _PasswordGenState extends State<PasswordGen> {
  List<String> list = List<String>();

  shuffle() {
    setState(() {
      list.shuffle();
    });
  }

  Random random = Random();
  int keyboard = 10;

  refresh() {
    setState(() {
      list.clear();
    });
  }

  _generateAlpha() {
    setState(() {
      for (int i = 0; i < keyboard; i++) {
        var x = randomAlphaNumeric(10);
        list.add(x);
      }
    });
    shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isBright ? Colors.white : Color.fromRGBO(63, 61, 86, 1.0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        backgroundColor: widget.isBright
            ? Colors.grey[300]
            : Color.fromRGBO(54, 51, 74, 1.0),
        elevation: 5,
        centerTitle: true,
        title: Text(
          "Password Generator",
          style: TextStyle(fontSize: 24, color: Colors.orange),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red, size: 30),
            onPressed: () {
              refresh();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 5.0),
            child: Card(
              elevation: 10,
              color: widget.isBright
                  ? Colors.grey[300]
                  : Color.fromRGBO(86, 84, 118, 1.0),
              child: ListTile(
                title: Text(
                  list[index],
                  style: TextStyle(
                      color: widget.isBright ? Colors.black : Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.content_copy,
                        color:
                            widget.isBright ? Colors.black38 : Colors.orange),
                    onPressed: () {
                      FlutterClipboard.copy(list[index]);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "PassWord Copied",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    }),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _generateAlpha();
          },
          backgroundColor: Colors.orange,
          label: Text("Generate PassWord")),
    );
  }
}
