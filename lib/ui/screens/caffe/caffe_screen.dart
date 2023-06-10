import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/navigation/navigation_util.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/route/route_list.dart';
import 'package:flutter_caffe_ku/ui/widgets/search/search_item.dart';

class CaffeScreen extends StatelessWidget {
  const CaffeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBar();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(vertical: setWidth(55)),
            child: CustomeAppBar()),
      ),
      body: const CaffeBody(),
    );
  }
}

class CaffeBody extends StatelessWidget {
  const CaffeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: setHeight(20),
          horizontal: setWidth(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => navigate.pushTo(routeCaffeSearch),
              child: SearchItem(
                hintText: "Find Caffe ku",
                controller: controller,
                autoFocus: false,
                enableKeyword: false,
                color: grayColor.withOpacity(0.15),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomeAppBar extends AppBar {
  CustomeAppBar({super.key})
      : super(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: _buildCommerce(),
        );
  static Widget _buildCommerce() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome!',
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(50),
                ),
              ),
              Text(
                "IMAM AKBAR MEGA ANTARIKSA",
                style: styleTitle.copyWith(
                  fontSize: setFontSize(50),
                  color: grayDarkColor,
                ),
              )
            ],
          ),
          Container(
            height: setHeight(110),
            width: setWidth(120),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: primaryCustomSwatch,
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
