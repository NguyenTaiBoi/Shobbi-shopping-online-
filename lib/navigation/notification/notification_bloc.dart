import 'package:flutter/foundation.dart';
import 'package:linh_kien17/object/post.dart';

class NotificationBloc extends ChangeNotifier {
  List<Post> posts;
  bool isLoadingPost;

  NotificationBloc() {
    posts = [];
    isLoadingPost = true;
    getPost();
  }

  void getPost() {
    Post post = new Post();
    post.getListPosts().then((data) {
      posts = data;

      isLoadingPost = false;
      notifyListeners();
    });
  }
}