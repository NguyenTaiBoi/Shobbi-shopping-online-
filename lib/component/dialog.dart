import 'package:flutter/material.dart';

class DialogLinhKien {
  static void   showDialogLoading({BuildContext context}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // return object of type Dialog
        return AlertDialog(

          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
              ],

          ),
        );
      },
    );
  }

  static void   showDialogError({BuildContext context, String errorMess}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Có lỗi xảy ra"),
          content: new Text(errorMess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}