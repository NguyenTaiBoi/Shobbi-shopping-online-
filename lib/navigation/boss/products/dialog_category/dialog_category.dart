import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/object/category.dart';

class DialogCategory extends StatefulWidget {
  final List<Category> categorys;
  final Function(List<Category> categorys) onChange;
  const DialogCategory({Key key, this.categorys, this.onChange}) : super(key: key);

  @override
  _DialogCategoryState createState() => _DialogCategoryState();
}

class _DialogCategoryState extends State<DialogCategory> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: new Text("Chọn danh mục"),
      content: SingleChildScrollView(
          child: Column(
            children: buildListCategory(),
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

  List<Widget> buildListCategory() {

    var listReturn = new List<Widget>();
    widget.categorys.forEach((item) {
    if(item.parent == 0) {
      listReturn.add(
          item.parent == 0 ? buildItemCheck(
              item.status ?? false, item.name, item.id) : buildSubCategory(
              item.status ?? false, item.name, item.id)

      );

        widget.categorys.forEach((item2) {
          if(item2.parent == item.id) {
            listReturn.add(
                buildSubCategory(item2.status ?? false, item2.name, item2.id));
          }
        });


    }
    });

    return listReturn;

  }

  Widget buildSubCategory(bool status, String title, int id) {
    return Padding(
      padding: EdgeInsets.only(left: 30,right: 0,bottom: 0,top: 0),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: status,
            onChanged: (status) {
              widget.categorys.forEach((item) {
                if(item.id == id) {
                  item.status = status;
                }

              });

              widget.onChange(widget.categorys);
              setState(() {});
            },
          ),
          Text(title)
        ],
      ),
    );
  }

  Widget buildItemCheck(bool status, String title, int id) {
      return Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: status,
              onChanged: (status) {
                widget.categorys.forEach((item) {
                  if(item.id == id) {
                    item.status = status;
                  }

                });

                widget.onChange(widget.categorys);
                setState(() {});
              },
            ),
            Text(title)
          ],
        ),
      );
  }
}