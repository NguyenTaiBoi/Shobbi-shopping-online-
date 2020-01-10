import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/boss/notifications/notifications_bloc.dart';
import 'package:provider/provider.dart';

class Notications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => NoticationsBloc(),
        )
      ],
      child: NoticationsBody(),
    );
  }
}

class NoticationsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoticationsBloc noticationsBloc = Provider.of<NoticationsBloc>(context);
    // TODO: implement build
    if(noticationsBloc.uploaded) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check, size: 50,color: Colors.green,),
          Text("Đã đăng thông báo!", style: TextStyle(color: Colors.black54, fontSize: 20),)
        ],
      );
    }

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: noticationsBloc.textEditingControllerTitle,
          decoration: InputDecoration(labelText: "Tiêu đề"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: noticationsBloc.textEditingControllerContent,
          decoration: InputDecoration(labelText: "Nội dung"),
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: noticationsBloc.isLoadingUpload
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RaisedButton(
                  color: Colors.redAccent,
                  child: Text(
                    "Thêm thông báo",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    noticationsBloc.uploadNotification(title: noticationsBloc.textEditingControllerTitle.text, content: noticationsBloc.textEditingControllerContent.text,
                    onSuccess: () {
noticationsBloc.setUploaded();
                    });
                  },
                ))
    ]);
  }
}
