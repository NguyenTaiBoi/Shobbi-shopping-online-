import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linh_kien17/navigation/notification/notification.dart' as prefix0;
import 'package:linh_kien17/navigation/order/order.dart';
import 'package:provider/provider.dart';

import 'fix_bloc.dart';

class Fix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => FixBloc(),)
      ],
      child: FixBody(),
    );
  }
}

class FixBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FixBloc fixBloc = Provider.of<FixBloc>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Điền thông tin máy"),
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
      body: fixBloc.isSent ? buildSent() : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (hh){
                        fixBloc.checkMade();
                      },
                      controller: fixBloc.textEditingControllerMade,
                      decoration: InputDecoration(
                          errorText: fixBloc.madeErr,
                          labelText: "Hãng máy"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (hh){
                        fixBloc.checkName();
                      },
                      controller: fixBloc.textEditingControllerName,
                      decoration: InputDecoration(
                          errorText: fixBloc.nameErr,
                          labelText: "Tên máy"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (hh){
                        fixBloc.checkPhone();
                      },
                      keyboardType: TextInputType.phone,
                      controller: fixBloc.textEditingControllerPhone,
                      decoration: InputDecoration(
                        errorText: fixBloc.phoneErr,
                          labelText: "Số điện thoại của bạn"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (hh){
                        fixBloc.checkAddress();
                      },
                      controller: fixBloc.textEditingControllerAddress,
                      decoration: InputDecoration(
                          errorText: fixBloc.addressErr,
                          labelText: "Địa chỉ"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (hh){
                        fixBloc.checkDetailFix();
                      },
                      controller: fixBloc.textEditingControllerDetailFix,
                      decoration: InputDecoration(
                          errorText: fixBloc.detailFixErr,
                          labelText: "Yêu cầu sửa"
                      ),
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        fixBloc.sendInfoToServer(context);
                      },
                      child: Text("Gửi thông tin sửa chữa",style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSent() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: Icon(Icons.check,size: 30,color: Colors.green,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Ring Shopping",style: TextStyle(
              fontSize: 20,
              color: Colors.blueAccent
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Cảm ơn bạn đã gửi thông tin cho chúng tôi",maxLines: 2,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Chúng tôi sẽ liên hệ lại sớm nhất!",maxLines: 2,),
          ),
        ],

    );
  }
}