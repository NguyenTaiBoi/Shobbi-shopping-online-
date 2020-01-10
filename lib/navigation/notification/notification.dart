import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/boss/notifications/notifications.dart';
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'notification_bloc.dart';

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => NotificationBloc(),
        )
      ],
      child: NotificationBody(),
    );
  }
}

class NotificationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationBloc notificationBloc = Provider.of<NotificationBloc>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Thông báo"),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.local_grocery_store, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Order()
              ));
            },
          )
        ],
      ),
      body: notificationBloc.isLoadingPost
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: notificationBloc.posts.length,
                  itemBuilder: (context, index) {

                    if(notificationBloc.posts[index].categories[0] != 278)
                      return Container();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          notificationBloc.posts[index].title,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        Html(
                          data: notificationBloc.posts[index].content,
                        ),
                        Divider()
                      ],
                    );
                  }),
            ),
    );
  }
}
