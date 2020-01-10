import 'package:flutter/material.dart';
import 'package:linh_kien17/component/colors.dart';

class DialogColor extends StatefulWidget {

  final Map<String, bool> colors;
  final Function onChange;
  const DialogColor({Key key, this.colors, this.onChange}) : super(key: key);
  @override
  _DialogColorState createState() => _DialogColorState();

}

class _DialogColorState extends State<DialogColor> {


  @override
  Widget build(BuildContext context) {

      return AlertDialog(
        title: new Text("Chọn danh mục"),
        content: SingleChildScrollView(
            child: Column(
              children: buildListColor(),
            )
        ),
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
    }

    List<Widget> buildListColor() {

      var listReturn = new List<Widget>();
      widget.colors.forEach((color,status) {

        listReturn.add(buildItemCheck(status,color));
      });

      return listReturn;

    }

    Widget buildItemCheck(bool status, String title) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: status,
              onChanged: (status) {

                widget.colors[title] = status;
                setState(() {});
                widget.onChange();
              },
            ),
            Text(title)
          ],
        ),
      );
    }



}
