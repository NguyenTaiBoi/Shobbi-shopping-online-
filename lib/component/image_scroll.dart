import 'package:flutter/material.dart';

class ImageScroll extends StatefulWidget {
  @override
  _ImageScrollState createState() => _ImageScrollState();
}

class _ImageScrollState extends State<ImageScroll>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: TabBarView(
        controller: tabController,
        children: <Widget>[
          Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
                "https://farm3.staticflickr.com/2831/34111331981_80664f28e0_o.jpg"),
          ),
          Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
                "https://farm3.staticflickr.com/2831/34111331981_80664f28e0_o.jpg"),
          ),
          Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
                "https://farm3.staticflickr.com/2831/34111331981_80664f28e0_o.jpg"),
          ),
          Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
                "https://farm3.staticflickr.com/2831/34111331981_80664f28e0_o.jpg"),
          ),
          Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
                "https://farm3.staticflickr.com/2831/34111331981_80664f28e0_o.jpg"),
          ),
          Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
                "https://farm3.staticflickr.com/2831/34111331981_80664f28e0_o.jpg"),
          ),
        ],
      ),
    );
  }
}
