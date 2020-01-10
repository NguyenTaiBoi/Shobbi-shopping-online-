import 'package:flutter/cupertino.dart';
import 'package:linh_kien17/object/post.dart';

class NoticationsBloc extends ChangeNotifier {
  TextEditingController textEditingControllerTitle;
  TextEditingController textEditingControllerContent;
bool isLoadingUpload;
bool uploaded;
  NoticationsBloc() {
    isLoadingUpload = false;
    uploaded = false;
    textEditingControllerTitle = new TextEditingController();
    textEditingControllerContent = new TextEditingController();
  }

  void uploadNotification({String title, String content, Function onSuccess}) {
    Post post = new Post();
    post.uploadNotification(title, content, onSuccess);
  }

  void setUploaded() {
    uploaded = true;
    notifyListeners();
  }
}