import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linh_kien17/navigation/account/sign_up/sign_up.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: Colors.redAccent,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 200,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                CircleAvatar(
                  radius: 100,
                  child: Image.asset(
                    'assets/images/logo_tran_gia.jpg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,

                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey)
                ),
                child: Text("Đăng nhập",style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,

                ),),
              ),
              Text("   |   "),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SignUp()
                  ));
                },
                padding: EdgeInsets.all(0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey)),
                  child: Text("Đăng ký", style: TextStyle(
                  color: Colors.blueAccent,
                    fontSize: 20,)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}