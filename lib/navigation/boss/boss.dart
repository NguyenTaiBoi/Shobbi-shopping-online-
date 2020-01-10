import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/boss/products/products.dart';
import 'package:linh_kien17/navigation/notification/notification.dart' as prefix0;
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boss_tabs.dart';

const username = "admin";
const password = "1236655226";

class Boss extends StatefulWidget {
  @override
  _BossState createState() => _BossState();
}

class _BossState extends State<Boss> {
  TextEditingController textEditingControllerUser = new TextEditingController();

  TextEditingController textEditingControllerPass = new TextEditingController();

  bool hadPush = false;


  @override
  void initState() {
    getInfo();
  }

  void getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usernamePrefs = prefs.getString("username") + "";
    String passwordPrefs = prefs.getString("password") + "";


    textEditingControllerUser.text = usernamePrefs ?? "";
    textEditingControllerPass.text = passwordPrefs ?? "";
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập quản lý"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => prefix0.Notification()
              ));
            },
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo_tran_gia.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            Text(
              "Chỉ dành cho quản trị viên",
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
            TextField(
              controller: textEditingControllerUser,
              decoration: InputDecoration(labelText: "Tài khoản"),
            ),
            TextField(
              controller: textEditingControllerPass,
              decoration: InputDecoration(labelText: "Mật khẩu"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                onPressed: () async {
                  if (textEditingControllerUser.text.toLowerCase() ==
                          username &&
                      password ==
                          textEditingControllerPass.text.toLowerCase()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString(
                        'username', textEditingControllerUser.text);
                    await prefs.setString(
                        'password', textEditingControllerPass.text);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BossTabs()));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}
