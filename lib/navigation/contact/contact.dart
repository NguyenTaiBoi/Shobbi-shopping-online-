import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/notification/notification.dart' as prefix0;
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  launchPhone(String phone) async {
    String url = "tel:"+phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Liên hệ cửa hàng"),
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
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      launch("https://goo.gl/maps/DDvWL6DtAUAjrMbd6");
      },
                    child: Image.asset(
                      'assets/images/map_tran_gia.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Shopping",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.redAccent),
                    )),
                  ),
                  Text(
                      "Địa chỉ: Số 3 – Ngõ 43/2 Đường Văn Tiến Dũng – P Phúc Diễn – Q.Bắc Từ Liêm – Hà Nội."),
                  SizedBox(
                    height: 5,
                  ),

                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) => bottomBank());
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "Tài khoản ngân hàng",
                        ),

                        leading: IconButton(
                          icon: Icon(
                            Icons.account_balance,
                            color: Colors.black54,
                          ),
                          //làm cái hiện ra launchCaller của máy
                        ),
                      ),
                    ),
                  ),


                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) => bottomSelect());
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "Hỗ trợ 24/24h",
                        ),

                        leading: IconButton(
                          icon: Icon(
                            Icons.live_help,
                            color: Colors.black54,
                          ),
                           //làm cái hiện ra launchCaller của máy
                        ),
                      ),
                    ),
                  ),

                  MaterialButton(
                    onPressed: () {
                      launchPhone("0384171717");
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "0384.17.17.17",
                        ),
                        subtitle: Text("Nhân viên 1"),
                        leading: IconButton(
                          icon: Icon(
                            Icons.assignment_ind,
                            color: Colors.green[800],
                          ),
                          onPressed:
                              () {}, //làm cái hiện ra launchCaller của máy
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      launchPhone("0974888181");
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "0974.88.81.81",
                        ),
                        subtitle: Text("Nhân viên 2"),
                        leading: IconButton(
                          icon: Icon(
                            Icons.assignment_ind,
                            color: Colors.green[800],
                          ),
                          onPressed:
                              () {}, //làm cái hiện ra launchCaller của máy
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      launchPhone("0796608888");
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "079.660.8888",
                        ),
                        subtitle: Text("Nhân viên 3"),
                        leading: IconButton(
                          icon: Icon(
                            Icons.assignment_ind,
                            color: Colors.green[800],
                          ),
                          onPressed:
                              () {}, //làm cái hiện ra launchCaller của máy
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomBank() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8,bottom: 32,right: 8,left: 8),
          child: Column(
            children: <Widget>[

              RichText(
                text: TextSpan(

                  style: TextStyle(color: Colors.black, fontSize: 17,height: 2),
                  children: <TextSpan>[
                    TextSpan(text: 'Tên tài khoản: TRẦN ĐỨC THUẬN\n', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '1/ Số TK: 3100.205.23.1951 - Agribank Từ Liêm, HN\n'),
                    TextSpan(text: '2/ Số TK: 0491.0000.43194 - VCB Thăng Long, HN\n'),
                    TextSpan(text: '3/ Số TK: 1902.2991.589.699 - Tecombank Từ Liêm\n'),
                    TextSpan(text: '4/ Số TK: 2171.000.000.4649 - BIDV Từ Liêm\n'),
                    TextSpan(text: '5/ Số TK: 8310.103.104.007 - Mbbank Đông Đô\n'),
                  ],
                ),
              )

//    Text("Tên tài khoản: TRẦN ĐỨC THUẬN");
//
//          1/ Số TK: 3100.205.23.1951 - Agribank Từ Liêm, HN.
//            2/ Số TK: 0491.0000.43194 - VCB Thăng Long, HN .
//            3/ Số TK: 1902.2991.589.699 - Tecombank Từ Liêm
//          4/ Số TK: 2171.000.000.4649 - BIDV Từ Liêm
//          5/ Số TK: 8310.103.104.007 - Mbbank Đông Đô")
            ],
          )
        )
      ],
    );
  }

  Widget bottomSelect() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8,bottom: 32,right: 8,left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  launch("https://zalo.me/0384171717");
                },
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/zalo.png',
                      width: 70.0,
                      height: 70.0,
                      fit: BoxFit.cover,

                    ),
                    Text("Zalo")
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  launchPhone("0384171717");

                },
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green
                      ),
                      child: Icon(Icons.call,size: 40,color: Colors.white,),
                    ),
                    Text("Điện thoại")
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
